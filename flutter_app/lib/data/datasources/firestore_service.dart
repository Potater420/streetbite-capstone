import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:streetbite/data/models/meal_model.dart';
import 'package:streetbite/data/models/user_model.dart';
import 'package:streetbite/data/models/order_model.dart';

/// SINGLETON PATTERN: one shared Firestore service for the whole app.
/// The private constructor blocks other instances; everyone uses [instance].
/// Orders get added here in Phase 5.
class FirestoreService {
  FirestoreService._internal();
  static final FirestoreService instance = FirestoreService._internal();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  DocumentReference<Map<String, dynamic>> _userDoc(String uid) =>
      _db.collection('users').doc(uid);

  Future<void> saveUser(UserModel user) {
    return _userDoc(user.uid).set(user.toJson());
  }

  /// Favourites live inside the user's document as a map keyed by meal id.
  Stream<List<MealModel>> watchFavorites(String uid) {
    return _userDoc(uid).snapshots().map((snapshot) {
      final favorites =
          (snapshot.data()?['favorites'] as Map<String, dynamic>?) ?? {};
      final meals = favorites.values
          .map((e) => MealModel.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList();
      meals.sort((a, b) => a.name.compareTo(b.name));
      return meals;
    });
  }

  Future<void> addFavorite(String uid, MealModel meal) {
    return _userDoc(uid).set({
      'favorites': {meal.id: meal.toJson()},
    }, SetOptions(merge: true));
  }

  Future<void> removeFavorite(String uid, String mealId) {
    return _userDoc(uid).set({
      'favorites': {mealId: FieldValue.delete()},
    }, SetOptions(merge: true));
  }

    /// Orders live in the user's `orders` subcollection.
  Future<void> placeOrder(String uid, OrderModel order) {
    return _userDoc(uid)
        .collection('orders')
        .doc(order.id)
        .set(order.toJson())
        .timeout(
          const Duration(seconds: 10),
          // Offline writes would wait forever, so report a network problem.
          onTimeout: () => throw FirebaseException(
            plugin: 'cloud_firestore',
            code: 'unavailable',
          ),
        );
  }

    Stream<List<OrderModel>> watchOrders(String uid) {
    return _userDoc(uid)
        .collection('orders')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => OrderModel.fromJson(doc.id, doc.data()))
              .toList(),
        );
  }
}