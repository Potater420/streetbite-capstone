import 'package:streetbite/features/auth/domain/entities/app_user.dart';

/// Contract only. The data layer implements it, so the domain layer
/// never depends on Firebase.
abstract class AuthRepository {
  AppUser? get currentUser;

  Future<AppUser> login({required String email, required String password});

  Future<AppUser> signUp({
    required String name,
    required String email,
    required String password,
  });

  Future<void> logout();
}
