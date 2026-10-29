import 'package:flutter_test/flutter_test.dart';
import 'package:workbridge/features/auth/data/models/user_model.dart';
import 'package:workbridge/features/auth/domain/entities/user_entity.dart';

void main() {
  group('UserModel', () {
    const tUserModel = UserModel(
      id: 'usr_101',
      name: 'Youssef Ahmed',
      email: 'youssef@workbridge.eg',
      role: 'JOB_SEEKER',
      avatarUrl: 'https://avatar.com/youssef',
    );

    test('is a subclass of UserEntity', () {
      expect(tUserModel, isA<UserEntity>());
    });

    group('fromJson', () {
      test('deserializes valid json correctly', () {
        final Map<String, dynamic> jsonMap = {
          'id': 'usr_101',
          'name': 'Youssef Ahmed',
          'email': 'youssef@workbridge.eg',
          'role': 'JOB_SEEKER',
          'avatarUrl': 'https://avatar.com/youssef',
        };

        final result = UserModel.fromJson(jsonMap);

        expect(result, equals(tUserModel));
      });

      test('applies default fallback values for missing fields', () {
        final Map<String, dynamic> jsonMap = {};

        final result = UserModel.fromJson(jsonMap);

        expect(result.id, equals(''));
        expect(result.name, equals(''));
        expect(result.email, equals(''));
        expect(result.role, equals('JOB_SEEKER'));
        expect(result.avatarUrl, isNull);
      });
    });

    group('toJson', () {
      test('serializes UserModel to Map matching json contract', () {
        final result = tUserModel.toJson();

        final expectedMap = {
          'id': 'usr_101',
          'name': 'Youssef Ahmed',
          'email': 'youssef@workbridge.eg',
          'role': 'JOB_SEEKER',
          'avatarUrl': 'https://avatar.com/youssef',
        };

        expect(result, equals(expectedMap));
      });
    });
  });
}
