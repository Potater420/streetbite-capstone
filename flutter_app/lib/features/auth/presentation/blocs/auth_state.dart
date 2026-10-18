import 'package:streetbite/core/errors/failure.dart';
import 'package:streetbite/features/auth/domain/entities/app_user.dart';

// No Equatable on purpose: two identical errors in a row must both emit,
// so the SnackBar shows every time.
sealed class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class Authenticated extends AuthState {
  const Authenticated(this.user);
  final AppUser user;
}

class Unauthenticated extends AuthState {
  const Unauthenticated();
}

class AuthError extends AuthState {
  AuthError(this.failure);
  final Failure failure;
}
