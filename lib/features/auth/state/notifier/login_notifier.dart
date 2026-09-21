import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_application_9_klitou/features/auth/state/providers/auth_provider.dart';



class LoginNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<void> login({
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      await ref.read(authRepositoryProvider).login(
        email: email,
        password: password,
      );
    });
  }
}





class ForgotPasswordNotifier extends AsyncNotifier<void> {

  @override
  Future<void> build() async {}

  Future<void> sendResetEmail(String email) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      await ref
          .read(authRepositoryProvider)
          .verifyEmailForRestPassword(email);
    });
  }
}


class ResetPasswordNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<void> resetPassword(String newPassword) async {

    debugPrint('RESET: button called');
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      debugPrint('RESET: calling repository');
      await ref
          .read(authRepositoryProvider)
          .resetPassword(newPassword);

          debugPrint('Reset: repository succeeded');
    });
        debugPrint('RESET: final state = $state');
  } 
}