import 'package:streetbite/features/auth/domain/entities/app_user.dart';

class UserModel extends AppUser {
  // Private on purpose: the only way to create a UserModel is UserBuilder.
  const UserModel._({
    required super.uid,
    required super.name,
    required super.email,
    super.photoUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserBuilder()
      .setUid(json['uid'] as String)
      .setName(json['name'] as String)
      .setEmail(json['email'] as String)
      .setPhotoUrl(json['photoUrl'] as String?)
      .build();

  Map<String, dynamic> toJson() => {
    'uid': uid,
    'name': name,
    'email': email,
    'photoUrl': photoUrl,
  };
}

/// BUILDER PATTERN: builds a [UserModel] step by step. Required fields are
/// checked in [build], so an incomplete user can never exist.
class UserBuilder {
  String? _uid;
  String? _name;
  String? _email;
  String? _photoUrl;

  UserBuilder setUid(String uid) {
    _uid = uid;
    return this;
  }

  UserBuilder setName(String name) {
    _name = name;
    return this;
  }

  UserBuilder setEmail(String email) {
    _email = email;
    return this;
  }

  UserBuilder setPhotoUrl(String? photoUrl) {
    _photoUrl = photoUrl;
    return this;
  }

  UserModel build() {
    if (_uid == null || _name == null || _email == null) {
      throw StateError('UserBuilder: uid, name and email are required');
    }
    return UserModel._(
      uid: _uid!,
      name: _name!,
      email: _email!,
      photoUrl: _photoUrl,
    );
  }
}
