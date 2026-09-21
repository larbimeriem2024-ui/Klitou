


import 'package:flutter_application_9_klitou/features/auth/models/signup_result.dart';
import 'package:flutter_application_9_klitou/features/auth/state/notifier/signup_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final signupNotifierProvider =
    AsyncNotifierProvider<SignupNotifier, SignupResult?>(SignupNotifier.new);