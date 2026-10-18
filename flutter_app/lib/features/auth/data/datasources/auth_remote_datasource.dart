import 'package:firebase_auth/firebase_auth.dart';
import 'package:streetbite/core/services/firestore_service.dart';
import 'package:streetbite/features/auth/data/models/user_model.dart';

class AuthRemoteDataSource {
  AuthRemoteDataSource(this._auth, this._firestore);

  final FirebaseAuth _auth;
  final FirestoreService _firestore;

  UserModel? get currentUser {
    final user = _auth.currentUser;
    return user == null ? null : _fromFirebase(user);
  }

  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final credential = await _auth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
    return _fromFirebase(credential.user!);
  }

  Future<UserModel> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
    final firebaseUser = credential.user!;
    await firebaseUser.updateDisplayName(name.trim());

    final user = UserBuilder()
        .setUid(firebaseUser.uid)
        .setName(name.trim())
        .setEmail(email.trim())
        .build();
    await _firestore.setUserData(user.uid, user.toJson());
    return user;
  }

  Future<void> logout() => _auth.signOut();

  UserModel _fromFirebase(User user) => UserBuilder()
      .setUid(user.uid)
      .setName(user.displayName ?? '')
      .setEmail(user.email ?? '')
      .setPhotoUrl(user.photoURL)
      .build();
}