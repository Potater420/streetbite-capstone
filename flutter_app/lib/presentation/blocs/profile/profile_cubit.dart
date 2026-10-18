import 'dart:async';
import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streetbite/core/errors/failure.dart';
import 'package:streetbite/domain/usecases/get_device_details_usecase.dart';
import 'package:streetbite/domain/usecases/update_profile_photo_usecase.dart';
import 'package:streetbite/domain/usecases/watch_profile_photo_usecase.dart';
import 'package:streetbite/presentation/blocs/profile/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._watchPhoto, this._updatePhoto, this._getDevice)
    : super(const ProfileState());

  final WatchProfilePhotoUseCase _watchPhoto;
  final UpdateProfilePhotoUseCase _updatePhoto;
  final GetDeviceDetailsUseCase _getDevice;

  StreamSubscription<Uint8List?>? _subscription;
  String? _uid;

  Future<void> start(String uid) async {
    _uid = uid;
    // Live photo: updates the moment Firestore changes, even before the
    // upload finishes.
    _subscription = _watchPhoto(uid).listen(
      (bytes) => emit(state.copyWith(photo: bytes)),
      onError: (Object error) {
        if (error is Failure) emit(state.copyWith(failure: error));
      },
    );

    try {
      final device = await _getDevice();
      if (!isClosed) emit(state.copyWith(device: device));
    } on Failure catch (failure) {
      if (!isClosed) emit(state.copyWith(failure: failure));
    }
  }

  Future<void> changePhoto() async {
    final uid = _uid;
    if (uid == null || state.isUploading) return;

    emit(state.copyWith(isUploading: true));
    try {
      await _updatePhoto(uid);
      if (!isClosed) emit(state.copyWith(isUploading: false));
    } on Failure catch (failure) {
      if (!isClosed) emit(state.copyWith(isUploading: false, failure: failure));
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
