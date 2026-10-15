import 'package:equatable/equatable.dart';

class AppUser extends Equatable {
  const AppUser({
    required this.uid,
    required this.name,
    required this.email,
    this.photoUrl,
  });

  final String uid;
  final String name;
  final String email;
  final String? photoUrl;

  @override
  List<Object?> get props => [uid, name, email, photoUrl];
}