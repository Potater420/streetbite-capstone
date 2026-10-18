import 'dart:typed_data';

abstract class ProfileRepository {
  /// Live profile photo (null when none has been set).
  Stream<Uint8List?> watchPhoto(String uid);

  Future<void> savePhoto(String uid, Uint8List bytes);
}
