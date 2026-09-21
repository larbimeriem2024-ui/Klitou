sealed class AuthFailure implements Exception {
  const AuthFailure();
}

class EmailAlreadyRegistered extends AuthFailure {
  const EmailAlreadyRegistered();
}

class InvalidCredentials extends AuthFailure {
  const InvalidCredentials();
}

class InvalidEmail extends AuthFailure {
  const InvalidEmail();
}

class WeakPassword extends AuthFailure {
  const WeakPassword();
}

class NetworkFailure extends AuthFailure {
  const NetworkFailure();
}

class UnknownAuthFailure extends AuthFailure {
  const UnknownAuthFailure();
}