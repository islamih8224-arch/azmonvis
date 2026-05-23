import 'package:flutter/material.dart';

// ============================================================================
// 🎨 THEME PROVIDER - ثيم الليل والنهار
// ============================================================================

enum ThemeMode {
  light('فاتح', 'Light'),
  dark('غامق', 'Dark');

  final String arName;
  final String enName;

  const ThemeMode(this.arName, this.enName);
}

class ThemeColors {
  // ========== 🌙 Neon Dark Colors ==========
  static const Color colorBackground = Color(0xFF11131B);
  static const Color colorSurface = Color(0xFF1D1F28);
  static const Color colorSurfaceHigh = Color(0xFF282A33);
  static const Color colorSurfaceHighest = Color(0xFF32343E);
  static const Color colorSurfaceLow = Color(0xFF191B24);
  static const Color colorSurfaceLowest = Color(0xFF0C0E16);
  static const Color colorPrimary = Color(0xFFD0BCFF);
  static const Color colorOnPrimary = Color(0xFF3C0091);
  static const Color colorSecondary = Color.fromARGB(255, 0, 175, 228);
  static const Color colorTertiaryContainer = Color(0xFFF751A1);
  static const Color colorOnSurface = Color(0xFFE1E1EE);
  static const Color colorOnSurfaceVariant = Color(0xFFCBC3D7);
  static const Color colorOutlineVariant = Color(0xFF494454);
  static const Color colorOutline = Color(0xFF958EA0);

  // ========== ☀️ Light Colors ==========
  static const Color lightBackground = Color(0xFFFAFBFF);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceHigh = Color(0xFFF5F5FF);
  static const Color lightSurfaceHighest = Color(0xFFECE8F8);
  static const Color lightSurfaceLow = Color(0xFFF9F8FE);
  static const Color lightSurfaceLowest = Color(0xFFFFFFFF);
  static const Color lightPrimary = Color(0xFF6D3BD7);
  static const Color lightOnPrimary = Color(0xFFFFFFFF);
  static const Color lightSecondary = Color(0xFF006B7A);
  static const Color lightTertiaryContainer = Color(0xFFC92E6D);
  static const Color lightOnSurface = Color(0xFF2E3039);
  static const Color lightOnSurfaceVariant = Color(0xFF49454D);
  static const Color lightOutlineVariant = Color(0xFFCAC5D0);
  static const Color lightOutline = Color(0xFF79747E);
}

class ThemeProvider extends ChangeNotifier {
  ThemeMode _currentTheme = ThemeMode.dark;

  ThemeMode get currentTheme => _currentTheme;
  bool get isDarkMode => _currentTheme == ThemeMode.dark;

  // ========== 📌 تبديل الثيم ==========
  void toggleTheme() {
    _currentTheme = _currentTheme == ThemeMode.dark
        ? ThemeMode.light
        : ThemeMode.dark;
    notifyListeners();
  }

  // ========== 📌 تعيين الثيم ==========
  void setTheme(ThemeMode theme) {
    if (_currentTheme != theme) {
      _currentTheme = theme;
      notifyListeners();
    }
  }

  // ========== 📌 الحصول على جميع الألوان ==========
  Map<String, Color> getColors() {
    return isDarkMode ? _getDarkColors() : _getLightColors();
  }

  // ========== 📌 دالة داخلية للألوان المظلمة ==========
  Map<String, Color> _getDarkColors() {
    return {
      'background': ThemeColors.colorBackground,
      'surface': ThemeColors.colorSurface,
      'surfaceHigh': ThemeColors.colorSurfaceHigh,
      'surfaceHighest': ThemeColors.colorSurfaceHighest,
      'surfaceLow': ThemeColors.colorSurfaceLow,
      'surfaceLowest': ThemeColors.colorSurfaceLowest,
      'primary': ThemeColors.colorPrimary,
      'onPrimary': ThemeColors.colorOnPrimary,
      'secondary': ThemeColors.colorSecondary,
      'tertiaryContainer': ThemeColors.colorTertiaryContainer,
      'onSurface': ThemeColors.colorOnSurface,
      'onSurfaceVariant': ThemeColors.colorOnSurfaceVariant,
      'outlineVariant': ThemeColors.colorOutlineVariant,
      'outline': ThemeColors.colorOutline,
    };
  }

  // ========== 📌 دالة داخلية للألوان الفاتحة ==========
  Map<String, Color> _getLightColors() {
    return {
      'background': ThemeColors.lightBackground,
      'surface': ThemeColors.lightSurface,
      'surfaceHigh': ThemeColors.lightSurfaceHigh,
      'surfaceHighest': ThemeColors.lightSurfaceHighest,
      'surfaceLow': ThemeColors.lightSurfaceLow,
      'surfaceLowest': ThemeColors.lightSurfaceLowest,
      'primary': ThemeColors.lightPrimary,
      'onPrimary': ThemeColors.lightOnPrimary,
      'secondary': ThemeColors.lightSecondary,
      'tertiaryContainer': ThemeColors.lightTertiaryContainer,
      'onSurface': ThemeColors.lightOnSurface,
      'onSurfaceVariant': ThemeColors.lightOnSurfaceVariant,
      'outlineVariant': ThemeColors.lightOutlineVariant,
      'outline': ThemeColors.lightOutline,
    };
  }

  // ========== 📌 اختصارات للألوان الشائعة ==========
  Color get background => getColors()['background']!;
  Color get surface => getColors()['surface']!;
  Color get surfaceHigh => getColors()['surfaceHigh']!;
  Color get surfaceHighest => getColors()['surfaceHighest']!;
  Color get surfaceLow => getColors()['surfaceLow']!;
  Color get surfaceLowest => getColors()['surfaceLowest']!;
  Color get primary => getColors()['primary']!;
  Color get onPrimary => getColors()['onPrimary']!;
  Color get secondary => getColors()['secondary']!;
  Color get tertiaryContainer => getColors()['tertiaryContainer']!;
  Color get onSurface => getColors()['onSurface']!;
  Color get onSurfaceVariant => getColors()['onSurfaceVariant']!;
  Color get outlineVariant => getColors()['outlineVariant']!;
  Color get outline => getColors()['outline']!;
}
