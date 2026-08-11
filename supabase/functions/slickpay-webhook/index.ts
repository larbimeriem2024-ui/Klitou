import "jsr:@supabase/functions-js/edge-runtime.d.ts";
import { createClient } from "jsr:@supabase/supabase-js@2";

Deno.serve(async (req) => {
  const supabase = createClient(
    Deno.env.get("SUPABASE_URL")!,
    Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!
  );

  try {
    const body = await req.json();

    console.log("Webhook received:", body);

    // Only process successful payments
    if (body.success === 1 && body.pay_status === 1) {
      // Update the order and retrieve the user_id
      const { data: order, error: updateError } = await supabase
        .from("orders")
        .update({
          status: "paid",
        })
        .eq("slickpay_payment_id", body.id)
        .select("id, user_id")
        .single();

      if (updateError) {
        console.log("Order update error:", updateError);

        return new Response(
          JSON.stringify({
            error: updateError.message,
          }),
          {
            status: 500,
            headers: {
              "Content-Type": "application/json",
            },
          }
        );
      }

      console.log("Order updated:", order);

      // Empty the user's cart after successful payment
      const { error: deleteCartError } = await supabase
        .from("cart")
        .delete()
        .eq("user_id", order.user_id);

      if (deleteCartError) {
        console.log("Cart delete error:", deleteCartError);
      } else {
        console.log("Cart deleted successfully.");
      }
    }

    return new Response(
      JSON.stringify({
        success: true,
      }),
      {
        headers: {
          "Content-Type": "application/json",
        },
      }
    );
  } catch (err) {
    console.error("Webhook error:", err);

    return new Response(
      JSON.stringify({
        error: err instanceof Error ? err.message : "Unknown error",
      }),
      {
        status: 500,
        headers: {
          "Content-Type": "application/json",
        },
      }
    );
  }
});