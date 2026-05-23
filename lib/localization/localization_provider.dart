import 'package:flutter/material.dart';
import 'app_strings.dart';

// ============================================================================
// 🌍 LOCALIZATION PROVIDER - مدير اللغات والترجمة
// ============================================================================

enum AppLanguage {
  arabic('ar', 'العربية', TextDirection.rtl),
  english('en', 'English', TextDirection.ltr),
  sorani('ck', 'سۆرانی', TextDirection.rtl),
  kurmanji('ck_km', 'بادینی', TextDirection.rtl);

  final String code;
  final String displayName;
  final TextDirection direction;

  const AppLanguage(this.code, this.displayName, this.direction);
}

class LocalizationProvider extends ChangeNotifier {
  AppLanguage _currentLanguage = AppLanguage.english;

  AppLanguage get currentLanguage => _currentLanguage;
  String get languageCode => _currentLanguage.code;
  TextDirection get textDirection => _currentLanguage.direction;
  String get displayName => _currentLanguage.displayName;

  // جميع اللغات المتاحة
  List<AppLanguage> get availableLanguages => AppLanguage.values;

  // الخريطة الحالية كاملة
  Map<String, String> get currentLanguageStrings {
    return AppStrings.arStrings; // لكن سيتم اسخدام getString بدلاً منها
  }

  // ========== 📌 دالة الترجمة الرئيسية ==========
  String translate(String key) {
    return AppStrings.getString(key, languageCode);
  }

  // ========== 📌 تغيير اللغة ==========
  void changeLanguage(AppLanguage language) {
    if (_currentLanguage != language) {
      _currentLanguage = language;
      notifyListeners();
    }
  }

  // ========== 📌 تغيير اللغة من الـ Code ==========
  void changeLanguageByCode(String code) {
    try {
      final language = AppLanguage.values.firstWhere(
        (lang) => lang.code == code,
      );
      changeLanguage(language);
    } catch (e) {
      debugPrint('Language code not found: $code');
    }
  }

  // ========== 📌 الحصول على قائمة اللغات للـ UI ==========
  List<String> getLanguageNames() {
    return availableLanguages.map((lang) => lang.displayName).toList();
  }
}
