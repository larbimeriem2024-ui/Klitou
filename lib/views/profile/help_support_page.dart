import 'package:flutter/material.dart';
import 'package:flutter_application_9_klitou/core/constants/app_color.dart';
import 'package:flutter_application_9_klitou/shared/common_widgets/ask_about.dart';
import 'package:flutter_application_9_klitou/shared/common_widgets/frequently_asked.dart';
import 'package:flutter_application_9_klitou/views/profile/notification_page.dart';

List asks = [
  {
    'image': 'assets/imgs/meal.png',
    'title': 'Ordering',
    'subtitle': 'Status, changes',
  },
  {
    'image': 'assets/imgs/delivery.png',
    'title': 'Delivery',
    'subtitle': 'Tracking, delay',
  },
  {
    'image': 'assets/imgs/payment1.png',
    'title': 'Payment',
    'subtitle': 'Refunds, methods',
  },
  {
    'image': 'assets/imgs/user.png',
    'title': 'Account',
    'subtitle': 'Profile, security',
  },
];

List frequentlyAsked = [
  {'title': 'Where is my order?'},
  {'title': 'How do I cancel my order'},
  {'title': 'Applying student discounts'},
  {'title': 'Issues with the app?'},
];

class HelpSupportPage extends StatefulWidget {
  const HelpSupportPage({super.key});

  @override
  State<HelpSupportPage> createState() => _HelpSupportPageState();
}

class _HelpSupportPageState extends State<HelpSupportPage> {
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
              'help & support',
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
          padding: const EdgeInsets.only(left: 20, right: 20, top: 45),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'How can we help?',
                      style: TextStyle(
                        color: AppColor.apptheme,
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'Search our FAQs for quick answers.',
                      style: TextStyle(
                        color: AppColor.description,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    SizedBox(height: 16),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Search orders, delivery,etc.',
                        hintStyle: TextStyle(color: AppColor.fieldText),
                        prefixIcon: Icon(
                          Icons.search,
                          color: AppColor.description,
                        ),
                        filled: true,
                        fillColor: AppColor.fieldBg,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: AppColor.apptheme,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32),

              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: asks.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                ),
                itemBuilder: (context, index) {
                  var set = asks[index] as Map? ?? {};
                  return AskAbout(
                    image: set['image'],
                    title: set['title'],
                    subtitle: set['subtitle'],
                  );
                },
              ),
              SizedBox(height: 32),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'FREQUENTLY ASKED',
                    style: TextStyle(
                      color: AppColor.apptheme,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 16),

                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: frequentlyAsked.length,
                    itemBuilder: (context, index) {
                      var set = frequentlyAsked[index] as Map? ?? {};
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: FrequentlyAsked(title: set['title']),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 32),

              Column(
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadiusGeometry.circular(20),
                        child: Image.asset(
                          'assets/imgs/always_here_for_ you.png',
                        ),
                      ),
                      Container(
                        width: media.width,
                        height: 176,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Color(0xFF076148).withValues(alpha: 0.7), // Dark
                              Color(
                                0xFF0B7A5A,).withValues(alpha: 0.4), // Slightly lighter
                              Color(
                                0xFF10966E,).withValues(alpha: 0.2), // Even lighter
                            ],
                            stops: [0.0, 0.5, 1.0],
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Always here for you.',
                                style: TextStyle(
                                  color: AppColor.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                '24/7 Support for the Klitou community',
                                style: TextStyle(
                                  color: AppColor.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 32),

                  Row(
                    children: [
                      GestureDetector(
                        child: Container(
                          height: 65,
                          width: (media.width / 2) - 28,
                          decoration: BoxDecoration(
                            color: AppColor.apptheme,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/imgs/chat.png',
                                height: 20,
                                width: 20,
                              ),
                              SizedBox(width: 5),
                              Text(
                                'Chat with Us',
                                style: TextStyle(
                                  color: AppColor.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 16),

                      GestureDetector(
                        child: Container(
                          height: 65,
                          width: (media.width / 2) - 28,
                          decoration: BoxDecoration(
                            color: AppColor.white,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: AppColor.apptheme),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/imgs/email.png',
                                height: 20,
                                width: 20,
                              ),
                              SizedBox(width: 5),
                              Text(
                                'Email Support ',
                                style: TextStyle(
                                  color: AppColor.apptheme,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 32),

              Text(
                'TYPICAL RESPONSE TIME : 5 MINS',
                style: TextStyle(
                  color: AppColor.description,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}
