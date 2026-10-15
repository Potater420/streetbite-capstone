import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:streetbite/data/models/user_model.dart';

/// SINGLETON PATTERN: one shared Firestore service for the whole app.
/// The private constructor blocks other instances; everyone uses [instance].
/// Orders and favourites get added here in later phases.
class FirestoreService {
  FirestoreService._internal();
  static final FirestoreService instance = FirestoreService._internal();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveUser(UserModel user) {
    return _db.collection('users').doc(user.uid).set(user.toJson());
  }
}