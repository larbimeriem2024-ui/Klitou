import 'package:flutter/material.dart';
import 'package:flutter_application_9_klitou/core/constants/app_color.dart';
import 'package:flutter_application_9_klitou/features/auth/state/providers/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class StartupPage extends ConsumerWidget {
  const StartupPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(splashProvider);
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/imgs/Background.png',
            height: 130,
            width: 130,
          ),
          Text('Klitou',
          style: TextStyle(
            color: AppColor.apptheme,
            fontSize: 70,
            fontWeight: FontWeight.bold,
          ),),
        ],
      ),
              ),

    );
  }
}