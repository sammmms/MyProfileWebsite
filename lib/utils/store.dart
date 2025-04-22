import 'package:shared_preferences/shared_preferences.dart';
import 'package:website/utils/theme_notifier.dart';

class Store {
  static late SharedPreferences _prefs;
  static late Store? _instance;

  Store._internal();

  factory Store() {
    return _instance ?? Store._internal();
  }

  static Future initialize() async {
    _prefs = await SharedPreferences.getInstance();

    _instance = Store._internal();
  }

  static ThemeType get themeType {
    String themeType = _prefs.getString("themeType") ?? "";
    return ThemeTypeUtil.fromString(themeType);
  }

  static set isDarkMode(ThemeType value) {
    _prefs.setString("themeType", value.name);
  }
}
