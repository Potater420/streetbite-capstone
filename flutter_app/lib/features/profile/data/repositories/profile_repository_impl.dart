import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:streetbite/core/errors/error_handler.dart';
import 'package:streetbite/core/services/firestore_service.dart';
import 'package:streetbite/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRepositoryImpl(this._service);

  final FirestoreService _service;

  /// The photo is a small base64 string inside the user's document.
  static const _field = 'photoBase64';

  @override
  Stream<Uint8List?> watchPhoto(String uid) {
    return _service
        .watchUserData(uid)
        .transform(
          StreamTransformer<Map<String, dynamic>?, Uint8List?>.fromHandlers(
            handleData: (data, sink) {
              try {
                final base64Photo = data?[_field] as String?;
                sink.add(base64Photo == null ? null : base64Decode(base64Photo));
              } catch (e) {
                sink.addError(ErrorHandler.handle(e));
              }
            },
            handleError: (error, stackTrace, sink) =>
                sink.addError(ErrorHandler.handle(error), stackTrace),
          ),
        );
  }

  @override
  Future<void> savePhoto(String uid, Uint8List bytes) async {
    try {
      await _service.setUserData(uid, {
        _field: base64Encode(bytes),
      }, failWhenOffline: true);
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }
}