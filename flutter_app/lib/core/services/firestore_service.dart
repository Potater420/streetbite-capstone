import 'package:cloud_firestore/cloud_firestore.dart';

/// A document read from a user's sub-collection.
typedef FirestoreDocument = ({String id, Map<String, dynamic> data});

/// SINGLETON PATTERN: one shared Firestore service for the whole app.
/// The private constructor blocks other instances; everyone uses [instance].
///
/// It only handles plain maps, so `core` never depends on a feature. Each
/// feature's repository converts its own models to and from maps.
class FirestoreService {
  FirestoreService._internal();
  static final FirestoreService instance = FirestoreService._internal();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  DocumentReference<Map<String, dynamic>> _userDoc(String uid) =>
      _db.collection('users').doc(uid);

  /// Live data of the user's document (null while it doesn't exist).
  Stream<Map<String, dynamic>?> watchUserData(String uid) {
    return _userDoc(uid).snapshots().map((snapshot) => snapshot.data());
  }

  /// Writes fields into the user's document (merged by default).
  Future<void> setUserData(
    String uid,
    Map<String, dynamic> data, {
    bool merge = true,
    bool failWhenOffline = false,
  }) {
    final write = _userDoc(uid).set(data, SetOptions(merge: merge));
    return failWhenOffline ? _withTimeout(write) : write;
  }

  /// Removes one key from a map field, e.g. one favourite meal.
  Future<void> removeUserMapEntry(String uid, String field, String key) {
    return _userDoc(uid).set({
      field: {key: FieldValue.delete()},
    }, SetOptions(merge: true));
  }

  /// Writes a document in one of the user's sub-collections (e.g. orders).
  Future<void> setUserDocument(
    String uid,
    String collection,
    String docId,
    Map<String, dynamic> data, {
    bool failWhenOffline = false,
  }) {
    final write = _userDoc(uid).collection(collection).doc(docId).set(data);
    return failWhenOffline ? _withTimeout(write) : write;
  }

  /// Live documents of a sub-collection, sorted by [orderBy].
  Stream<List<FirestoreDocument>> watchUserCollection(
    String uid,
    String collection, {
    required String orderBy,
    bool descending = false,
  }) {
    return _userDoc(uid)
        .collection(collection)
        .orderBy(orderBy, descending: descending)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => (id: doc.id, data: doc.data()))
              .toList(),
        );
  }

  /// Offline writes would wait forever, so report a network problem instead.
  Future<void> _withTimeout(Future<void> write) {
    return write.timeout(
      const Duration(seconds: 10),
      onTimeout: () => throw FirebaseException(
        plugin: 'cloud_firestore',
        code: 'unavailable',
      ),
    );
  }
}