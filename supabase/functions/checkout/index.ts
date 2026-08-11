import "jsr:@supabase/functions-js/edge-runtime.d.ts";
// deno-lint-ignore no-import-prefix
import { createClient } from "jsr:@supabase/supabase-js@2";

Deno.serve(async (req) => {
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
    JSON.stringify({
      error: "SlickPay API key is not configured.",
    }),
    {
      status: 500,
      headers: {
        "Content-Type": "application/json",
      },
    }
  );
}

  

  const {
    data: { user },
    error,
  } = await supabase.auth.getUser();

  

  if (error || !user) {
    return new Response(
      JSON.stringify({
        error: "Unauthorized",
      }),
      {
        status: 401,
        headers: {
          "Content-Type": "application/json",
        },
      }
    );
  }
  const { data: profile, error: profileError } = await supabase
  .from("profile")
  .select("name, phonen, email, address")
  .eq("user_id", user.id)
  .single();

if (profileError || !profile) {
  return new Response(
    JSON.stringify({
      error: "Profile not found.",
    }),
    {
      status: 500,
      headers: {
        "Content-Type": "application/json",
      },
    }
  );
}


 const { data: cartItems, error: cartError } = await supabase
  .from("cart")
  .select(`
    *,
    meals (
      name
    )
  `)
  .eq("user_id", user.id);
  console.log(cartItems);

  if (cartError) {
  return new Response(
    JSON.stringify({
      error: cartError.message,
    }),
    {
      status: 500,
      headers: {
        "Content-Type": "application/json",
      },
    }
  );
}

if (!cartItems || cartItems.length === 0) {
  return new Response(
    JSON.stringify({
      error: "Your cart is empty.",
    }),
    {
      status: 400,
      headers: {
        "Content-Type": "application/json",
      },
    }
  );
}

function calculateTotal(cartItems: any[]) {
  let total = 0;

  for (const item of cartItems) {
    total += Number(item.price) * item.quantity;
  }

  return total;
}
const totalPrice = calculateTotal(cartItems);

const pickupDate = cartItems[0].date;

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
    JSON.stringify({
      error: orderError.message,
    }),
    {
      status: 500,
      headers: {
        "Content-Type": "application/json",
      },
    }
  );
}

const orderItems = cartItems.map((item) => ({
  order_id: order.id,
  meal_id: item.meal_id,
  quantity: item.quantity,
  unit_price: item.price,
  pickup_date: item.date,
  user_id : user.id,
}));

const { error: orderItemsError } = await supabase
  .from("order_items")
  .insert(orderItems);

if (orderItemsError) {
  return new Response(
    JSON.stringify({
      error: orderItemsError.message,
    }),
    {
      status: 500,
      headers: {
        "Content-Type": "application/json",
      },
    }
  );
}
const invoiceItems = cartItems.map((item) => ({
  name: item.meals.name,
  price: item.price,
  quantity: item.quantity,
}));


const names = profile.name.trim().split(" ");

const firstName = names[0];
const lastName = names.length > 1 ? names.slice(1).join(" ") : "-";

const response = await fetch(
  "https://devapi.slick-pay.com/api/v2/users/invoices",
  {
    method: "POST",
    headers: {
      "Authorization": `Bearer ${slickPayApiKey}`,
      "Content-Type": "application/json",
      "Accept": "application/json",
    },
   body: JSON.stringify({
  amount: totalPrice,
  firstname: firstName,
  lastname: lastName,
  phone: profile.phonen,
  email: profile.email,
  address: profile.address,
  url: "https://example.com",
  webhook_url: "https://yomroabkrtezxcseollb.supabase.co/functions/v1/slickpay-webhook",
  items: invoiceItems,
}),
  }
);

const payment = await response.json();

console.log(payment);

if (!response.ok || payment.success !== 1) {
  return new Response(
    JSON.stringify({
      error: payment,
    }),
    {
      status: 500,
      headers: {
        "Content-Type": "application/json",
      },
    }
  );
}

const { error: updateError } = await supabase
  .from("orders")
  .update({
    slickpay_payment_id: payment.id,
  })
  .eq("id", order.id);

if (updateError) {
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
















  return new Response(
    JSON.stringify(
    {
    success: true,
    order_id: order.id,
    payment_url: payment.url,
    invoice_id: payment.id,
    
  }
    ),
    {
      headers: {
        "Content-Type": "application/json",
      },
    }
  );

  
});