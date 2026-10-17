import 'package:streetbite/domain/entities/device_details.dart';
import 'package:streetbite/domain/repositories/device_repository.dart';

class GetDeviceDetailsUseCase {
  GetDeviceDetailsUseCase(this._repository);
  final DeviceRepository _repository;

  Future<DeviceDetails> call() => _repository.getDeviceDetails();
}
