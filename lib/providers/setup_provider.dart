import 'package:flutter/material.dart';
import 'package:quizz_app/services/gemini_service.dart';
import 'package:quizz_app/services/pdf_service.dart';
import 'package:quizz_app/main.dart';

class SetupProvider extends ChangeNotifier {
  final PdfServiceCrossPlatform _pdfService = PdfServiceCrossPlatform();
  final GeminiService _geminiService = GeminiService();

  // متغيرات الحالة والـ UI
  bool _isLoading = false;
  double _loadingProgress = 0.0;
  String selectedLanguage = 'ar';
  int _selectedQuestionCount = 5;
  String _selectedDifficulty = 'intermediateDifficulty';
  String? _errorMessage;

  // Getters
  bool get isLoading => _isLoading;
  double get loadingProgress => _loadingProgress;
  int get selectedQuestionCount =>
      _questionCounts.contains(_selectedQuestionCount)
      ? _selectedQuestionCount
      : 5;
  String get selectedDifficulty => _selectedDifficulty;
  String? get errorMessage => _errorMessage;

  // الثوابت - قوائم الخيارات
  final List<int> _questionCounts = [20, 15, 10, 5, 3];
  final List<String> _languageCodes = ['ar', 'en', 'ck', 'ck_km'];
  final List<String> _difficulties = [
    'beginnerDifficulty',
    'intermediateDifficulty',
    'advancedDifficulty',
  ];

  // Getters للثوابت
  List<int> get questionCounts => _questionCounts;
  List<String> get languageCodes => _languageCodes;
  List<String> get difficulties => _difficulties;

  // أيقونات الصعوبة
  final Map<String, IconData> _difficultyIcons = {
    'beginnerDifficulty': Icons.sentiment_satisfied_alt_outlined,
    'intermediateDifficulty': Icons.school_outlined,
    'advancedDifficulty': Icons.psychology_outlined,
  };

  Map<String, IconData> get difficultyIcons => _difficultyIcons;

  // ========== 📌 تغيير اللغة ==========
  void changeLanguage(String langCode) {
    if (selectedLanguage != langCode) {
      selectedLanguage = langCode;
      notifyListeners();
    }
  }

  // ========== 📌 تغيير عدد الأسئلة ==========
  void changeQuestionCount(int count) {
    if (_selectedQuestionCount != count) {
      _selectedQuestionCount = count;
      notifyListeners();
    }
  }

  // ========== 📌 تغيير مستوى الصعوبة ==========
  void changeDifficulty(String diff) {
    if (_selectedDifficulty != diff) {
      _selectedDifficulty = diff;
      notifyListeners();
    }
  }

  // أضف هذا في كلاس SetupProvider
  static bool isReady = false;
  // ========== 📌 محاكاة عداد التحميل ==========
  void _startProgressSimulation() {
    _loadingProgress = 0.0;
    Future.doWhile(() async {
      await Future.delayed(const Duration(milliseconds: 300));
      if (!_isLoading) return false;

      _loadingProgress += 4.0;
      if (_loadingProgress >= 99) {
        _loadingProgress = 99;
      }

      if (_isLoading) {
        notifyListeners();
      }

      return _loadingProgress < 99;
    });
  }

  // ========== 📌 توليد الاختبار ==========
  Future<List<Question>?> generateQuiz() async {
    _errorMessage = null;
    notifyListeners();
    final result = await _pdfService.pickAndExtractText();
    final text = result.text;
    final error = result.error;

    // التعامل مع خطأ الملف
    if (error != null) {
      _errorMessage = error;
      notifyListeners();
      return null;
    }

    if (text != null && text.isNotEmpty) {
      _isLoading = true;
      _loadingProgress = 0.0;

      notifyListeners();

      _startProgressSimulation();

      try {
        final geminiResult = await _geminiService.generateQuestionsFromText(
          extractedText: text,
          language: selectedLanguage,
          numberOfQuestions: _selectedQuestionCount,
          difficulty: _getDifficultyText(),
        );

        _isLoading = false;
        _loadingProgress = 100;
        notifyListeners();

        _isLoading = false;

        // التعامل مع أخطاء Gemini
        if (geminiResult.error != null) {
          _errorMessage = geminiResult.error;
          notifyListeners();
          return null;
        }

        if (geminiResult.questions != null &&
            geminiResult.questions!.isNotEmpty) {
          _isLoading = false;

          _loadingProgress = 100;
          notifyListeners();

          if (geminiResult.questions != null &&
              geminiResult.questions!.isNotEmpty) {
            SetupProvider.questions =
                geminiResult.questions!; // خزن الأسئلة هنا
            SetupProvider.isReady = true; // أشر أننا جاهزون
            notifyListeners();
            return geminiResult.questions!;
          }
        }
        _errorMessage = 'فشل في توليد الأسئلة. حاول مجدداً';
        notifyListeners();
        return [];
      } catch (e) {
        _isLoading = false;
        notifyListeners();

        _errorMessage = 'خطأ غير متوقع: $e';
        return [];
      }
    }
    return null;
  }

  static List<Question> questions = [];
  String _getDifficultyText() {
    switch (_selectedDifficulty) {
      case 'beginnerDifficulty':
        return 'Beginner';

      case 'intermediateDifficulty':
        return 'Intermediate';

      case 'advancedDifficulty':
        return 'Advanced';

      default:
        return 'Intermediate';
    }
  }
}
