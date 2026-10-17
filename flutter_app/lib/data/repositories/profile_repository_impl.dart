import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:streetbite/core/errors/error_handler.dart';
import 'package:streetbite/data/datasources/firestore_service.dart';
import 'package:streetbite/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRepositoryImpl(this._service);

  final FirestoreService _service;

  @override
  Stream<Uint8List?> watchPhoto(String uid) {
    return _service.watchProfilePhoto(uid).transform(
          StreamTransformer<String?, Uint8List?>.fromHandlers(
            handleData: (base64Photo, sink) {
              try {
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
      await _service.saveProfilePhoto(uid, base64Encode(bytes));
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }
}