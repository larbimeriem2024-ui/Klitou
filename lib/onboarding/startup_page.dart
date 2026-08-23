import 'package:flutter/material.dart';
import 'package:flutter_application_9_klitou/core/constants/app_color.dart';
import 'package:flutter_application_9_klitou/onboarding/onboarding_page.dart';
import 'package:flutter_application_9_klitou/views/main_tab_view/main_tab_view.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class StartupPage extends StatefulWidget {
  const StartupPage({super.key});

  @override
  State<StartupPage> createState() => _StartupPageState();
}

class _StartupPageState extends State<StartupPage> {

  @override
  void initState(){
    super.initState();
    _checkUserSessionn();
  }

  Future <void> _checkUserSessionn()async{
    final session = Supabase.instance.client.auth.currentSession;
    await Future.delayed(Duration(seconds: 3)
    );
    if(session != null){
       Navigator.pushReplacement(
      context, 
      MaterialPageRoute(builder: (_) => const MainTabView(),));

    }else{
       Navigator.pushReplacement(
      context, 
      MaterialPageRoute(builder: (_) => const OnboardingPage(),));
    }
   
  }
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