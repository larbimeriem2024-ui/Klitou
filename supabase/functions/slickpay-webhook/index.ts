import "jsr:@supabase/functions-js/edge-runtime.d.ts";
import { createClient } from "jsr:@supabase/supabase-js@2";

Deno.serve(async (req) => {
  // Allow GET and OPTIONS (for testing in browser)
  if (req.method === "GET" || req.method === "OPTIONS") {
    return new Response(JSON.stringify({ message: "Webhook is alive" }), {
      headers: { "Content-Type": "application/json" },
    });
  }

  const supabase = createClient(
    Deno.env.get("SUPABASE_URL")!,
    Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!
  );

  try {
    // Safely read the body (never crash on empty body)
    const text = await req.text();
    console.log("Raw body received:", text);

    let body: any = {};
    if (text && text.trim().length > 0) {
      try {
        body = JSON.parse(text);
      } catch (e) {
        console.error("Failed to parse JSON:", e);
        return new Response(JSON.stringify({ error: "Invalid JSON" }), {
          status: 400,
          headers: { "Content-Type": "application/json" },
        });
      }
    } else {
      console.log("Empty body received");
      return new Response(JSON.stringify({ message: "Empty body" }), {
        status: 200,
        headers: { "Content-Type": "application/json" },
      });
    }

    console.log("Parsed body:", JSON.stringify(body, null, 2));

    // More tolerant success check
    const isSuccess =
      body.success === 1 ||
      body.success === true ||
      body.pay_status === 1 ||
      body.status === "paid" ||
      body.status === 1 ||
      body.paid === true;

    const paymentId =
      body.id ||
      body.invoice_id ||
      body.payment_id ||
      body.data?.id ||
      body.invoice?.id;

    if (isSuccess && paymentId) {
      console.log("Processing successful payment with ID:", paymentId);

      // 1. Update order status to "paid"
      const { data: order, error: updateError } = await supabase
        .from("orders")
        .update({ status: "paid" })
        .eq("slickpay_payment_id", paymentId)
        .select("id, user_id")
        .single();

      if (updateError || !order) {
        console.error("Order update error:", updateError);
        return new Response(
          JSON.stringify({ error: "Order not found or update failed" }),
          { status: 404, headers: { "Content-Type": "application/json" } }
        );
      }

      console.log("Order marked as paid:", order.id);

      // 2. Get cart items
      const { data: cartItems, error: cartError } = await supabase
        .from("cart")
        .select("*")
        .eq("user_id", order.user_id);

      if (cartError) {
        console.error("Error fetching cart:", cartError);
      }

      // 3. Copy cart → order_items
      if (cartItems && cartItems.length > 0) {
        const orderItems = cartItems.map((item) => ({
          order_id: order.id,
          user_id: order.user_id,
          meal_id: item.meal_id,
          quantity: item.quantity,
          unit_price: item.price,
          pickup_date: item.date,
          status: "paid",
        }));

        const { error: insertError } = await supabase
          .from("order_items")
          .insert(orderItems);

        if (insertError) {
          console.error("Error inserting order_items:", insertError);
        } else {
          console.log("Order items created successfully");
        }
      }

      // 4. Delete cart
      const { error: deleteError } = await supabase
        .from("cart")
        .delete()
        .eq("user_id", order.user_id);

      if (deleteError) {
        console.error("Error deleting cart:", deleteError);
      } else {
        console.log("Cart cleared successfully");
      }
    } else {
      console.log("Payment not considered successful or missing ID");
      console.log("success:", body.success);
      console.log("pay_status:", body.pay_status);
      console.log("status:", body.status);
      console.log("paymentId:", paymentId);
    }

    return new Response(JSON.stringify({ success: true }), {
      headers: { "Content-Type": "application/json" },
    });
  } catch (err) {
    console.error("Webhook error:", err);
    return new Response(
      JSON.stringify({
        error: err instanceof Error ? err.message : "Unknown error",
      }),
      { status: 500, headers: { "Content-Type": "application/json" } }
    );
  }
});