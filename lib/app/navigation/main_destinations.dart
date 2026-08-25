

// app/router/main_destinations.dart
import 'package:flutter_application_9_klitou/core/constants/app_assets.dart';

enum MainTab { home, menu, cart, profile }

class TabDestination {
  const TabDestination({
    required this.tab,
    required this.path,
    required this.label,
    required this.icon,
    required this.selectedIcon,
  });

  final MainTab tab;
  final String path;
  final String label;
  final String icon;
  final String selectedIcon;
}

const kTabDestinations = [
  TabDestination(
    tab: MainTab.home,
    path: '/home',
    label: 'Home',
    icon: AppAssets.home,
    selectedIcon: AppAssets.homePressed,
  ),

  // Menu, Cart, Profile...

  TabDestination(
    tab: MainTab.menu,
    path: '/menu',
    label: 'Menu',
    icon: AppAssets.meal,
    selectedIcon: AppAssets.mealPressed,
  ),

  TabDestination(
    tab: MainTab.cart,
    path: '/cart',
    label: 'Cart',
    icon: AppAssets.cart,
    selectedIcon: AppAssets.cartPressed,
  ),

  TabDestination(
    tab: MainTab.profile,
    path: '/profile',
    label: 'Profile',
    icon: AppAssets.user,
    selectedIcon: AppAssets.userPressed,
  ),
];

class DrawerDestination {
  const DrawerDestination({
    required this.title,
    required this.icon,
    required this.path,
  });

  final String title;
  final String icon;
  final String path;
}

const kDrawerDestinations = [
  DrawerDestination(
    title: 'Home',
    icon: AppAssets.homePressed
    ,
    path: '/home',
  ),
  DrawerDestination(
    title: 'My orders',
    icon: AppAssets.mealPressed,
    path: '/orders',
  ),
  DrawerDestination(
    title: 'Subscriptions',
    icon: 'assets/imgs/ticket.png',
    path: '/subscriptions',
  ),
  DrawerDestination(
    title: 'Notifications',
    icon: 'assets/imgs/bell.png',
    path: '/notifications',
  ),
  DrawerDestination(
    title: 'Help & Support',
    icon: 'assets/imgs/integoration.png',
    path: '/help',
  ),
  DrawerDestination(
    title: 'Settings',
    icon: 'assets/imgs/settings.png',
    path: '/settings',
  ),
];