import 'package:streetbite/domain/entities/biometric_result.dart';
import 'package:streetbite/domain/repositories/device_repository.dart';

class AuthenticateWithBiometricsUseCase {
  AuthenticateWithBiometricsUseCase(this._repository);
  final DeviceRepository _repository;

  Future<BiometricResult> call(String reason) =>
      _repository.authenticate(reason);
}
