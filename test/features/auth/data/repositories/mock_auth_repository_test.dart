import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:workbridge/core/errors/failures.dart';
import 'package:workbridge/features/auth/data/models/user_model.dart';
import 'package:workbridge/features/auth/data/repositories/mock_auth_repository.dart';

void main() {
  late MockAuthRepository repository;

  setUp(() {
    repository = MockAuthRepository();
  });

  group('MockAuthRepository', () {
    group('login', () {
      test('returns Right(UserModel) on valid credentials', () async {
        final result = await repository.login('youssef.ahmed5002@gmail.com', 'password123');

        expect(result.isRight(), isTrue);
        result.fold(
          (failure) => fail('Should not return failure'),
          (user) {
            expect(user, isA<UserModel>());
            expect(user.id, equals('usr_101'));
            expect(user.email, equals('youssef.ahmed5002@gmail.com'));
          },
        );
      });

      test('returns Left(ServerFailure) on "error@workbridge.eg"', () async {
        final result = await repository.login('error@workbridge.eg', 'password123');

        expect(result.isLeft(), isTrue);
        result.fold(
          (failure) {
            expect(failure, isA<ServerFailure>());
            expect(failure.message, equals('Credentials Are Not Correct'));
          },
          (user) => fail('Should not return user'),
        );
      });
    });

    group('register', () {
      test('returns Right(UserModel) with generated ID', () async {
        final result = await repository.register('Ahmed', 'ahmed@workbridge.eg', 'pass123', 'JOB_SEEKER');

        expect(result.isRight(), isTrue);
        result.fold(
          (failure) => fail('Should not return failure'),
          (user) {
            expect(user, isA<UserModel>());
            expect(user.name, equals('Ahmed'));
            expect(user.email, equals('ahmed@workbridge.eg'));
            expect(user.role, equals('JOB_SEEKER'));
            expect(user.id.startsWith('usr_'), isTrue);
          },
        );
      });
    });

    group('logout', () {
      test('returns Right(null)', () async {
        final result = await repository.logout();

        expect(result, equals(const Right(null)));
      });
    });
  });
}
