import 'package:flutter/material.dart';
import 'package:flutter_application_9_klitou/app/navigation/app_router.dart';
import 'package:flutter_application_9_klitou/core/constants/app_color.dart';
import 'package:flutter_application_9_klitou/features/auth/state/providers/auth_provider.dart';
import 'package:flutter_application_9_klitou/shared/providers/notification_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
  

  await Supabase.initialize(
    
    url: 'https://yomroabkrtezxcseollb.supabase.co',
    publishableKey:'sb_publishable_KFff4Q1jCdKZagy0Svk1Ag_YP5f4pdB' ,
  );

 
  runApp(
    
    ProviderScope(
      child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<User?>(currentUserProvider, (previous, next) {
      // Only initialize when user goes from null → non-null
      if (previous == null && next != null) {
        ref.read(notificationServiceProvider).initialize();
      }

      // Optional: clean up token on logout
      // if (previous != null && next == null) {
      //   ref.read(notificationServiceProvider).deleteToken();
      // }
    });
    final router = ref.watch(goRouterProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
       theme: ThemeData(
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: AppColor.apptheme,
    ),
  ),
      

    );
  }
}
