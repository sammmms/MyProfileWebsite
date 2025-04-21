import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeNotifier extends ChangeNotifier {
  static const ThemeNotifier? _instance = null;

  ThemeNotifier._internal() {
    final brightness =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;

    _isDarkMode = brightness == Brightness.dark;
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

  bool _isDarkMode = true;

  bool get isDarkMode => _isDarkMode;

  ThemeData get theme {
    final currentTheme = _isDarkMode ? _darkTheme : _lightTheme;

    return currentTheme.copyWith(
      textTheme: currentTheme.textTheme
          .apply(fontFamily: GoogleFonts.poppins().fontFamily),
    );
  }

  void changeTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}
