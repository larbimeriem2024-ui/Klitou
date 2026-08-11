import 'package:flutter/material.dart';
import 'package:flutter_application_9_klitou/common/app_color.dart';
import 'package:flutter_application_9_klitou/common_widgets/textfield.dart';

class ProfileUpdatePage extends StatefulWidget {
  const ProfileUpdatePage({super.key});

  @override
  State<ProfileUpdatePage> createState() => _ProfileUpdatePageState();
}

class _ProfileUpdatePageState extends State<ProfileUpdatePage> {
  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController phonecontroller = TextEditingController();

  bool pressed = false;
  @override
  Widget build(BuildContext context) {
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

            SizedBox(width: 16),

            Expanded(
              child: Text(
                'Personal Info & Security',
                style: TextStyle(
                  color: AppColor.apptheme,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Container(
                      height: 80,
                      width: 80,

                      decoration: BoxDecoration(
                        color: AppColor.white,
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
                    SizedBox(height: 8),

                    Container(
                      decoration: BoxDecoration(
                        color: AppColor.rowbox,
                        borderRadius: BorderRadius.circular(20),
                      ),

                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              'assets/imgs/edit.png',
                              height: 16,
                              width: 16,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Edit Photo',
                              style: TextStyle(
                                color: AppColor.apptheme,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 32),

              Text(
                'Personal Details',
                style: TextStyle(
                  color: AppColor.fontColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),

              SizedBox(height: 16),
              Textfield(
                controller: namecontroller,
                title: 'Full name',
                icon: 'assets/imgs/user.png',
                description1: 'Alex Thompson',
                validate: (value) {},
                somethingFocusNode: FocusNode(),
              ),

              SizedBox(height: 16),
              Textfield(
                controller: emailcontroller,
                title: 'email address',
                icon: 'assets/imgs/email.png',
                description1: 'meriemlarbi@mail.com',
                validate: (value) {},
                somethingFocusNode: FocusNode(),
              ),
              SizedBox(height: 16),
              Textfield(
                controller: phonecontroller,
                title: 'phone',
                icon: 'assets/imgs/phone_icon.png',
                description1: '0554629787',
                validate: (value) {},
                somethingFocusNode: FocusNode(),
              ),

              SizedBox(height: 32),

              Text(
                'Security',
                style: TextStyle(
                  color: AppColor.fontColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),

              SizedBox(height: 16),

              Container(
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: InkWell(
                        onTap: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                color: AppColor.fieldBg,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                  'assets/imgs/ps_icon.png',
                                  color: AppColor.apptheme,
                                ),
                              ),
                            ),
                            SizedBox(width: 8,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Change Password',
                                  style: TextStyle(
                                    color: AppColor.fontColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  'Update your account password',
                                  style: TextStyle(
                                    color: AppColor.description,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                            Expanded(child: SizedBox()),
                            Image.asset(
                              'assets/imgs/arrow.png',
                              color: AppColor.fontColor,
                              height: 16,
                              width: 16,
                            ),
                          ],
                        ),
                      ),
                    ),
                
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Divider(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: InkWell(
                        onTap: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                color: AppColor.fieldBg,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                  'assets/imgs/protection.png',
                                  color: AppColor.apptheme,
                                ),
                              ),
                            ),
                            SizedBox(width: 8,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Two-Factor Auth',
                                  style: TextStyle(
                                    color: AppColor.fontColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  'Extra layer of security',
                                  style: TextStyle(
                                    color: AppColor.description,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                            Expanded(child: SizedBox()),
                            Switch(
                              value: pressed,
                              onChanged: (value) {
                                setState(() {
                                  pressed = value;
                                });
                              },
                                      
                              activeTrackColor: AppColor.apptheme,
                              inactiveTrackColor: AppColor.rowbox,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 100,),
            ],
          ),
        ),
      ),
    );
  }
}
