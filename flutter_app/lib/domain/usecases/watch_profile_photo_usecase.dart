import 'dart:typed_data';

import 'package:streetbite/domain/repositories/profile_repository.dart';

class WatchProfilePhotoUseCase {
  WatchProfilePhotoUseCase(this._repository);
  final ProfileRepository _repository;

  Stream<Uint8List?> call(String uid) => _repository.watchPhoto(uid);
}