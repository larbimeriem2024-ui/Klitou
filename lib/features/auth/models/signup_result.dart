sealed class SignupResult {
  const SignupResult();
}

class SignupAuthenticated extends SignupResult {
  const SignupAuthenticated();
}

class SignupEmailVerificationRequired extends SignupResult {
  const SignupEmailVerificationRequired();
}