


import 'package:flutter_application_9_klitou/app/navigation/main_shell.dart';
import 'package:flutter_application_9_klitou/features/auth/models/auth_state.dart';
import 'package:flutter_application_9_klitou/features/auth/pages/login/forget_password_email.dart';
import 'package:flutter_application_9_klitou/features/auth/pages/login/login_page.dart';
import 'package:flutter_application_9_klitou/features/auth/pages/login/reset_password_page.dart';
import 'package:flutter_application_9_klitou/features/auth/pages/login/sign_up_page.dart';
import 'package:flutter_application_9_klitou/features/auth/state/providers/auth_provider.dart';
import 'package:flutter_application_9_klitou/features/meals/models/meal_model.dart';
import 'package:flutter_application_9_klitou/features/meals/pages/home_page.dart';
import 'package:flutter_application_9_klitou/features/meals/pages/menu_page.dart';
import 'package:flutter_application_9_klitou/features/orders/pages/my_orders/my_orders_switcher.dart';
import 'package:flutter_application_9_klitou/features/orders/pages/order_meal.dart';
import 'package:flutter_application_9_klitou/features/orders/pages/shopping/cart_switcher.dart';
import 'package:flutter_application_9_klitou/features/onboarding/onboarding_page.dart';
import 'package:flutter_application_9_klitou/features/profile/pages/help_support_page.dart';
import 'package:flutter_application_9_klitou/features/profile/pages/notification_page.dart';
import 'package:flutter_application_9_klitou/features/profile/pages/profile_page.dart';
import 'package:flutter_application_9_klitou/features/profile/pages/profile_update_page.dart';
import 'package:flutter_application_9_klitou/features/profile/pages/subscription_page.dart';
import 'package:flutter_application_9_klitou/features/settings/pages/settings_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final goRouterProvider = Provider<GoRouter>((ref) {

  final router = GoRouter(
    initialLocation: '/onboarding' ,
    redirect: (context, state) {
  final authState = ref.read(authNotifierProvider);

  final currentPath = state.matchedLocation;
  
 
  if (authState.value is AuthPasswordRecovery) {
    if(currentPath != '/resetpassword'){
    return '/resetpassword';
}

  return null;
  }

  
  

  


  // Still loading auth state → stay 
  if (authState.isLoading || authState.isRefreshing) {
    return null;
  }

  final isLoggedIn = authState.value is AuthAuthenticated;

  final isAuthRoute = 
      currentPath == '/login' ||
      currentPath == '/signup' ||
      currentPath == '/onboarding' ||
      currentPath =='/forgetpassword'||
      currentPath == '/resetpassword';
      


  
  // 2. Not logged in
  if (!isLoggedIn) {
    if (isAuthRoute) {
      return null; 
    }

    
    // Trying to access protected pages → send to onboarding
    return '/onboarding';
  }

  // 3. Logged in
  if (isLoggedIn) {
    // Coming from splash or any auth page → go to home
    if (isAuthRoute) {
      return '/home';
    }
  }

  return null;
},

    routes:  [
      
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
    (previous, next) {
      
      router.refresh();
    },
  );

 

  return router;
});

