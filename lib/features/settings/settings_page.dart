import 'package:flutter/material.dart';
import 'package:flutter_application_9_klitou/core/constants/app_color.dart';
import 'package:flutter_application_9_klitou/shared/common_widgets/white_container.dart';
import 'package:flutter_application_9_klitou/features/auth/state/notifier/auth_notifier.dart';
import 'package:flutter_application_9_klitou/features/profile/pages/notification_page.dart';
import 'package:flutter_application_9_klitou/features/profile/pages/profile_update_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

List AppInfo = [
  {'title': 'Help & Support', 'image': 'assets/imgs/integoration.png'},

  {'title': 'Privacy Policy', 'image': 'assets/imgs/privacy_policy.png'},
  {
    'title': 'About Klitou   ',
    'image': 'assets/imgs/about_Us.png',
    'subtitle': 'version 1.1.0',
  },
];

List preferences = [
  {
    'title': 'Notification', 
    'image': 'assets/imgs/bell.png', 
    'switch': true
  },

  {
    'title': 'Theme', 
    'image': 'assets/imgs/theme.png'
  },

  {
    'title': 'Dietary Restrictions',
    'image': 'assets/imgs/diatery_restrictions.png',
  },
];

List account = [
  {
    'title': 'Alex Thompson',
    'image': 'assets/imgs/alex.png',
    'subtitle': 'Personal Info & Security',
    'person': true,
  },
  {'title': 'Delivery Addresses', 'image': 'assets/imgs/address.png'},
  {
    'title': 'Payment Methods',
    'image': 'assets/imgs/payment.png',
    'subtitle': 'Visa ending in 4242',
  },
];

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
                Navigator.pop(context);
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationPage()),
                );
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
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Account',
                      style: TextStyle(
                        color: AppColor.apptheme,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),

                  SizedBox(height: 16),
                  Stack(
                    children: [
                      WhiteContainer(),

                      Padding(
                        padding: const EdgeInsets.only(
                          top: 8.0,
                          bottom: 8,
                          right: 8,
                          left: 8,
                        ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            var set = account[index] as Map? ?? {};
                            return GestureDetector(
                              onTap: () {
                                if(index == 0){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileUpdatePage(),));
                                }
                              },
                              child: Container(
                                height: 72,
                                width: media.width,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(10),
                                ),

                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 5,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,

                                    children: [
                                      Row(
                                        children: [
                                          set['person'] != null
                                              ? SizedBox(
                                                height: 49,
                                                width: 49,
                                                  child: ClipOval(
                                                    child: Image.asset(
                                                      set['image'],

                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                )
                                              : Container(
                                                  decoration: BoxDecoration(
                                                    color: AppColor.fieldBg,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          15,
                                                        ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                          12,
                                                        ),
                                                    child: Image.asset(
                                                      set['image'],
                                                      height: 25,
                                                      width: 25,
                                                    ),
                                                  ),
                                                ),

                                          SizedBox(width: 16),

                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                set['title'],
                                                style: TextStyle(
                                                  color: AppColor.fontColor,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              if (set['subtitle'] != null)
                                                Text(
                                                  set['subtitle'],
                                                  style: TextStyle(
                                                    color: AppColor.description,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ],
                                      ),

                                      Image.asset(
                                        'assets/imgs/arrow.png',
                                        color: AppColor.fieldText,
                                        height: 16,
                                        width: 16,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      Column(
                        children: [
                          SizedBox(height: 72),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Divider(
                              color: AppColor.rowbox,
                              thickness: 0.5,
                            ),
                          ),
                          SizedBox(height: 56),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Divider(
                              color: AppColor.rowbox,
                              thickness: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: 32),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Preferences',
                      style: TextStyle(
                        color: AppColor.apptheme,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),

                  SizedBox(height: 16),
                  Stack(
                    children: [
                      WhiteContainer(),

                      Padding(
                        padding: const EdgeInsets.only(
                          top: 8.0,
                          bottom: 8,
                          right: 8,
                          left: 8,
                        ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            var set = preferences[index] as Map? ?? {};
                            return GestureDetector(
                              onTap: () {},
                              child: Container(
                                height: 72,
                                width: media.width,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(10),
                                ),

                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 5,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,

                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color: AppColor.fieldBg,
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(12),
                                              child: Image.asset(
                                                set['image'],
                                                height: 25,
                                                width: 25,
                                              ),
                                            ),
                                          ),

                                          SizedBox(width: 16),

                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                set['title'],
                                                style: TextStyle(
                                                  color: AppColor.fontColor,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              if (set['subtitle'] != null)
                                                Text(
                                                  set['subtitle'],
                                                  style: TextStyle(
                                                    color: AppColor.description,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      set['switch'] != null
                                          ? Switch(
                                              value: set['switch'],
                                              onChanged: (value) {
                                                setState(() {
                                                  set['switch'] = value;
                                                });
                                              },
                                              activeTrackColor: AppColor.apptheme,
                                              inactiveTrackColor: AppColor.rowbox,

                                            )
                                          : Image.asset(
                                              'assets/imgs/arrow.png',
                                              color: AppColor.fieldText,
                                              height: 16,
                                              width: 16,
                                            ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      Column(
                        children: [
                          SizedBox(height: 72),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Divider(
                              color: AppColor.rowbox,
                              thickness: 0.5,
                            ),
                          ),
                          SizedBox(height: 56),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Divider(
                              color: AppColor.rowbox,
                              thickness: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 32),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      'App Info',
                      style: TextStyle(
                        color: AppColor.apptheme,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),

                  SizedBox(height: 16),
                  Stack(
                    children: [
                      WhiteContainer(),

                      Padding(
                        padding: const EdgeInsets.only(
                          top: 8.0,
                          bottom: 8,
                          right: 8,
                          left: 8,
                        ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            var set = AppInfo[index] as Map? ?? {};
                            return GestureDetector(
                              onTap: () {},
                              child: Container(
                                height: 72,
                                width: media.width,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(10),
                                ),

                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 5,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,

                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color: AppColor.fieldBg,
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(12),
                                              child: Image.asset(
                                                set['image'],
                                                height: 25,
                                                width: 25,
                                              ),
                                            ),
                                          ),

                                          SizedBox(width: 16),

                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                set['title'],
                                                style: TextStyle(
                                                  color: AppColor.fontColor,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              if (set['subtitle'] != null)
                                                Text(
                                                  set['subtitle'],
                                                  style: TextStyle(
                                                    color: AppColor.description,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ],
                                      ),

                                      Image.asset(
                                        'assets/imgs/arrow.png',
                                        color: AppColor.fieldText,
                                        height: 16,
                                        width: 16,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      Column(
                        children: [
                          SizedBox(height: 72),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Divider(
                              color: AppColor.rowbox,
                              thickness: 0.5,
                            ),
                          ),
                          SizedBox(height: 56),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Divider(
                              color: AppColor.rowbox,
                              thickness: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),

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
