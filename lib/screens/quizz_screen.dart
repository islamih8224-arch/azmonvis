import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizz_app/localization/localization_provider.dart';
import 'package:quizz_app/main.dart';
import 'package:quizz_app/providers/theme_provider.dart';
import 'package:quizz_app/providers/quiz_provider.dart';
import 'dart:async';
import 'package:quizz_app/screens/result_screen.dart';

class QuizzScreen extends StatefulWidget {
  const QuizzScreen({super.key});

  @override
  State<QuizzScreen> createState() => _QuizzScreenState();
}

class _QuizzScreenState extends State<QuizzScreen>
    with TickerProviderStateMixin {
  late Timer _timer;
  int _seconds = 0;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  // أضف هذا المتغير في State
  final ValueNotifier<int> _secondsNotifier = ValueNotifier<int>(0);

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        _secondsNotifier.value++; // تحديث القيمة فقط دون عمل setState كامل
      }
    });
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final quiz = context.watch<QuizProvider>();
    final theme = context.watch<ThemeProvider>();
    final loc = context.watch<LocalizationProvider>();
    final colors = theme.getColors();
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    if (quiz.questions.isEmpty) {
      return Scaffold(
        backgroundColor: colors['background'],
        body: Center(
          child: CircularProgressIndicator(color: colors['primary']),
        ),
      );
    }

    return Scaffold(
      backgroundColor: colors['background'],
      appBar: _buildAppBar(context, colors, loc, quiz, isMobile),
      body: isMobile
          ? _buildBodyMobile(context, colors, loc, quiz)
          : _buildBodyWeb(context, colors, loc, quiz),
      bottomNavigationBar: isMobile
          ? _buildBottomBar(context, colors, loc, quiz)
          : null,
    );
  }

  // ===== AppBar =====
  PreferredSizeWidget _buildAppBar(
    BuildContext context,
    Map<String, Color> colors,
    LocalizationProvider loc,
    QuizProvider quiz,
    bool isMobile,
  ) {
    return AppBar(
      backgroundColor: colors['surface'],
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_forward, color: colors['onSurface']),
        onPressed: () {
          QuizProvider().resetQuiz();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const MyApp()),
          );
        },
      ),
      title: Text(
        loc.translate('currentExam'),
        style: TextStyle(
          color: colors['primary'],
          fontWeight: FontWeight.bold,
          fontSize: isMobile ? 20 : 24,
          fontFamily: 'Noto Kufi Arabic',
        ),
      ),
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Icon(Icons.timer, color: colors['secondary'], size: 20),
              const SizedBox(width: 8),
              ValueListenableBuilder<int>(
                valueListenable: _secondsNotifier,
                builder: (context, seconds, child) {
                  return Text(
                    _formatTime(seconds),
                    style: TextStyle(
                      color: colors['onSurfaceVariant'],
                      fontSize: 14,
                      fontFamily: 'Noto Kufi Arabic',
                    ),
                  ); // سيتغير هذا النص فقط كل ثانية
                },
              ),
            ],
          ),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(1.0),
        child: Container(
          color: colors['outlineVariant']!.withValues(alpha: 0.5),
          height: 1.0,
        ),
      ),
    );
  }

  // ===== Body Mobile =====
  Widget _buildBodyMobile(
    BuildContext context,
    Map<String, Color> colors,
    LocalizationProvider loc,
    QuizProvider quiz,
  ) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        children: [
          // Progress Section
          _buildProgressSection(colors, loc, quiz),
          const SizedBox(height: 24),

          // Question Section
          _buildQuestionSection(colors, loc, quiz),
          const SizedBox(height: 24),

          // Options Section
          _buildOptionsSection(context, colors, loc, quiz, isMobile: true),
          // const SizedBox(height: 24),

          // Difficulty Card
          //_buildDifficultyCard(colors, loc, quiz),
          const SizedBox(height: 20),

          // AI Hint Card
          _buildAIHintCard(colors, loc),
          const SizedBox(height: 20),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  // ===== Body Web =====
  Widget _buildBodyWeb(
    BuildContext context,
    Map<String, Color> colors,
    LocalizationProvider loc,
    QuizProvider quiz,
  ) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              // Top Row: Progress + Question
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Progress Section (Left - 35%)
                  Expanded(
                    flex: 35,
                    child: _buildProgressSection(colors, loc, quiz),
                  ),
                  const SizedBox(width: 24),

                  // Question & Options (Right - 65%)
                  Expanded(
                    flex: 65,
                    child: Column(
                      children: [
                        _buildQuestionSection(colors, loc, quiz),
                        const SizedBox(height: 24),
                        _buildOptionsSection(
                          context,
                          colors,
                          loc,
                          quiz,
                          isMobile: false,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Middle Row: Difficulty + AI Hint + Image
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // // Difficulty Card (Left - 30%)
                  // Expanded(
                  //   flex: 30,
                  //   child: _buildDifficultyCard(colors, loc, quiz),
                  // ),
                  // const SizedBox(width: 24),

                  // AI Hint Card (Middle - 35%)
                  Expanded(flex: 35, child: _buildAIHintCard(colors, loc)),
                  const SizedBox(width: 24),
                ],
              ),
              const SizedBox(height: 32),

              // Bottom: Next Button
              SizedBox(
                width: double.infinity,
                child: _buildNextButtonWeb(context, colors, loc, quiz),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Progress Section
  Widget _buildProgressSection(
    Map<String, Color> colors,
    LocalizationProvider loc,
    QuizProvider quiz,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colors['surfaceContainer'],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors['outlineVariant']!, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    loc.translate('progress'),
                    style: TextStyle(
                      fontSize: 12,
                      color: colors['onSurfaceVariant'],
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${loc.translate('question')} ${quiz.currentQuestionIndex + 1} ${loc.translate('of')} ${quiz.questions.length}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: colors['primary'],
                      fontFamily: 'Noto Kufi Arabic',
                    ),
                  ),
                ],
              ),
              Text(
                '${(quiz.progressPercentage * 100).toStringAsFixed(0)}%',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: colors['primary'],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: quiz.progressPercentage,
              minHeight: 6,
              backgroundColor: colors['surfaceContainerHigh'],
              valueColor: AlwaysStoppedAnimation<Color>(colors['primary']!),
            ),
          ),
        ],
      ),
    );
  }

  // Question Section
  Widget _buildQuestionSection(
    Map<String, Color> colors,
    LocalizationProvider loc,
    QuizProvider quiz,
  ) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: colors['surfaceContainer'],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors['outlineVariant']!, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.psychology, color: colors['tertiary'], size: 20),
              const SizedBox(width: 8),
              Text(
                loc.translate('criticalThinking'),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: colors['tertiary'],
                  fontFamily: 'Noto Kufi Arabic',
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            quiz.currentQuestion!.questionText,
            textDirection: loc.textDirection,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: colors['onSurface'],
              height: 1.4,
              fontFamily: 'Noto Kufi Arabic',
            ),
          ),
        ],
      ),
    );
  }

  // Options Section
  Widget _buildOptionsSection(
    BuildContext context,
    Map<String, Color> colors,
    LocalizationProvider loc,
    QuizProvider quiz, {
    required bool isMobile,
  }) {
    return isMobile
        ? _buildOptionsMobileLayout(context, colors, loc, quiz)
        : _buildOptionsWebLayout(context, colors, loc, quiz);
  }

  // Options Mobile Layout (1 column)
  Widget _buildOptionsMobileLayout(
    BuildContext context,
    Map<String, Color> colors,
    LocalizationProvider loc,
    QuizProvider quiz,
  ) {
    return Column(
      children: List.generate(quiz.currentQuestion!.options.length, (index) {
        return _buildOptionItem(context, colors, quiz, index);
      }),
    );
  }

  // Options Web Layout (2x2 grid)
  Widget _buildOptionsWebLayout(
    BuildContext context,
    Map<String, Color> colors,
    LocalizationProvider loc,
    QuizProvider quiz,
  ) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: quiz.currentQuestion!.options.length,
      itemBuilder: (context, index) {
        return _buildOptionItem(context, colors, quiz, index);
      },
    );
  }

  // Option Item Widget
  Widget _buildOptionItem(
    BuildContext context,
    Map<String, Color> colors,
    QuizProvider quiz,
    int index,
  ) {
    final isSelected = quiz.answeredIndex == index;
    final option = quiz.currentQuestion!.options;
    final letter = String.fromCharCode(65 + index); // A, B, C, D

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: () {
          context.read<QuizProvider>().selectAnswer(index);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isSelected
                ? colors['surfaceContainerHigh']
                : colors['surfaceContainer'],
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isSelected
                  ? colors['primary']!
                  : colors['outlineVariant']!,
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              // Letter Badge
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected
                      ? colors['primary']
                      : colors['surfaceContainerHighest'],
                  border: Border.all(
                    color: isSelected
                        ? colors['primary']!
                        : colors['outlineVariant']!,
                  ),
                ),
                child: Center(
                  child: Text(
                    letter,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isSelected
                          ? colors['onPrimary']
                          : colors['onSurfaceVariant'],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),

              // Option Text
              Expanded(
                child: Text(
                  option[index],
                  style: TextStyle(
                    fontSize: 16,
                    color: isSelected
                        ? colors['onSurface']
                        : colors['onSurface'],
                    fontFamily: 'Noto Kufi Arabic',
                  ),
                ),
              ),

              // Check Icon
              if (isSelected)
                Icon(Icons.check_circle, color: colors['primary'], size: 24),
            ],
          ),
        ),
      ),
    );
  }

  /*
  // Difficulty Card
  Widget _buildDifficultyCard(
    Map<String, Color> colors,
    LocalizationProvider loc,
    QuizProvider quiz,
  ) {
    // محاكاة مستوى الصعوبة
    String difficultyLevel = loc.translate('advancedDifficulty');

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colors['primaryContainer'],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors['outlineVariant']!, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.speed, color: colors['onPrimaryContainer'], size: 18),
              const SizedBox(width: 8),
              Text(
                loc.translate('difficultyLevel'),
                style: TextStyle(
                  fontSize: 12,
                  color: colors['onPrimaryContainer']?.withValues(alpha: 0.8),
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Noto Kufi Arabic',
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            difficultyLevel,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: colors['onPrimaryContainer'],
              fontFamily: 'Noto Kufi Arabic',
            ),
          ),
          const SizedBox(height: 12),
          Text(
            loc.translate('difficultyDescription'),
            style: TextStyle(
              fontSize: 14,
              color: colors['onPrimaryContainer']?.withValues(alpha: 0.9),
              height: 1.5,
              fontFamily: 'Noto Kufi Arabic',
            ),
          ),
        ],
      ),
    );
  }
*/
  // AI Hint Card
  Widget _buildAIHintCard(Map<String, Color> colors, LocalizationProvider loc) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors['surfaceContainer'],
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: colors['outlineVariant']!, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            loc.translate('AIHint'),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: colors['onSurface'],
              fontFamily: 'Noto Kufi Arabic',
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.lightbulb, color: colors['secondary'], size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  "Comming soon",
                  //loc.translate('hintText'),
                  style: TextStyle(
                    fontSize: 14,
                    color: colors['onSurfaceVariant'],
                    fontFamily: 'Noto Kufi Arabic',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ===== Bottom Bar (Mobile Only) =====
  Widget _buildBottomBar(
    BuildContext context,
    Map<String, Color> colors,
    LocalizationProvider loc,
    QuizProvider quiz,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: colors['surface'],
        border: Border(
          top: BorderSide(color: colors['outlineVariant']!, width: 0.5),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Next Button
          ElevatedButton.icon(
            onPressed: () async {
              if (!quiz.checkAnswer()) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(loc.translate('selectAnswer')),
                    backgroundColor: colors['error'],
                  ),
                );
                return;
              }

              if (quiz.nextQuestion()) {
                setState(() {});
              } else {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ResultScreen()),
                );

                if (result == true) {
                  setState(() {
                    _seconds = 0;
                  });
                }
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: colors['primaryContainer'],
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              minimumSize: const Size(0, 60),
            ),
            iconAlignment: IconAlignment.end,
            icon: Icon(
              Icons.arrow_forward,
              color: colors['onPrimaryContainer'],
              size: 28,
            ),
            label: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  loc.translate('nextQuestion'),
                  style: TextStyle(
                    color: colors['onPrimaryContainer'],
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    fontFamily: 'Noto Kufi Arabic',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ===== Web Next Button =====
  Widget _buildNextButtonWeb(
    BuildContext context,
    Map<String, Color> colors,
    LocalizationProvider loc,
    QuizProvider quiz,
  ) {
    return ElevatedButton.icon(
      onPressed: () async {
        if (!quiz.checkAnswer()) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(loc.translate('selectAnswer')),
              backgroundColor: colors['error'],
            ),
          );
          return;
        }

        if (quiz.nextQuestion()) {
          setState(() {});
        } else {
          quiz.stopQuiz();
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => ResultScreen()),
          );

          if (result == true) {
            setState(() {
              _seconds = 0;
            });
          }
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: colors['primaryContainer'],
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        minimumSize: const Size(double.infinity, 60),
      ),
      iconAlignment: IconAlignment.end,
      icon: Icon(
        Icons.arrow_forward,
        color: colors['onPrimaryContainer'],
        size: 28,
      ),
      label: Text(
        loc.translate('nextQuestion'),
        style: TextStyle(
          color: colors['onPrimaryContainer'],
          fontWeight: FontWeight.bold,
          fontSize: 20,
          fontFamily: 'Noto Kufi Arabic',
        ),
      ),
    );
  }
}
