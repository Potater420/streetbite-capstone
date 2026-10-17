import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:streetbite/core/errors/failure.dart';

/// Converts any thrown error (Dio, Firebase Auth, Firestore) into a [Failure].
/// Repositories call this in their catch blocks so no exception reaches the UI.
class ErrorHandler {
  ErrorHandler._();

  static Failure handle(Object error) {
    if (error is DioException) return _fromDio(error);
    if (error is FirebaseAuthException) return _fromAuth(error);
    if (error is FirebaseException) return _fromFirebase(error);
    return const Failure(FailureType.unknown);
  }

  static Failure _fromDio(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const Failure(FailureType.timeout);
      case DioExceptionType.connectionError:
        return const Failure(FailureType.network);
      case DioExceptionType.badResponse:
        return const Failure(FailureType.server);
      default:
        return const Failure(FailureType.unknown);
    }
  }

  static Failure _fromAuth(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
        return const Failure(FailureType.invalidCredentials);
      case 'email-already-in-use':
        return const Failure(FailureType.emailInUse);
      case 'weak-password':
        return const Failure(FailureType.weakPassword);
      case 'invalid-email':
        return const Failure(FailureType.invalidEmail);
      case 'too-many-requests':
        return const Failure(FailureType.tooManyRequests);
      case 'network-request-failed':
        return const Failure(FailureType.network);
      default:
        return const Failure(FailureType.unknown);
    }
  }

  static Failure _fromFirebase(FirebaseException e) {
    if (e.code == 'unavailable') return const Failure(FailureType.network);
    return const Failure(FailureType.server);
  }
}
