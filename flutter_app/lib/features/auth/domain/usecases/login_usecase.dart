import 'package:streetbite/features/auth/domain/entities/app_user.dart';
import 'package:streetbite/features/auth/domain/repositories/auth_repository.dart';

class LoginUseCase {
  LoginUseCase(this._repository);
  final AuthRepository _repository;

  Future<AppUser> call({required String email, required String password}) =>
      _repository.login(email: email, password: password);
}
