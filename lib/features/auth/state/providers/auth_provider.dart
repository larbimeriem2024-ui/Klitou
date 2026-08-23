


import 'package:flutter_application_9_klitou/core/providers/supabase_client_provider.dart';
import 'package:flutter_application_9_klitou/features/auth/repository/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authProvider = Provider<AuthRepository>((ref){
  final client = ref.read(supabaseClientProvider);
  return AuthRepository(client: client);

});