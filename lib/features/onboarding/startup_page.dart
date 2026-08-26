import 'package:flutter/material.dart';
import 'package:flutter_application_9_klitou/core/constants/app_color.dart';


class StartupPage extends StatefulWidget {
  const StartupPage({super.key});

  @override
  State<StartupPage> createState() => _StartupPageState();
}

class _StartupPageState extends State<StartupPage> {

  
  @override
  Widget build(BuildContext context) {
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