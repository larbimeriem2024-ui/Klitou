import 'package:flutter/material.dart';
import 'package:flutter_application_9_klitou/views/main_tab_view/main_tab_view.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class AuthGate extends StatelessWidget {
  final Widget page;
  const AuthGate({super.key,required this.page});

  

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthState>(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        final session = Supabase.instance.client.auth.currentSession;
        return session != null ? const MainTabView() :  page;
      },
    );
  }
}

