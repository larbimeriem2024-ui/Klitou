


import 'package:flutter_application_9_klitou/app/navigation/main_shell.dart';
import 'package:flutter_application_9_klitou/features/auth/models/auth_state.dart';
import 'package:flutter_application_9_klitou/features/auth/pages/login/forget_password_email.dart';
import 'package:flutter_application_9_klitou/features/auth/pages/login/login_page.dart';
import 'package:flutter_application_9_klitou/features/auth/pages/login/sign_up_page.dart';
import 'package:flutter_application_9_klitou/features/auth/state/notifier/auth_notifier.dart';
import 'package:flutter_application_9_klitou/features/meals/pages/home_page.dart';
import 'package:flutter_application_9_klitou/features/meals/pages/menu_page.dart';
import 'package:flutter_application_9_klitou/features/orders/pages/shopping_page.dart';
import 'package:flutter_application_9_klitou/views/onboarding/onboarding_page.dart';
import 'package:flutter_application_9_klitou/views/onboarding/startup_page.dart';
import 'package:flutter_application_9_klitou/views/profile/help_support_page.dart';
import 'package:flutter_application_9_klitou/views/profile/my_orders_page.dart';
import 'package:flutter_application_9_klitou/views/profile/notification_page.dart';
import 'package:flutter_application_9_klitou/views/profile/profile_page.dart';
import 'package:flutter_application_9_klitou/views/profile/subscription_page.dart';
import 'package:flutter_application_9_klitou/views/settings/settings_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final goRouterProvider = Provider<GoRouter>((ref) {

  return GoRouter(
    initialLocation: '/splash',
    redirect: (context, state) {
  final authState = ref.watch(authNotifierProvider);

  print('AUTH STATE → $authState');
  print('AUTH VALUE → ${authState.value}');
  print('CURRENT PATH → ${state.matchedLocation}');
  final currentPath = state.matchedLocation;

  // Still loading auth state → stay on splash
  if (authState.isLoading || authState.isRefreshing) {
    return currentPath == '/splash' ? null : '/splash';
  }

  final isLoggedIn = authState.value is AuthAuthenticated;

  final isAuthRoute = currentPath == '/login' ||
      currentPath == '/signup' ||
      currentPath == '/onboarding' ||
      currentPath == '/splash';

  // Not logged in
  if (!isLoggedIn && !isAuthRoute) {
    return '/login';
  }

  // Logged in but on auth pages
  if (isLoggedIn && isAuthRoute) {
    return '/home';
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
      builder: (context, state) => const ShoppingPage(),
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
        builder: (context, state) => const MyOrdersPage(),
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
        
    ],

    
    
  );
});

