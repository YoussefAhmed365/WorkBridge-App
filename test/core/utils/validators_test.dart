import 'package:flutter_test/flutter_test.dart';
import 'package:workbridge/core/utils/validators.dart';
import 'package:workbridge/generated/l10n.dart';

class FakeS implements S {
  @override
  String get errorFieldIsEmpty => 'Field is required';

  @override
  String get errorPhoneOrEmailField => 'Invalid phone or email format';

  @override
  String get errorConfirmPasswordField => 'Password requirement not met';

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  late FakeS mockS;

  setUp(() {
    mockS = FakeS();
  });

  group('Validators', () {
    group('validatePhoneOrEmail', () {
      test('returns error when value is null or empty', () {
        expect(Validators.validatePhoneOrEmail(null, mockS), equals('Field is required'));
        expect(Validators.validatePhoneOrEmail('', mockS), equals('Field is required'));
        expect(Validators.validatePhoneOrEmail('   ', mockS), equals('Field is required'));
      });

      test('returns null for valid email addresses', () {
        expect(Validators.validatePhoneOrEmail('test@workbridge.eg', mockS), isNull);
        expect(Validators.validatePhoneOrEmail('user.name@domain.com', mockS), isNull);
      });

      test('returns null for valid Egyptian phone numbers', () {
        expect(Validators.validatePhoneOrEmail('01012345678', mockS), isNull);
        expect(Validators.validatePhoneOrEmail('01198765432', mockS), isNull);
        expect(Validators.validatePhoneOrEmail('+201234567890', mockS), isNull);
      });

      test('returns error for invalid email or phone formats', () {
        expect(Validators.validatePhoneOrEmail('invalid-email', mockS), equals('Invalid phone or email format'));
        expect(Validators.validatePhoneOrEmail('12345', mockS), equals('Invalid phone or email format'));
        expect(Validators.validatePhoneOrEmail('01312345678', mockS), equals('Invalid phone or email format'));
      });
    });

    group('validatePassword', () {
      test('returns error when password is null or empty', () {
        expect(Validators.validatePassword(null, mockS), equals('Field is required'));
        expect(Validators.validatePassword('', mockS), equals('Field is required'));
      });

      test('returns error when password length is less than 6', () {
        expect(Validators.validatePassword('12345', mockS), equals('Password requirement not met'));
      });

      test('returns null when password length is 6 or more', () {
        expect(Validators.validatePassword('123456', mockS), isNull);
        expect(Validators.validatePassword('valid_input', mockS), isNull);
      });
    });

    group('validateConfirmPassword', () {
      test('returns error when confirm password is null or empty', () {
        expect(Validators.validateConfirmPassword(null, 'ValidInput#1', mockS), equals('Field is required'));
        expect(Validators.validateConfirmPassword('', 'ValidInput#1', mockS), equals('Field is required'));
      });

      test('returns error when confirm password does not match password', () {
        expect(Validators.validateConfirmPassword('ValidInput', 'ValidInput#1', mockS), equals('Password requirement not met'));
      });

      test('returns null when confirm password matches password', () {
        expect(Validators.validateConfirmPassword('ValidInput#1', 'ValidInput#1', mockS), isNull);
      });
    });

    group('Rule Checks & Strength Calculations', () {
      test('hasMinLength checks boundary lengths', () {
        expect(Validators.hasMinLength('1234567'), isFalse);
        expect(Validators.hasMinLength('12345678'), isTrue);
      });

      test('hasNumberOrSymbol checks numbers and symbols', () {
        expect(Validators.hasNumberOrSymbol('abcdef'), isFalse);
        expect(Validators.hasNumberOrSymbol('abcdef1'), isTrue);
        expect(Validators.hasNumberOrSymbol('abcdef!'), isTrue);
      });

      test('hasUpperAndLower checks uppercase and lowercase', () {
        expect(Validators.hasUpperAndLower('lowercase'), isFalse);
        expect(Validators.hasUpperAndLower('UPPERCASE'), isFalse);
        expect(Validators.hasUpperAndLower('UpperLower'), isTrue);
      });

      test('calculatePasswordStrength calculates score correctly', () {
        expect(Validators.calculatePasswordStrength(''), equals(0));
        expect(Validators.calculatePasswordStrength('abc'), equals(1)); // non-empty
        expect(Validators.calculatePasswordStrength('abcdefgh'), equals(2)); // non-empty + min length
        expect(Validators.calculatePasswordStrength('abcdefg1'), equals(3)); // non-empty + min length + num
        expect(Validators.calculatePasswordStrength('Abcdefg1'), equals(4)); // all met
      });
    });
  });
}
