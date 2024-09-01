import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../config/injection_container.dart';
import '../config/shared_prefs_client.dart';
import '../config/shared_prefs_keys.dart';
part 'language_state.dart';

final String defaultLocale = Platform.localeName;

class LanguageCubit extends Cubit<LanguageState> {
  static Locale? _locale = cachedLanguage == null
      ? defaultLocale.substring(0, 2) == 'ar'
      ? const Locale('ar', '')
      : const Locale('en', '')
      : Locale(cachedLanguage!, '');

  static String get currentLanguage => _locale!.toString();

  static final SharedPrefsClient sharedPrefsClient = getIt();

  static String? get cachedLanguage =>
      sharedPrefsClient.getString(kSelectedLanguageKey);

  LanguageCubit()
      : super(
    SelectedLocale(
      cachedLanguage == null ? _locale! : Locale(cachedLanguage!, ''),
    ),
  ) {
    if (cachedLanguage == null) {
      sharedPrefsClient.setString(
        kSelectedLanguageKey,
        defaultLocale.substring(0, 2),
      );
    }
  }

  void toArabic() {
    sharedPrefsClient.setString(kSelectedLanguageKey, 'ar');
    emit(SelectedLocale(_locale = const Locale('ar', '')));
  }

  void toEnglish() {
    sharedPrefsClient.setString(kSelectedLanguageKey, 'en');
    emit(SelectedLocale(_locale = const Locale('en', '')));
  }

  static bool get isArabic => currentLanguage == 'ar';

  static bool get isEnglish => currentLanguage == 'en';
}
