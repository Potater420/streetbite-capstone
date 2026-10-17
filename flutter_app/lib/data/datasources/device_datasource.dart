import 'dart:typed_data';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:local_auth/local_auth.dart';
import 'package:streetbite/domain/entities/biometric_result.dart';
import 'package:streetbite/domain/entities/device_details.dart';

/// Wraps the device plugins: device_info_plus, local_auth and image_picker.
class DeviceDataSource {
  final LocalAuthentication _localAuth = LocalAuthentication();
  final ImagePicker _picker = ImagePicker();
  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  Future<DeviceDetails> getDeviceDetails() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      final info = await _deviceInfo.androidInfo;
      return DeviceDetails(
        model: '${info.manufacturer} ${info.model}',
        osVersion: 'Android ${info.version.release} (API ${info.version.sdkInt})',
      );
    }
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      final info = await _deviceInfo.iosInfo;
      return DeviceDetails(
        model: info.utsname.machine,
        osVersion: '${info.systemName} ${info.systemVersion}',
      );
    }
    return const DeviceDetails(model: '-', osVersion: '-');
  }

  Future<BiometricResult> authenticate(String reason) async {
    final isSupported = await _localAuth.isDeviceSupported();
    final enrolled = await _localAuth.getAvailableBiometrics();
    if (!isSupported || enrolled.isEmpty) return BiometricResult.unavailable;

    try {
      final success = await _localAuth.authenticate(
        localizedReason: reason,
        biometricOnly: true,
        persistAcrossBackgrounding: true,
      );
      return success ? BiometricResult.success : BiometricResult.failed;
    } catch (_) {
      // Cancelled, locked out, and similar cases all keep the profile locked.
      return BiometricResult.failed;
    }
  }

  Future<Uint8List?> pickPhotoFromGallery() async {
    final file = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 512,
      maxHeight: 512,
      imageQuality: 75,
    );
    return file == null ? null : await file.readAsBytes();
  }
}