import 'package:streetbite/domain/entities/app_user.dart';
import 'package:streetbite/domain/repositories/auth_repository.dart';

class SignUpUseCase {
  SignUpUseCase(this._repository);
  final AuthRepository _repository;

  Future<AppUser> call({
    required String name,
    required String email,
    required String password,
  }) => _repository.signUp(name: name, email: email, password: password);
}
