import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  static const String _themeKey = 'theme_mode';

  final SharedPreferences _preferences;

  ThemeCubit(this._preferences) : super(_readSavedMode(_preferences));

  static ThemeMode _readSavedMode(SharedPreferences preferences) {
    switch (preferences.getString(_themeKey)) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      case 'system':
      default:
        return ThemeMode.system;
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    if (state == mode) return;

    final value = switch (mode) {
      ThemeMode.light => 'light',
      ThemeMode.dark => 'dark',
      ThemeMode.system => 'system',
    };

    await _preferences.setString(_themeKey, value);
    emit(mode);
  }

  Future<void> toggleDarkMode() async {
    final nextMode = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;

    await setThemeMode(nextMode);
  }
}