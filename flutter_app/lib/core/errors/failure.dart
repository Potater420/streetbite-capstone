import 'package:equatable/equatable.dart';

enum FailureType {
  network,
  timeout,
  server,
  invalidCredentials,
  emailInUse,
  weakPassword,
  invalidEmail,
  tooManyRequests,
  unknown,
  invalidCard,
}

class Failure extends Equatable implements Exception {
  const Failure(this.type);

  final FailureType type;

  @override
  List<Object?> get props => [type];
}
