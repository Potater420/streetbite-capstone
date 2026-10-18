import 'dart:typed_data';

import 'package:streetbite/core/errors/failure.dart';
import 'package:streetbite/features/profile/domain/entities/device_details.dart';

// No Equatable on purpose: repeated errors must still emit.
class ProfileState {
  const ProfileState({
    this.photo,
    this.device,
    this.isUploading = false,
    this.failure,
  });

  final Uint8List? photo;
  final DeviceDetails? device;
  final bool isUploading;
  final Failure? failure;

  /// The failure is never carried over: it only exists for one emission.
  ProfileState copyWith({
    Uint8List? photo,
    DeviceDetails? device,
    bool? isUploading,
    Failure? failure,
  }) {
    return ProfileState(
      photo: photo ?? this.photo,
      device: device ?? this.device,
      isUploading: isUploading ?? this.isUploading,
      failure: failure,
    );
  }
}
