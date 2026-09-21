import 'package:flutter_application_9_klitou/features/auth/state/notifier/login_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginNotifierProvider =
    AsyncNotifierProvider<LoginNotifier, void>(
  LoginNotifier.new,
);

final forgotPasswordNotifierProvider =
    AsyncNotifierProvider<ForgotPasswordNotifier, void>(
  ForgotPasswordNotifier.new,
);

final resetPasswordNotifierProvider =
    AsyncNotifierProvider<ResetPasswordNotifier, void>(
  ResetPasswordNotifier.new,
);