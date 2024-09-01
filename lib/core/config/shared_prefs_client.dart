import 'package:progress_soft_app/core/config/shared_prefs_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsClient {
  final SharedPreferences _prefs;

  SharedPrefsClient(this._prefs);

  // set a string in prefs
  void setString(String key, String data) async =>
      await _prefs.setString(key, data);

  // set a int in prefs
  void setInt(String key, int data) async => await _prefs.setInt(key, data);

  void setBool(String key, bool data) async => await _prefs.setBool(key, data);

  // get a String in prefs.
  String? getString(String key) => _prefs.getString(key);

  int? getInt(String key) => _prefs.getInt(key);

  bool? getBool(String key) => _prefs.getBool(key);

  String? getKey(String key) => _prefs.getString(key);

  Future<void> clearUserData() async {
    await Future.wait([
      _prefs.remove(kUserFullNameKey),
      _prefs.remove(kUserAgeKey),
      _prefs.remove(kUserPhoneNumberKey),
      _prefs.remove(kUserGenderKey),
    ]);
  }

  // app language
  String get currentLanguage => _prefs.getString(kSelectedLanguageKey) ?? "";

  set currentLanguage(String value) {
    _prefs.setString(kSelectedLanguageKey, value);
  }

  String get userFullName => _prefs.getString(kUserFullNameKey) ?? "";

  set userFullName(String value) {
    _prefs.setString(kUserFullNameKey, value);
  }

  String get userAge => _prefs.getString(kUserAgeKey) ?? "";

  set userAge(String value) {
    _prefs.setString(kUserAgeKey, value);
  }

  String get userPhoneNumber => _prefs.getString(kUserPhoneNumberKey) ?? "";

  set userPhoneNumber(String value) {
    _prefs.setString(kUserPhoneNumberKey, value);
  }

  int get userGender => _prefs.getInt(kUserGenderKey) ?? 1;

  set userGender(int value) {
    _prefs.setInt(kUserGenderKey, value);
  }
}
