import 'package:flutter/material.dart';
import 'package:website/utils/store.dart';

enum ThemeType {
  system,
  light,
  dark,
}

extension ThemeTypeExtension on ThemeType {
  bool get isDarkMode {
    switch (this) {
      case ThemeType.dark:
        return true;
      case ThemeType.light:
        return false;
      case ThemeType.system:
        return WidgetsBinding.instance.platformDispatcher.platformBrightness ==
            Brightness.dark;
    }
  }

  String get name {
    switch (this) {
      case ThemeType.dark:
        return "dark";
      case ThemeType.light:
        return "light";
      case ThemeType.system:
        return "system";
    }
  }

  ThemeType get next {
    return ThemeType.values.indexOf(this) + 1 >= ThemeType.values.length
        ? ThemeType.values[0]
        : ThemeType.values[ThemeType.values.indexOf(this) + 1];
  }
}

class ThemeTypeUtil {
  static ThemeType fromString(String value) {
    switch (value) {
      case "dark":
        return ThemeType.dark;
      case "light":
        return ThemeType.light;
      case "system":
        return ThemeType.system;
      default:
        return ThemeType.system;
    }
  }
}

class ThemeNotifier extends ChangeNotifier {
  static const ThemeNotifier? _instance = null;

  ThemeNotifier._internal() {
    _themeType = Store.themeType;
  }

  factory ThemeNotifier() {
    return _instance ?? ThemeNotifier._internal();
  }

  final _lightTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: const Color(0xFFF0F4F8),
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF1565C0),
      onPrimary: Colors.white,
      secondary: Color(0xFF64B5F6),
      onSecondary: Colors.black,
      surface: Colors.white,
      onSurface: Colors.black,
      error: Color(0xFFD32F2F),
      onError: Colors.white,
    ),
  );

  final _darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: const Color(0xFF121212),
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xFF90CAF9),
      onPrimary: Colors.black,
      secondary: Color(0xFF64B5F6),
      onSecondary: Colors.black,
      surface: Color(0xFF1E1E1E),
      onSurface: Colors.white,
      error: Color(0xFFEF5350),
      onError: Colors.black,
    ),
  );

  ThemeType _themeType = Store.themeType;
  ThemeType get themeType => _themeType;

  bool get isDarkMode => _themeType.isDarkMode;

  ThemeData get theme {
    final currentTheme = isDarkMode ? _darkTheme : _lightTheme;

    return currentTheme.copyWith(
      textTheme: currentTheme.textTheme.apply(fontFamily: 'Poppins'),
    );
  }

  void changeTheme() {
    _themeType = _themeType.next;

    Store.isDarkMode = _themeType;
    notifyListeners();
  }
}
