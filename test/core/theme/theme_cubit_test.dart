import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workbridge/core/theme/theme_cubit.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
  });

  group('ThemeCubit', () {
    test('initial state defaults to ThemeMode.system when preference is null or invalid', () {
      when(() => mockSharedPreferences.getString('theme_mode')).thenReturn(null);

      final cubit = ThemeCubit(mockSharedPreferences);

      expect(cubit.state, equals(ThemeMode.system));
    });

    test('initial state reads ThemeMode.light from SharedPreferences', () {
      when(() => mockSharedPreferences.getString('theme_mode')).thenReturn('light');

      final cubit = ThemeCubit(mockSharedPreferences);

      expect(cubit.state, equals(ThemeMode.light));
    });

    test('initial state reads ThemeMode.dark from SharedPreferences', () {
      when(() => mockSharedPreferences.getString('theme_mode')).thenReturn('dark');

      final cubit = ThemeCubit(mockSharedPreferences);

      expect(cubit.state, equals(ThemeMode.dark));
    });

    blocTest<ThemeCubit, ThemeMode>(
      'setThemeMode updates SharedPreferences and emits new state',
      build: () {
        when(() => mockSharedPreferences.getString('theme_mode')).thenReturn('light');
        when(() => mockSharedPreferences.setString('theme_mode', 'dark'))
            .thenAnswer((_) async => true);
        return ThemeCubit(mockSharedPreferences);
      },
      act: (cubit) => cubit.setThemeMode(ThemeMode.dark),
      expect: () => [ThemeMode.dark],
      verify: (_) {
        verify(() => mockSharedPreferences.setString('theme_mode', 'dark')).called(1);
      },
    );

    blocTest<ThemeCubit, ThemeMode>(
      'setThemeMode ignores duplicate mode',
      build: () {
        when(() => mockSharedPreferences.getString('theme_mode')).thenReturn('light');
        return ThemeCubit(mockSharedPreferences);
      },
      act: (cubit) => cubit.setThemeMode(ThemeMode.light),
      expect: () => [],
      verify: (_) {
        verifyNever(() => mockSharedPreferences.setString(any(), any()));
      },
    );

    blocTest<ThemeCubit, ThemeMode>(
      'toggleDarkMode switches from light to dark',
      build: () {
        when(() => mockSharedPreferences.getString('theme_mode')).thenReturn('light');
        when(() => mockSharedPreferences.setString('theme_mode', 'dark'))
            .thenAnswer((_) async => true);
        return ThemeCubit(mockSharedPreferences);
      },
      act: (cubit) => cubit.toggleDarkMode(),
      expect: () => [ThemeMode.dark],
      verify: (_) {
        verify(() => mockSharedPreferences.setString('theme_mode', 'dark')).called(1);
      },
    );

    blocTest<ThemeCubit, ThemeMode>(
      'toggleDarkMode switches from dark to light',
      build: () {
        when(() => mockSharedPreferences.getString('theme_mode')).thenReturn('dark');
        when(() => mockSharedPreferences.setString('theme_mode', 'light'))
            .thenAnswer((_) async => true);
        return ThemeCubit(mockSharedPreferences);
      },
      act: (cubit) => cubit.toggleDarkMode(),
      expect: () => [ThemeMode.light],
      verify: (_) {
        verify(() => mockSharedPreferences.setString('theme_mode', 'light')).called(1);
      },
    );
  });
}
