import 'package:shared_preferences/shared_preferences.dart';

// shared prefrences
class UserPreferences {
  static late SharedPreferences _preferences;
  //intialize
  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  //variable--------
  static const _accessToken = 'accessToken';
  static const _seenTutorial = 'seenTutorial';
  static const _seenTermsOfUse = 'seenTermsOfUse';

  //getters---------
  static String get accessToken => _preferences.getString(_accessToken) ?? "";
  static bool get seenTutorial => _preferences.getBool(_seenTutorial) ?? false;
  static bool get seenTermsOfUse =>
      _preferences.getBool(_seenTermsOfUse) ?? false;

  //setters---------
  static Future setAccessToken(String accessToken) async {
    await _preferences.setString(_accessToken, accessToken);
  }

  static Future setSeenTutorial(bool seenTutorial) async {
    await _preferences.setBool(_seenTutorial, seenTutorial);
  }

  static Future setSeenTermsOfUse(bool seenTermsOfUse) async {
    await _preferences.setBool(_seenTermsOfUse, seenTermsOfUse);
  }
}
