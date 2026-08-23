


import 'package:flutter_application_9_klitou/core/providers/supabase_client_provider.dart';
import 'package:flutter_application_9_klitou/features/auth/repository/profile_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final profileProvider = Provider<ProfileRepository>((ref){
  final client = ref.read(supabaseClientProvider);
  return ProfileRepository(client: client);
});