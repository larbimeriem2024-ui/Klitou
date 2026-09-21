import "jsr:@supabase/functions-js/edge-runtime.d.ts";
import { createClient } from "jsr:@supabase/supabase-js@2";

Deno.serve(async (req) => {
  // --------------------------------------------------
  // 1. Only allow POST
  // --------------------------------------------------
  if (req.method !== "POST") {
    return new Response(
      JSON.stringify({ error: "Method not allowed" }),
      {
        status: 405,
        headers: { "Content-Type": "application/json" },
      },
    );
  }

  // --------------------------------------------------
  // 2. Create service-role client
  // --------------------------------------------------
  const supabase = createClient(
    Deno.env.get("SUPABASE_URL")!,
    Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!,
  );

  try {
    // --------------------------------------------------
    // 3. Read webhook body
    // --------------------------------------------------
    const text = await req.text();

    if (!text || text.trim().length === 0) {
      return new Response(
        JSON.stringify({ error: "Empty request body" }),
        {
          status: 400,
          headers: { "Content-Type": "application/json" },
        },
      );
    }

    let body: Record<string, any>;

    try {
      body = JSON.parse(text);
    } catch {
      return new Response(
        JSON.stringify({ error: "Invalid JSON" }),
        {
          status: 400,
          headers: { "Content-Type": "application/json" },
        },
      );
    }

    // --------------------------------------------------
    // 4. Extract payment ID
    // --------------------------------------------------
    const paymentId =
      body.id ??
      body.invoice_id ??
      body.payment_id ??
      body.data?.id ??
      body.invoice?.id;

    if (!paymentId) {
      console.error("Webhook missing payment ID");

      return new Response(
        JSON.stringify({ error: "Missing payment ID" }),
        {
          status: 400,
          headers: { "Content-Type": "application/json" },
        },
      );
    }

    // --------------------------------------------------
    // 5. Determine whether payment is successful
    // --------------------------------------------------
    const isSuccess =
      body.success === 1 ||
      body.success === true ||
      body.pay_status === 1 ||
      body.status === "paid" ||
      body.status === 1 ||
      body.paid === true;

    if (!isSuccess) {
      console.log("Payment notification was not successful", {
        paymentId,
        status: body.status,
        pay_status: body.pay_status,
      });

      // Important:
      // Tell SlickPay we received the webhook.
      return new Response(
        JSON.stringify({ received: true }),
        {
          status: 200,
          headers: { "Content-Type": "application/json" },
        },
      );
    }

    console.log("Successful payment notification", {
      paymentId,
    });

    // --------------------------------------------------
    // 6. Find the order
    // --------------------------------------------------
    const { data: order, error: orderError } = await supabase
      .from("orders")
      .select("id, user_id, status, total_price")
      .eq("slickpay_payment_id", paymentId)
      .single();

    if (orderError || !order) {
      console.error("Order not found for payment", {
        paymentId,
        error: orderError,
      });

      return new Response(
        JSON.stringify({ error: "Order not found" }),
        {
          status: 404,
          headers: { "Content-Type": "application/json" },
        },
      );
    }

    // --------------------------------------------------
    // 7. Idempotency check
    // --------------------------------------------------
    //
    // If SlickPay sends the same webhook again,
    // don't create duplicate order items or
    // perform the payment logic again.
    //
    if (order.status === "paid") {
      console.log("Payment already processed", {
        paymentId,
        orderId: order.id,
      });

      return new Response(
        JSON.stringify({
          received: true,
          already_processed: true,
        }),
        {
          status: 200,
          headers: { "Content-Type": "application/json" },
        },
      );
    }

    // --------------------------------------------------
    // 8. Mark order as paid
    // --------------------------------------------------
    const { error: updateError } = await supabase
      .from("orders")
      .update({
        status: "paid",
      })
      .eq("id", order.id)
      .eq("status", "pending_payment");

    if (updateError) {
      console.error("Failed to mark order as paid", {
        orderId: order.id,
        error: updateError,
      });

      return new Response(
        JSON.stringify({ error: "Failed to update order" }),
        {
          status: 500,
          headers: { "Content-Type": "application/json" },
        },
      );
    }

    console.log("Order marked as paid", {
      orderId: order.id,
      paymentId,
    });

    // --------------------------------------------------
    // 9. IMPORTANT
    // --------------------------------------------------
    //
    // We DO NOT copy the cart here anymore.
    //
    // The order_items should be created during checkout
    // from the validated order/cart data.
    //
    // This prevents:
    //
    // payment
    //    ↓
    // webhook
    //    ↓
    // current cart
    //
    // from accidentally using a cart that changed
    // after checkout.
    //
    // --------------------------------------------------

    return new Response(
      JSON.stringify({
        received: true,
      }),
      {
        status: 200,
        headers: { "Content-Type": "application/json" },
      },
    );
  } catch (err) {
    console.error("Webhook processing failed:", err);

    return new Response(
      JSON.stringify({
        error: "Webhook processing failed",
      }),
      {
        status: 500,
        headers: { "Content-Type": "application/json" },
      },
    );
  }
});