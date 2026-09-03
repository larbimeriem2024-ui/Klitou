


import 'package:flutter_application_9_klitou/app/navigation/main_shell.dart';
import 'package:flutter_application_9_klitou/features/auth/models/auth_state.dart';
import 'package:flutter_application_9_klitou/features/auth/pages/login/forget_password_email.dart';
import 'package:flutter_application_9_klitou/features/auth/pages/login/login_page.dart';
import 'package:flutter_application_9_klitou/features/auth/pages/login/reset_password_page.dart';
import 'package:flutter_application_9_klitou/features/auth/pages/login/sign_up_page.dart';
import 'package:flutter_application_9_klitou/features/auth/state/notifier/auth_notifier.dart';
import 'package:flutter_application_9_klitou/features/auth/state/providers/auth_provider.dart' hide authNotifierProvider;
import 'package:flutter_application_9_klitou/features/meals/models/meal_model.dart';
import 'package:flutter_application_9_klitou/features/meals/pages/home_page.dart';
import 'package:flutter_application_9_klitou/features/meals/pages/menu_page.dart';
import 'package:flutter_application_9_klitou/features/orders/pages/my_orders/my_orders_switcher.dart';
import 'package:flutter_application_9_klitou/features/orders/pages/order_meal.dart';
import 'package:flutter_application_9_klitou/features/orders/pages/shopping/cart_switcher.dart';
import 'package:flutter_application_9_klitou/features/onboarding/onboarding_page.dart';
import 'package:flutter_application_9_klitou/features/onboarding/startup_page.dart';
import 'package:flutter_application_9_klitou/features/profile/pages/help_support_page.dart';
import 'package:flutter_application_9_klitou/features/profile/pages/notification_page.dart';
import 'package:flutter_application_9_klitou/features/profile/pages/profile_page.dart';
import 'package:flutter_application_9_klitou/features/profile/pages/profile_update_page.dart';
import 'package:flutter_application_9_klitou/features/profile/pages/subscription_page.dart';
import 'package:flutter_application_9_klitou/features/settings/settings_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final goRouterProvider = Provider<GoRouter>((ref) {

  final router = GoRouter(
    initialLocation: '/splash',
    redirect: (context, state) {
  final authState = ref.read(authNotifierProvider);
  final splashState = ref.read(splashProvider);

  if (authState.value is AuthPasswordRecovery) {
    return '/resetpassword';
}

  
  final currentPath = state.matchedLocation;

  if (!splashState.hasValue) {
    return currentPath == '/splash' ? null : '/splash';
  }


  // Still loading auth state → stay on splash
  if (authState.isLoading || authState.isRefreshing) {
    return currentPath == '/splash' ? null : '/splash';
  }

  final isLoggedIn = authState.value is AuthAuthenticated;

  final isAuthRoute = currentPath == '/login' ||
      currentPath == '/signup' ||
      currentPath == '/onboarding' ||
      currentPath =='/forgetpassword' ;


  
  // 2. Not logged in
  if (!isLoggedIn) {
    // If we are on splash after loading finished → go to onboarding or login
    if (currentPath == '/splash') {
      return '/onboarding'; // or '/login' if you prefer
    }

    // Already on an auth page → stay
    if (isAuthRoute) {
      return null;
      
    }

    // Trying to access protected pages → send to login
    return '/login';
  }

  // 3. Logged in
  if (isLoggedIn) {
    // Coming from splash or any auth page → go to home
    if (currentPath == '/splash' || isAuthRoute) {
      return '/home';
    }
  }

  return null;
},

    routes:  [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const StartupPage(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) => const SignUpPage(),
      ),
      
       GoRoute(
        path: '/forgetpassword',
        builder: (context, state) => const ForgetPasswordEmail(),
      ),

      GoRoute(
  path: '/resetpassword',
  builder: (context, state) => const ResetPasswordPage(),
),

      ShellRoute(
        builder: (context, state, child) {
          return MainShell(child: child);
        },
        routes: [
          GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/menu',
      name: 'menu',
      builder: (context, state) => const MenuPage(),
    ),
    GoRoute(
      path: '/cart',
      name: 'cart',
      builder: (context, state) => const CartSwitcher(),
    ),
    GoRoute(
      path: '/profile',
      name: 'profile',
      builder: (context, state) => const ProfilePage(),
    ),
  ],
),


   GoRoute(
        path: '/orders',
        builder: (context, state) => const MyOrdersSwitcher(),
      ),
      GoRoute(
        path: '/subscriptions',
        builder: (context, state) => const SubscriptionPage(),
      ),
      GoRoute(
        path: '/notifications',
        builder: (context, state) => const NotificationPage(),
      ),
      GoRoute(
        path: '/help',
        builder: (context, state) => const HelpSupportPage(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsPage(),
      ),
      GoRoute(
        path: '/profileupdate',
        builder: (context, state) => const ProfileUpdatePage(),
      ),
      GoRoute(
  path: '/order-meal',
  builder: (context, state) {
    final dish = state.extra as Meal;

    return OrderMeal(meal: dish);
  },
),
      
        
    ],

    
    
  );

  ref.listen(
    authNotifierProvider,
    (_, _) {
      router.refresh();
    },
  );

  ref.listen(
  splashProvider,
  (_, _) {
    router.refresh();
  },
);

  return router;
});

