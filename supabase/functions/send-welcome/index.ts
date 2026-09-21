import { withSupabase } from "npm:@supabase/server@^1";
import { JWT } from "npm:google-auth-library@^9";

console.log("=== send-welcome function started ===");

interface WebhookPayload {
  type: "INSERT" | "UPDATE" | "DELETE";
  table: string;
  schema: string;
  record: {
    id: string;
    name?: string;
    email?: string;
  };
  old_record: null;
}

export default {
  fetch: withSupabase({ auth: "secret" }, async (req, ctx) => {
    console.log("=== Inside fetch handler ===");
    try {
      const payload: WebhookPayload = await req.json();
      console.log("Received payload:", JSON.stringify(payload));
      // Only handle new profiles
      if (payload.type !== "INSERT" || payload.table !== "profile") {
        return Response.json({ message: "Ignored - not a profile insert" });
      }

      const userId = payload.record.id;
      const fullName = payload.record.name || "there";
      console.log("Processing user:", userId, fullName);

      console.log("New profile created:", userId);

      // Get the user's FCM token from device_tokens table
      const { data: tokenData, error: tokenError } = await ctx.supabaseAdmin
        .from("device_tokens")
        .select("fcm_token")
        .eq("user_id", userId)
        .maybeSingle();
      console.log("Token query result:", { tokenData, tokenError });

      if (tokenError) {
        console.error("Error getting FCM token:", tokenError);
        throw tokenError;
      }

      // Explicitly tell TypeScript the shape
      const fcmToken = (tokenData as { fcm_token: string } | null)?.fcm_token;
      console.log("FCM Token found:", fcmToken ? "Yes" : "No");
      if (!fcmToken) {
        console.log(`No FCM token found for user ${userId}`);
        return Response.json({
          success: false,
          message: "Profile created, but no FCM token exists yet",
        });
      }

      // Read Firebase secrets
      const clientEmail = Deno.env.get("FIREBASE_CLIENT_EMAIL");
      const privateKey = Deno.env.get("FIREBASE_PRIVATE_KEY")?.replace(
        /\\n/g,
        "\n",
      );
      const projectId = Deno.env.get("FIREBASE_PROJECT_ID");

      if (!clientEmail || !privateKey || !projectId) {
        throw new Error(
          "Missing Firebase secrets. Please set FIREBASE_CLIENT_EMAIL, FIREBASE_PRIVATE_KEY and FIREBASE_PROJECT_ID",
        );
      }

      // Get Google access token
      const accessToken = await getAccessToken({
        clientEmail,
        privateKey,
      });

      // Build the FCM message
      const message = {
        message: {
          token: fcmToken,
          notification: {
            title: "Welcome to Klitou! 🎉",
            body: `Hey ${fullName}, your account is ready. Let's get started!`,
          },
          data: {
            type: "welcome",
            route: "/home",
            user_id: userId,
          },
        },
      };

      // Send to Firebase
      const res = await fetch(
        `https://fcm.googleapis.com/v1/projects/${projectId}/messages:send`,
        {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
            Authorization: `Bearer ${accessToken}`,
          },
          body: JSON.stringify(message),
        },
      );

      const result = await res.json();

      if (!res.ok) {
        console.error("FCM error:", result);
        throw new Error(JSON.stringify(result));
      }

      console.log("Welcome notification sent successfully to user:", userId);

      return Response.json({
        success: true,
        result,
      });
    } catch (error) {
      console.error("Error in send-welcome function:", error);

      return Response.json(
        {
          error: error instanceof Error ? error.message : "Unknown error",
        },
        { status: 500 },
      );
    }
  }),
};

// Helper: Generate Google access token
async function getAccessToken({
  clientEmail,
  privateKey,
}: {
  clientEmail: string;
  privateKey: string;
}): Promise<string> {
  const jwtClient = new JWT({
    email: clientEmail,
    key: privateKey,
    scopes: ["https://www.googleapis.com/auth/firebase.messaging"],
  });

  const tokens = await jwtClient.authorize();
  return tokens.access_token!;
}
