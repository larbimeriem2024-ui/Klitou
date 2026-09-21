// deno-lint-ignore no-import-prefix
import "jsr:@supabase/functions-js/edge-runtime.d.ts";
// deno-lint-ignore no-import-prefix
import { createClient } from "jsr:@supabase/supabase-js@2";

Deno.serve(async (req) => {
  try {
    // ============================================
    // 1. Setup
    // ============================================
    const supabase = createClient(
      Deno.env.get("SUPABASE_URL")!,
      Deno.env.get("SUPABASE_ANON_KEY")!,
      {
        global: {
          headers: {
            Authorization: req.headers.get("Authorization")!,
          },
        },
      }
    );

    const slickPayApiKey = Deno.env.get("SLICKPAY_API_KEY");
    if (!slickPayApiKey) {
      return new Response(
        JSON.stringify({ error: "SlickPay API key is not configured." }),
        { status: 500, headers: { "Content-Type": "application/json" } }
      );
    }

    // ============================================
    // 2. Check if user is logged in
    // ============================================
    const {
      data: { user },
      error: authError,
    } = await supabase.auth.getUser();

    if (authError || !user) {
      return new Response(
        JSON.stringify({ error: "Unauthorized" }),
        { status: 401, headers: { "Content-Type": "application/json" } }
      );
    }

    // ============================================
    // 3. Get user profile
    // ============================================
    const { data: profile, error: profileError } = await supabase
      .from("profile")
      .select("name, phonen, email, address, slickpay_contact_uuid")
      .eq("user_id", user.id)
      .single();

    if (profileError || !profile) {
      return new Response(
        JSON.stringify({ error: "Profile not found." }),
        { status: 500, headers: { "Content-Type": "application/json" } }
      );
    }

    // ============================================
    // 4. Get cart items
    // ============================================
    const { data: cartItems, error: cartError } = await supabase
      .from("cart")
      .select(`
        *,
        meals (
          name
        )
      `)
      .eq("user_id", user.id);

    if (cartError) {
      return new Response(
        JSON.stringify({ error: cartError.message }),
        { status: 500, headers: { "Content-Type": "application/json" } }
      );
    }

    if (!cartItems || cartItems.length === 0) {
      return new Response(
        JSON.stringify({ error: "Your cart is empty." }),
        { status: 400, headers: { "Content-Type": "application/json" } }
      );
    }

    // ============================================
    // 5. Calculate total
    // ============================================
    const totalPrice = cartItems.reduce((sum, item) => {
      return sum + Number(item.price) * item.quantity;
    }, 0);

    const pickupDate = cartItems[0].date;

  // ============================================
// 6. Create or get SlickPay Contact
// ============================================
let contactUuid = profile.slickpay_contact_uuid;

if (!contactUuid) {
  const nameParts = (profile.name || "Client").trim().split(" ");
  const firstName = nameParts[0] || "Client";
  const lastName = nameParts.slice(1).join(" ") || "User";

  // Generate pure numeric unique RIB (20 digits)
  // deno-lint-ignore no-inner-declarations
  function generateUniqueRib(userId: string): string {
    let numbers = userId.replace(/\D/g, "");
    while (numbers.length < 20) {
      numbers += Math.floor(Math.random() * 10).toString();
    }
    return numbers.substring(0, 20);
  }

  const uniqueRib = generateUniqueRib(user.id);

  const contactRes = await fetch(
    "https://devapi.slick-pay.com/api/v2/users/contacts",
    {
      method: "POST",
      headers: {
        Authorization: `Bearer ${slickPayApiKey}`,
        "Content-Type": "application/json",
        Accept: "application/json",
      },
      body: JSON.stringify({
        title: profile.name || "Client",
        firstname: firstName,
        lastname: lastName,
        email: profile.email || user.email,
        address: profile.address || "Algeria",
        rib: uniqueRib, // now pure numbers
      }),
    }
  );

  const contactData = await contactRes.json();

  if (!contactData.uuid) {
    console.error("Failed to create contact:", contactData);
    return new Response(
      JSON.stringify({
        error: "Failed to create SlickPay contact",
        details: contactData,
      }),
      { status: 500, headers: { "Content-Type": "application/json" } }
    );
  }

  contactUuid = contactData.uuid;

  // Save it for next time
  await supabase
    .from("profile")
    .update({ slickpay_contact_uuid: contactUuid })
    .eq("user_id", user.id);
}

    // ============================================
    // 7. Create Order (status = pending_payment)
    // ============================================
    const { data: order, error: orderError } = await supabase
      .from("orders")
      .insert({
        user_id: user.id,
        total_price: totalPrice,
        pickup_date: pickupDate,
        status: "pending_payment",
      })
      .select()
      .single();

    if (orderError) {
      return new Response(
        JSON.stringify({ error: orderError.message }),
        { status: 500, headers: { "Content-Type": "application/json" } }
      );
    }

    // ============================================
    // 8. Prepare invoice items
    // ============================================
    const invoiceItems = cartItems.map((item) => ({
      name: item.meals?.name || "Meal",
      price: Number(item.price),
      quantity: item.quantity,
    }));

    // ============================================
    // 9. Create Invoice on SlickPay
    // ============================================
    const invoiceRes = await fetch(
      "https://devapi.slick-pay.com/api/v2/users/invoices",
      {
        method: "POST",
        headers: {
          Authorization: `Bearer ${slickPayApiKey}`,
          "Content-Type": "application/json",
          Accept: "application/json",
        },
        body: JSON.stringify({
          amount: totalPrice,
          contact: contactUuid,
          //url: "https://google.com", // ← change this later
          items: invoiceItems,
          webhook_url: "https://yomroabkrtezxcseollb.supabase.co/functions/v1/slickpay-webhook",
        }),
      }
    );

    const payment = await invoiceRes.json();
    console.log("SLICKPAY PAYMENT:", {
  id: payment.id,
  url: payment.url,
  success: payment.success,
});
    console.log("SlickPay response:", payment);

    if (!invoiceRes.ok || payment.success !== 1) {
      return new Response(
        JSON.stringify({ error: "Failed to create invoice", details: payment }),
        { status: 500, headers: { "Content-Type": "application/json" } }
      );
    }

    // ============================================
    // 10. Save SlickPay invoice ID on the order
    // ============================================
    const { error: updateError } = await supabase
      .from("orders")
      .update({
        slickpay_payment_id: payment.id,
      })
      .eq("id", order.id);

    if (updateError) {
      return new Response(
        JSON.stringify({ error: updateError.message }),
        { status: 500, headers: { "Content-Type": "application/json" } }
      );
    }

    // ============================================
    // 11. Return payment URL to Flutter
    // ============================================
    return new Response(
      JSON.stringify({
        success: true,
        order_id: order.id,
        payment_url: payment.url,
        invoice_id: payment.id,
      }),
      {
        headers: { "Content-Type": "application/json" },
      }
    );
  } catch (err) {
    console.error("Unexpected error:", err);
    return new Response(
      JSON.stringify({
        error: err instanceof Error ? err.message : "Unknown error",
      }),
      { status: 500, headers: { "Content-Type": "application/json" } }
    );
  }
});