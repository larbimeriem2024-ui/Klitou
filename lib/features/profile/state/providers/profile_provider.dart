



import 'package:flutter_application_9_klitou/shared/providers/supabase_client_provider.dart';
import 'package:flutter_application_9_klitou/features/auth/state/providers/auth_provider.dart';
import 'package:flutter_application_9_klitou/features/profile/model.dart/profile_model.dart';
import 'package:flutter_application_9_klitou/features/profile/repository/profile_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final profileRepositoryProvider = Provider((ref) {
  final client = ref.read(supabaseClientProvider);
  return ProfileRepository(client: client);
},);



// here you can access to the profile table you can get name, email, phone and way more 
final currentProfileProvider = FutureProvider<Profile>((ref) {
  final user = ref.watch(currentUserProvider);

  

  if(user == null){

    throw Exception('User not authenticated');

  }

  return ref.read(profileRepositoryProvider).getProfile(user.id);
  
},);