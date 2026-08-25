// lib/app/shell/main_shell.dart
import 'package:flutter/material.dart';
import 'package:flutter_application_9_klitou/app/navigation/main_destinations.dart';
import 'package:flutter_application_9_klitou/core/widgets/app_bar.dart';
import 'package:flutter_application_9_klitou/core/widgets/bottom_nav_bar.dart';
import 'package:flutter_application_9_klitou/core/widgets/drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';


class MainShell extends ConsumerWidget {
  const MainShell({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = GoRouterState.of(context).uri.toString();
    final currentIndex = _indexFromLocation(location);

    return Scaffold(
      drawer: const AppDrawer(),
      appBar: MainAppBar(currentIndex: currentIndex),
      body: child,
      bottomNavigationBar: MainBottomNavBar(currentIndex: currentIndex),
    );
  }

  int _indexFromLocation(String location) {
    final index = kTabDestinations.indexWhere(
      (dest) => location.startsWith(dest.path),
    );
    return index == -1 ? 0 : index;
  }
}