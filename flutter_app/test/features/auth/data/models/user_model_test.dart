import 'package:flutter_test/flutter_test.dart';
import 'package:streetbite/features/auth/data/models/user_model.dart';

void main() {
  test('UserBuilder builds a user from its parts', () {
    final user = UserBuilder()
        .setUid('u1')
        .setName('Peter')
        .setEmail('peter@gmail.com')
        .build();

    expect(user.uid, 'u1');
    expect(user.name, 'Peter');
    expect(user.photoUrl, isNull);
  });

  test('UserBuilder refuses to build an incomplete user', () {
    expect(() => UserBuilder().setUid('u1').build(), throwsStateError);
  });

  test('toJson and fromJson round trip', () {
    final user = UserBuilder()
        .setUid('u1')
        .setName('Peter')
        .setEmail('peter@gmail.com')
        .build();

    expect(UserModel.fromJson(user.toJson()), user);
  });
}
