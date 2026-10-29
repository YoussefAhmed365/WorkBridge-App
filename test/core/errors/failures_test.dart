import 'package:flutter_test/flutter_test.dart';
import 'package:workbridge/core/errors/failures.dart';

void main() {
  group('ServerFailure', () {
    test('supports value equality', () {
      const failure1 = ServerFailure('Server Error', statusCode: 500);
      const failure2 = ServerFailure('Server Error', statusCode: 500);
      const failure3 = ServerFailure('Different Error', statusCode: 500);

      expect(failure1, equals(failure2));
      expect(failure1, isNot(equals(failure3)));
    });

    test('props contains message and statusCode', () {
      const failure = ServerFailure('Unauthorized', statusCode: 401);
      expect(failure.props, equals(['Unauthorized', 401]));
    });
  });
}
