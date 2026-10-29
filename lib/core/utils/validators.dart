import 'package:workbridge/generated/l10n.dart';

class Validators {
  static String? validatePhoneOrEmail(String? value, S l10n) {
    if (value == null || value.trim().isEmpty) {
      return l10n.errorFieldIsEmpty;
    }
    final trimmed = value.trim();
    final emailRegex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
    final phoneRegex = RegExp(r'^(01[0125]\d{8}|\+?201[0125]\d{8})$');

    if (!emailRegex.hasMatch(trimmed) && !phoneRegex.hasMatch(trimmed)) {
      return l10n.errorPhoneOrEmailField;
    }
    return null;
  }

  static String? validatePassword(String? value, S l10n) {
    if (value == null || value.isEmpty) {
      return l10n.errorFieldIsEmpty;
    }
    if (value.length < 6) {
      return l10n.errorConfirmPasswordField;
    }
    return null;
  }

  static String? validateConfirmPassword(String? value, String password, S l10n) {
    if (value == null || value.isEmpty) {
      return l10n.errorFieldIsEmpty;
    }
    if (value != password) {
      return l10n.errorConfirmPasswordField;
    }
    return null;
  }

  static bool hasMinLength(String text, {int minLength = 8}) {
    return text.length >= minLength;
  }

  static bool hasNumberOrSymbol(String text) {
    return RegExp(r'[0-9!@#$%^&*(),.?":{}|<>]').hasMatch(text);
  }

  static bool hasUpperAndLower(String text) {
    return RegExp(r'(?=.*[a-z])(?=.*[A-Z])').hasMatch(text);
  }

  static int calculatePasswordStrength(String text) {
    int score = 0;
    if (text.isNotEmpty) score++;
    if (hasMinLength(text)) score++;
    if (hasNumberOrSymbol(text)) score++;
    if (hasUpperAndLower(text)) score++;
    return score;
  }
}
