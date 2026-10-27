import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:workbridge/core/theme/theme_extension.dart';

void main() {
  group('WorkBridgeThemeExtension', () {
    const lightTheme = WorkBridgeThemeExtension.light;
    const darkTheme = WorkBridgeThemeExtension.dark;

    test('copyWith retains existing colors when fields are omitted', () {
      final copied = lightTheme.copyWith();

      expect(copied.tagBackground, equals(lightTheme.tagBackground));
      expect(copied.tagForeground, equals(lightTheme.tagForeground));
      expect(copied.matchBackground, equals(lightTheme.matchBackground));
      expect(copied.matchForeground, equals(lightTheme.matchForeground));
      expect(copied.activeFilterBackground, equals(lightTheme.activeFilterBackground));
      expect(copied.activeFilterBorder, equals(lightTheme.activeFilterBorder));
      expect(copied.warningBackground, equals(lightTheme.warningBackground));
      expect(copied.warningForeground, equals(lightTheme.warningForeground));
      expect(copied.warningBorder, equals(lightTheme.warningBorder));
      expect(copied.successBackground, equals(lightTheme.successBackground));
      expect(copied.successForeground, equals(lightTheme.successForeground));
      expect(copied.dangerBackground, equals(lightTheme.dangerBackground));
      expect(copied.dangerForeground, equals(lightTheme.dangerForeground));
    });

    test('copyWith updates specified colors correctly', () {
      const customColor = Color(0xFF123456);
      final copied = lightTheme.copyWith(tagBackground: customColor);

      expect(copied.tagBackground, equals(customColor));
      expect(copied.tagForeground, equals(lightTheme.tagForeground));
    });

    test('lerp returns self when other is null', () {
      final lerped = lightTheme.lerp(null, 0.5);

      expect(lerped.tagBackground, equals(lightTheme.tagBackground));
      expect(lerped.matchBackground, equals(lightTheme.matchBackground));
    });

    test('lerp correctly interpolates between light and dark palettes at t = 0.5', () {
      final lerped = lightTheme.lerp(darkTheme, 0.5);

      final expectedTagBackground = Color.lerp(lightTheme.tagBackground, darkTheme.tagBackground, 0.5);
      final expectedMatchForeground = Color.lerp(lightTheme.matchForeground, darkTheme.matchForeground, 0.5);

      expect(lerped.tagBackground, equals(expectedTagBackground));
      expect(lerped.matchForeground, equals(expectedMatchForeground));
    });
  });
}
