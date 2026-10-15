import 'package:streetbite/domain/entities/app_user.dart';
import 'package:streetbite/domain/repositories/auth_repository.dart';

/// Firebase keeps the session across restarts, so this returns the
/// signed-in user (or null) right after launch.
class GetCurrentUserUseCase {
  GetCurrentUserUseCase(this._repository);
  final AuthRepository _repository;

  AppUser? call() => _repository.currentUser;
}