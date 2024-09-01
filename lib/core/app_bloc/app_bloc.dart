import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../config/shared_prefs_client.dart';
import '../language_cubit/language_cubit.dart';
import '../navigation/app_custom_navigation.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc(SharedPrefsClient prefsClient) : super(AppInitial()) {
    /// Init App Functions
    on<InitApp>((event, emit) async {});

    add(InitApp());
  }

  void _changeLanguageCached(String language) {
    if (language == "ar") {
      currentContext!.read<LanguageCubit>().toArabic();
    } else {
      currentContext!.read<LanguageCubit>().toEnglish();
    }
  }

  void toggleLanguage(String language) {
    _changeLanguageCached(language);
  }
}
