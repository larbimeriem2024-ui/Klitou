// lib/app/shell/main_bottom_nav_bar.dart

import 'package:flutter/material.dart';
import 'package:flutter_application_9_klitou/app/navigation/main_destinations.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_color.dart';

class MainBottomNavBar extends StatelessWidget {
  const MainBottomNavBar({
    super.key,
    required this.currentIndex,
  });

  final int currentIndex; // which tab is currently active

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 70,
          color: AppColor.backgroundColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              kTabDestinations.length,          // ← uses the list
              (index) {
                final dest = kTabDestinations[index];
                final isSelected = index == currentIndex;

                return Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      // This is the magic connection
                      context.go(dest.path);
                    },
                    child: Container(
                      height: 52,
                      width: 68.95,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColor.fieldBg
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            isSelected ? dest.selectedIcon : dest.icon,
                            height: index == 0 || index == 1 ? 24 : 20,
                            width: index == 2 ? 25 : 20,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            dest.label,
                            style: TextStyle(
                              color: isSelected
                                  ? AppColor.apptheme
                                  : AppColor.description,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}