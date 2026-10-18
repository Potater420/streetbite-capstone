import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streetbite/core/errors/failure.dart';
import 'package:streetbite/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:streetbite/features/auth/domain/usecases/login_usecase.dart';
import 'package:streetbite/features/auth/domain/usecases/logout_usecase.dart';
import 'package:streetbite/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:streetbite/features/auth/presentation/blocs/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._login, this._signUp, this._logout, this._getCurrentUser)
    : super(const AuthInitial());

  final LoginUseCase _login;
  final SignUpUseCase _signUp;
  final LogoutUseCase _logout;
  final GetCurrentUserUseCase _getCurrentUser;

  /// Called by the splash screen: restores the saved session, if any.
  void checkAuth() {
    final user = _getCurrentUser();
    emit(user == null ? const Unauthenticated() : Authenticated(user));
  }

  Future<void> login({required String email, required String password}) async {
    emit(const AuthLoading());
    try {
      final user = await _login(email: email, password: password);
      emit(Authenticated(user));
    } on Failure catch (failure) {
      emit(AuthError(failure));
    }
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(const AuthLoading());
    try {
      final user = await _signUp(name: name, email: email, password: password);
      emit(Authenticated(user));
    } on Failure catch (failure) {
      emit(AuthError(failure));
    }
  }

  Future<void> logout() async {
    try {
      await _logout();
      emit(const Unauthenticated());
    } on Failure catch (failure) {
      emit(AuthError(failure));
    }
  }
}
