import 'package:flutter_test/flutter_test.dart';
import 'package:workbridge/features/auth/domain/entities/user_entity.dart';

void main() {
  group('UserEntity', () {
    test('supports value equality', () {
      const user1 = UserEntity(
        id: 'usr_1',
        name: 'Ahmed',
        email: 'ahmed@workbridge.eg',
        role: 'JOB_SEEKER',
        avatarUrl: 'https://avatar.com/1',
      );
      const user2 = UserEntity(
        id: 'usr_1',
        name: 'Ahmed',
        email: 'ahmed@workbridge.eg',
        role: 'JOB_SEEKER',
        avatarUrl: 'https://avatar.com/1',
      );
      const user3 = UserEntity(
        id: 'usr_2',
        name: 'Mohamed',
        email: 'mohamed@workbridge.eg',
        role: 'EMPLOYER',
      );

      expect(user1, equals(user2));
      expect(user1, isNot(equals(user3)));
    });

    test('props contains all fields', () {
      const user = UserEntity(
        id: 'usr_1',
        name: 'Ahmed',
        email: 'ahmed@workbridge.eg',
        role: 'JOB_SEEKER',
        avatarUrl: 'https://avatar.com/1',
      );

      expect(user.props, equals(['usr_1', 'Ahmed', 'ahmed@workbridge.eg', 'JOB_SEEKER', 'https://avatar.com/1']));
    });
  });
}
