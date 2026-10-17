import 'dart:typed_data';

import 'package:streetbite/domain/entities/biometric_result.dart';
import 'package:streetbite/domain/entities/device_details.dart';

/// Features that come from the phone itself.
abstract class DeviceRepository {
  Future<DeviceDetails> getDeviceDetails();

  Future<BiometricResult> authenticate(String reason);

  /// Returns the picked image, or null if the user cancelled.
  Future<Uint8List?> pickPhotoFromGallery();
}
