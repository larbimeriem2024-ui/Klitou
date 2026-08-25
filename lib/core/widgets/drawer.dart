// lib/app/shell/app_drawer.dart

import 'package:flutter/material.dart';
import 'package:flutter_application_9_klitou/app/navigation/main_destinations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_color.dart';
import '../../features/auth/state/notifier/auth_notifier.dart';
import '../../features/profile/state/providers/profile_provider.dart';

class AppDrawer extends ConsumerWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(currentProfileProvider);

    return Drawer(
      backgroundColor: AppColor.backgroundColor,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ---------- Logo ----------
              Text(
                'Klitou',
                style: TextStyle(
                  color: AppColor.apptheme,
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 32),

              // ---------- Profile Header ----------
              Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration:  BoxDecoration(
                      color: AppColor.apptheme,
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/imgs/menu2.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  profileAsync.when(
                    data: (profile) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            profile.name,
                            style: TextStyle(
                              color: AppColor.fontColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            profile.email,
                            style: TextStyle(
                              color: AppColor.description,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      );
                    },
                    loading: () => const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                    error: (error, _) => Text(
                      error.toString(),
                      style: TextStyle(color: AppColor.red, fontSize: 12),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // ---------- Drawer Items ----------
              Expanded(
                child: ListView.separated(
                  itemCount: kDrawerDestinations.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final dest = kDrawerDestinations[index];

                    return Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          // Close the drawer first
                          Navigator.of(context).pop();

                          // Then navigate
                          context.go(dest.path);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          child: Row(
                            children: [
                              Image.asset(
                                dest.icon,
                                height: 20,
                                width: 20,
                                color: AppColor.fontColor,
                              ),
                              const SizedBox(width: 16),
                              Text(
                                dest.title,
                                style: TextStyle(
                                  color: AppColor.fontColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
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

              // ---------- Divider ----------
              const Divider(),
              const SizedBox(height: 16),

              // ---------- Sign Out ----------
              Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () async {
                    await ref.read(authNotifierProvider.notifier).logout();
                    // go_router redirect will send user to login page
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/imgs/logout.png',
                          height: 25,
                          width: 25,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Sign Out',
                          style: TextStyle(
                            color: AppColor.red,
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}