import 'package:flutter_application_9_klitou/features/auth/models/signup_result.dart';
import 'package:flutter_application_9_klitou/features/auth/state/providers/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignupNotifier extends AsyncNotifier<SignupResult?> {
  @override
  Future<SignupResult?> build() async {
    return null;

  }

  Future<void> signup({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      return await ref.read(authRepositoryProvider).signUp(
        email,
        password,
        name,
        phone,
      );
    });
  }
}

