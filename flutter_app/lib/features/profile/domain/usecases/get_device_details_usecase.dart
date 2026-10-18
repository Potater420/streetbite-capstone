import 'package:streetbite/features/profile/domain/entities/device_details.dart';
import 'package:streetbite/features/profile/domain/repositories/device_repository.dart';

class GetDeviceDetailsUseCase {
  GetDeviceDetailsUseCase(this._repository);
  final DeviceRepository _repository;

  Future<DeviceDetails> call() => _repository.getDeviceDetails();
}
