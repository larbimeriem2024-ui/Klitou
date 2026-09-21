import 'auth_failure.dart';

String getAuthErrorMessage(Object error) {
  if (error is EmailAlreadyRegistered) {
    return 'This email is already registered.';
  }

  if (error is InvalidCredentials) {
    return 'The email or password is incorrect.';
  }

  if (error is InvalidEmail) {
    return 'Please enter a valid email address.';
  }

  if (error is WeakPassword) {
    return 'Your password is too weak.';
  }

  if (error is NetworkFailure) {
    return 'Please check your internet connection and try again.';
  }

  return 'Something went wrong. Please try again.';
}