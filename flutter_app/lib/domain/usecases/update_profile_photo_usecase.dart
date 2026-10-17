import 'package:streetbite/domain/repositories/device_repository.dart';
import 'package:streetbite/domain/repositories/profile_repository.dart';

/// Lets the user pick a gallery photo, then saves it to Firestore.
class UpdateProfilePhotoUseCase {
  UpdateProfilePhotoUseCase(this._device, this._profile);

  final DeviceRepository _device;
  final ProfileRepository _profile;

  Future<void> call(String uid) async {
    final bytes = await _device.pickPhotoFromGallery();
    if (bytes == null) return; // the user cancelled the picker
    await _profile.savePhoto(uid, bytes);
  }
}