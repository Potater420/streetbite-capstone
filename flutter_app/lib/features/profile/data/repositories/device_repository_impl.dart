import 'dart:typed_data';

import 'package:streetbite/core/errors/error_handler.dart';
import 'package:streetbite/features/profile/data/datasources/device_datasource.dart';
import 'package:streetbite/features/profile/domain/entities/biometric_result.dart';
import 'package:streetbite/features/profile/domain/entities/device_details.dart';
import 'package:streetbite/features/profile/domain/repositories/device_repository.dart';

class DeviceRepositoryImpl implements DeviceRepository {
  DeviceRepositoryImpl(this._dataSource);

  final DeviceDataSource _dataSource;

  @override
  Future<DeviceDetails> getDeviceDetails() async {
    try {
      return await _dataSource.getDeviceDetails();
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  // The data source already turns every outcome into a BiometricResult.
  @override
  Future<BiometricResult> authenticate(String reason) =>
      _dataSource.authenticate(reason);

  @override
  Future<Uint8List?> pickPhotoFromGallery() async {
    try {
      return await _dataSource.pickPhotoFromGallery();
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }
}
