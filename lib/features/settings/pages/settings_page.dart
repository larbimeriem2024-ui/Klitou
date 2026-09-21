import 'package:flutter/material.dart';
import 'package:flutter_application_9_klitou/core/constants/app_color.dart';
import 'package:flutter_application_9_klitou/features/auth/state/providers/auth_provider.dart';
import 'package:flutter_application_9_klitou/features/settings/widgets/settings_section.dart';
import 'package:flutter_application_9_klitou/features/settings/widgets/settings_tile.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';



class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,

        backgroundColor: AppColor.backgroundColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                context.pop();
              },
              child: Image.asset('assets/imgs/back.png', height: 25, width: 25),
            ),

            Text(
              'Settings',
              style: TextStyle(
                color: AppColor.apptheme,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),

            GestureDetector(
              onTap: () {
                context.push('/notifications');
              },
              child: Image.asset('assets/imgs/bell.png', height: 25, width: 25),
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SettingsSection(title: 'Account', children: [
                SettingsTile(image: 'assets/imgs/alex.png', title: 'Alex Thompson', description: 'Personal Info & Security', onTap: () => context.push('/profileupdate'),),
                SettingsTile(image: 'assets/imgs/address.png', title: 'Delivery Addresses'), 
                SettingsTile(image: 'assets/imgs/payment.png', title: 'Payment Methodes', description: 'Visa ending in 4242',)
              ]),
                
              

              SizedBox(height: 32),
             SettingsSection(
              title: 'Preferences', 
              children: [
                SettingsTile(image: 'assets/imgs/bell.png', title: 'Notification'),
                SettingsTile(image: 'assets/imgs/theme.png', title: 'Theme'),
                SettingsTile(image: 'assets/imgs/diatery_restrictions.png', title: 'Dietary Restrictions'),
              ]),
              SizedBox(height: 32),
              SettingsSection(
                title: 'App Info', 
                children: [
                  SettingsTile(image: 'assets/imgs/integoration.png', title: 'Help & Support'),
                  SettingsTile(image: 'assets/imgs/privacy_policy.png', title: 'Privary Policy'),
                  SettingsTile(image: 'assets/imgs/about_Us.png', title: 'About Klitou', description: 'version 1.0.5',),
                  

              ]),

              SizedBox(height: 32),
              InkWell(
                onTap: () async {
                  await ref.read(authNotifierProvider.notifier).logout();
                  
                },
                child: Container(
                  height: 55,
                  width: media.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColor.white,
                  ),

                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/imgs/logout.png',
                          height: 25,
                          width: 25,
                        ),

                        SizedBox(width: 8),

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

              SizedBox(height: 100,)
            ],
          ),
        ),
      ),
    );
  }
}
