import 'package:equatable/equatable.dart';

class DeviceDetails extends Equatable {
  const DeviceDetails({required this.model, required this.osVersion});

  final String model;
  final String osVersion;

  @override
  List<Object?> get props => [model, osVersion];
}
