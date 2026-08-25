import 'package:flutter/material.dart';
import 'package:flutter_application_9_klitou/app/navigation/app_router.dart';
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

 
  runApp(
    
    ProviderScope(
      child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      

    );
  }
}
