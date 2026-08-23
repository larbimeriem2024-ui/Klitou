import 'package:flutter/material.dart';
import 'package:flutter_application_9_klitou/onboarding/startup_page.dart';
import 'package:flutter_application_9_klitou/features/auth/pages/login/forget_password_password.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


final GlobalKey<NavigatorState> navigatorKey =
    GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  

  await Supabase.initialize(
    
    url: 'https://yomroabkrtezxcseollb.supabase.co',
    publishableKey:'sb_publishable_KFff4Q1jCdKZagy0Svk1Ag_YP5f4pdB' ,
  );

  Supabase.instance.client.auth.onAuthStateChange.listen((data) {
  if (data.event == AuthChangeEvent.passwordRecovery) {
    navigatorKey.currentState?.push(
      MaterialPageRoute(
        builder: (_) => ForgetPasswordPassword(),
      ),
    );
  }
});
  runApp(
    
    ProviderScope(
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      
      
      home: StartupPage(),
    );
  }
}
