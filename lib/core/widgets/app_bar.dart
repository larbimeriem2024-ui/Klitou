// lib/app/shell/main_app_bar.dart
import 'package:flutter/material.dart';
import 'package:flutter_application_9_klitou/app/navigation/main_destinations.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_color.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({super.key, required this.currentIndex});

  final int currentIndex;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: AppColor.backgroundColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Hamburger → open drawer
          Builder(
            builder: (ctx) => GestureDetector(
              onTap: () => Scaffold.of(ctx).openDrawer(),
              child: Image.asset(
                'assets/imgs/three_bar.png',
                height: 25,
                width: 25,
              ),
            ),
          ),

          // Title
          Text(
            kTabDestinations[currentIndex].label,
            style: TextStyle(
              color: AppColor.apptheme,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),

          // Notifications
          GestureDetector(
            onTap: () => context.push('/notifications'),
            child: Image.asset(
              'assets/imgs/bell.png',
              height: 25,
              width: 25,
            ),
          ),
        ],
      ),
    );
  }
}