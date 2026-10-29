import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workbridge/core/localization/locale_cubit.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
  });

  group('LocaleCubit', () {
    test('initial state defaults to English Locale when no preference is saved', () {
      when(() => mockSharedPreferences.getString('selected_language_code')).thenReturn(null);

      final cubit = LocaleCubit(mockSharedPreferences);

      expect(cubit.state, equals(const Locale('en')));
    });

    test('initial state reads saved language code from SharedPreferences', () {
      when(() => mockSharedPreferences.getString('selected_language_code')).thenReturn('ar');

      final cubit = LocaleCubit(mockSharedPreferences);

      expect(cubit.state, equals(const Locale('ar')));
    });

    blocTest<LocaleCubit, Locale>(
      'changeLanguage saves new language code and emits new Locale',
      build: () {
        when(() => mockSharedPreferences.getString('selected_language_code')).thenReturn('en');
        when(() => mockSharedPreferences.setString('selected_language_code', 'ar'))
            .thenAnswer((_) async => true);
        return LocaleCubit(mockSharedPreferences);
      },
      act: (cubit) => cubit.changeLanguage('ar'),
      expect: () => [const Locale('ar')],
      verify: (_) {
        verify(() => mockSharedPreferences.setString('selected_language_code', 'ar')).called(1);
      },
    );

    blocTest<LocaleCubit, Locale>(
      'changeLanguage does nothing if language code is same as current state',
      build: () {
        when(() => mockSharedPreferences.getString('selected_language_code')).thenReturn('en');
        return LocaleCubit(mockSharedPreferences);
      },
      act: (cubit) => cubit.changeLanguage('en'),
      expect: () => [],
      verify: (_) {
        verifyNever(() => mockSharedPreferences.setString(any(), any()));
      },
    );

    blocTest<LocaleCubit, Locale>(
      'toggleLanguage switches between "en" and "ar"',
      build: () {
        when(() => mockSharedPreferences.getString('selected_language_code')).thenReturn('en');
        when(() => mockSharedPreferences.setString('selected_language_code', 'ar'))
            .thenAnswer((_) async => true);
        return LocaleCubit(mockSharedPreferences);
      },
      act: (cubit) => cubit.toggleLanguage(),
      expect: () => [const Locale('ar')],
      verify: (_) {
        verify(() => mockSharedPreferences.setString('selected_language_code', 'ar')).called(1);
      },
    );
  });
}
