import 'package:flutter/material.dart';
import 'package:quizz_app/providers/setup_provider.dart';
import '../main.dart'; // لكلاس Question

class QuizProvider with ChangeNotifier {
  List<Question> _questions = [];
  int _currentQuestionIndex = 0;
  int _score = 0;
  int _answeredIndex = -1;
  final Stopwatch _stopwatch = Stopwatch();

  // Getters
  List<Question> get questions => _questions;
  int get currentQuestionIndex => _currentQuestionIndex;
  int get score => _score;
  int get answeredIndex => _answeredIndex;
  bool _isAnswered = false;
  // حساب الوقت المستغرق
  String get timeElapsed {
    if (!_stopwatch.isRunning && _stopwatch.elapsedMilliseconds == 0) {
      return "00:00";
    }
    final seconds = _stopwatch.elapsed.inSeconds;
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return "${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}";
  }

  // حساب نسبة السرعة (100% للإجابة في أقل من 30 ثانية، تنخفض بعدها)
  int get speedPercentage {
    if (_stopwatch.elapsed.inSeconds == 0) return 100;
    final totalSeconds = _stopwatch.elapsed.inSeconds;
    final speedScore = ((3000 - (totalSeconds * 10)).clamp(0, 100)).toInt();
    return speedScore;
  }

  // الآن يبدأ من 0%
  double get progressPercentage {
    if (_questions.isEmpty) return 0.0;
    return (_currentQuestionIndex + 1) / _questions.length;
  }

  Question? get currentQuestion => _currentQuestionIndex < _questions.length
      ? _questions[_currentQuestionIndex]
      : null;

  bool get isLastQuestion => _questions.isEmpty
      ? true
      : _currentQuestionIndex == _questions.length - 1;

  // نسبة النجاح
  double get successPercentage =>
      _questions.isEmpty ? 0.0 : (_score / _questions.length);

  void startNewQuiz(List<Question> newQuestions) {
    _questions = newQuestions;
    _currentQuestionIndex = 0;
    _score = 0;
    _answeredIndex = -1;

    _stopwatch.reset();
    _stopwatch.start();

    notifyListeners();
  }

  void selectAnswer(int selectedAnswerIndex) {
    _answeredIndex = selectedAnswerIndex;
    notifyListeners();
  }

  bool checkAnswer() {
    if (_answeredIndex == -1) return false;

    _isAnswered = true;

    if (currentQuestion != null &&
        _answeredIndex == currentQuestion!.correctAnswerIndex) {
      _score++;
    }

    return true;
  }

  bool nextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      _currentQuestionIndex++;
      _answeredIndex = -1;
      notifyListeners();
      return true;
    }
    _isAnswered = false;
    return false;
  }

  void stopQuiz() {
    _stopwatch.stop();

    notifyListeners();
  }

  void resetQuiz() {
    _questions = [];
    _currentQuestionIndex = 0;
    _score = 0;
    _answeredIndex = -1;
    _stopwatch.reset();
    SetupProvider.isReady = false;
    SetupProvider.questions = [];
    notifyListeners();
  }

  void retakeQuiz() {
    _currentQuestionIndex = 0;
    _score = 0;
    _answeredIndex = -1;
    notifyListeners();
  }
}
