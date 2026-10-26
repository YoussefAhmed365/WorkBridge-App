import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleCubit extends Cubit<Locale> {
  static const String _localeKey = 'selected_language_code';
  final SharedPreferences _sharedPreferences;

  LocaleCubit(this._sharedPreferences) : super(_getSavedLocale(_sharedPreferences));

  static Locale _getSavedLocale(SharedPreferences prefs) {
    final languageCode = prefs.getString(_localeKey);
    if (languageCode != null && languageCode.isNotEmpty) {
      return Locale(languageCode);
    }
    // Default language (English)
    return const Locale('en');
  }

  Future<void> changeLanguage(String languageCode) async {
    if (state.languageCode == languageCode) return;
    await _sharedPreferences.setString(_localeKey, languageCode);
    emit(Locale(languageCode));
  }

  Future<void> toggleLanguage() async {
    final newLanguageCode = state.languageCode == 'en' ? 'ar' : 'en';
    await changeLanguage(newLanguageCode);
  }
}