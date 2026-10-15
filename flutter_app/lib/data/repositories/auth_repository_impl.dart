import 'package:streetbite/core/errors/error_handler.dart';
import 'package:streetbite/data/datasources/auth_remote_datasource.dart';
import 'package:streetbite/domain/entities/app_user.dart';
import 'package:streetbite/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._dataSource);

  final AuthRemoteDataSource _dataSource;

  @override
  AppUser? get currentUser => _dataSource.currentUser;

  // Every method turns any exception into a Failure, so nothing unhandled
  // reaches the UI.
  @override
  Future<AppUser> login({required String email, required String password}) async {
    try {
      return await _dataSource.login(email: email, password: password);
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  @override
  Future<AppUser> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      return await _dataSource.signUp(
        name: name,
        email: email,
        password: password,
      );
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _dataSource.logout();
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }
}