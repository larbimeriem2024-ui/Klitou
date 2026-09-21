import 'package:flutter/material.dart';
import 'package:flutter_application_9_klitou/core/constants/app_color.dart';
import 'package:flutter_application_9_klitou/features/profile/state/providers/profile_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileHeader extends ConsumerWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(currentProfileProvider);
    return profileAsync.when(
      data: (profile) {
        return Row(
          children: [
            Text(
              'hey, ',
              style: TextStyle(
                color: AppColor.fontColor,
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
            ),

            Expanded(
              child: Text(
                profile.name,
                style: TextStyle(
                  color: AppColor.apptheme,
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        );
      },
      error: (error, stackTrace) => Text(error.toString()),
      loading: () => CircularProgressIndicator(),
    );
  }
}
