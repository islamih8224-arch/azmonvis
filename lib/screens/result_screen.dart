import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizz_app/localization/localization_provider.dart';
import 'package:quizz_app/main.dart';
import 'package:quizz_app/providers/theme_provider.dart';
import 'package:quizz_app/screens/profile_screen.dart';
import '../providers/quiz_provider.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final quizProvider = Provider.of<QuizProvider>(context);
    final themeProvider = context.watch<ThemeProvider>();
    final locProvider = context.watch<LocalizationProvider>();

    final colors = themeProvider.getColors();
    final int score = quizProvider.score;
    final int totalQuestions = quizProvider.questions.length;
    final String timeElapsed = quizProvider.timeElapsed;
    final int speedPercentage = quizProvider.speedPercentage;

    double successPercentage = totalQuestions > 0
        ? (score / totalQuestions)
        : 0.0;

    return Scaffold(
      backgroundColor: colors['background'],
      appBar: AppBar(
        backgroundColor: colors['surface'],
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: colors['outlineVariant'], height: 1.0),
        ),
        leading: IconButton(
          icon: Icon(Icons.account_circle, color: colors['primary']),
          onPressed: () {},
        ),
        title: Text(
          locProvider.translate('appTitle'),
          style: TextStyle(
            color: colors['primary'],
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Noto Kufi Arabic',
          ),
          textDirection: locProvider.textDirection,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.menu, color: colors['primary']),
            onPressed: () {
              themeProvider.toggleTheme();
            },
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 768;
          return Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 16.0 : 32.0,
                vertical: isMobile ? 24.0 : 32.0,
              ),
              child: Directionality(
                textDirection: locProvider.textDirection,
                child: isMobile
                    ? _buildMobileLayout(
                        context,
                        colors,
                        locProvider,
                        score,
                        totalQuestions,
                        timeElapsed,
                        speedPercentage,
                        successPercentage,
                        quizProvider,
                      )
                    : _buildWebLayout(
                        context,
                        colors,
                        locProvider,
                        score,
                        totalQuestions,
                        timeElapsed,
                        speedPercentage,
                        successPercentage,
                        quizProvider,
                      ),
              ),
            ),
          );
        },
      ),
    );
  }

  // === Mobile Layout ===
  Widget _buildMobileLayout(
    BuildContext context,
    Map<String, Color> colors,
    LocalizationProvider locProvider,
    int score,
    int totalQuestions,
    String timeElapsed,
    int speedPercentage,
    double successPercentage,
    QuizProvider quizProvider,
  ) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 600),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // === Main Result Card ===
          _buildResultCard(
            colors,
            locProvider,
            score,
            totalQuestions,
            timeElapsed,
            speedPercentage,
            successPercentage,
          ),
          const SizedBox(height: 24),

          // === Action Buttons ===
          _buildActionButtonsMobile(context, colors, locProvider, quizProvider),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  // === Web Layout ===
  Widget _buildWebLayout(
    BuildContext context,
    Map<String, Color> colors,
    LocalizationProvider locProvider,
    int score,
    int totalQuestions,
    String timeElapsed,
    int speedPercentage,
    double successPercentage,
    QuizProvider quizProvider,
  ) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 1000),
      child: Row(
        children: [
          // === Left: Result Card (60%) ===
          Expanded(
            flex: 3,
            child: _buildResultCard(
              colors,
              locProvider,
              score,
              totalQuestions,
              timeElapsed,
              speedPercentage,
              successPercentage,
            ),
          ),
          const SizedBox(width: 32),

          // === Right: Buttons (40%) ===
          Expanded(
            flex: 2,
            child: _buildActionButtonsWeb(
              context,
              colors,
              locProvider,
              quizProvider,
            ),
          ),
        ],
      ),
    );
  }

  // === Shared Result Card ===
  Widget _buildResultCard(
    Map<String, Color> colors,
    LocalizationProvider locProvider,
    int score,
    int totalQuestions,
    String timeElapsed,
    int speedPercentage,
    double successPercentage,
  ) {
    return ScaleTransition(
      scale: Tween<double>(begin: 0.8, end: 1.0).animate(_animationController),
      child: Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: colors['surfaceContainer'],
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: colors['outlineVariant']!, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            // === Trophy Icon with Glow ===
            Stack(
              alignment: Alignment.center,
              children: [
                // Outer glow circle
                Container(
                  width: 112,
                  height: 112,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colors['primary']!.withValues(alpha: 0.1),
                  ),
                ),
                // Inner trophy container
                Container(
                  width: 88,
                  height: 88,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colors['surfaceHigh'],
                    border: Border.all(color: colors['outlineVariant']!),
                  ),
                  child: Icon(
                    Icons.emoji_events,
                    size: 44,
                    color: colors['primary'],
                  ),
                ),
                // Pink accent dot
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: colors['tertiaryContainer'],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // === Victory Message ===
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  locProvider.translate('wonMessage'),
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: colors['onSurface'],
                    fontFamily: 'Noto Kufi Arabic',
                  ),
                ),
                const SizedBox(width: 8),
                const Text('🎉', style: TextStyle(fontSize: 28)),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              locProvider.translate('excellentWork'),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: colors['onSurfaceVariant'],
                fontFamily: 'Noto Kufi Arabic',
              ),
            ),
            const SizedBox(height: 32),

            // === Score Box ===
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: colors['surfaceLowest'],
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: colors['outlineVariant']!.withValues(alpha: 0.5),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    locProvider.translate('yourFinalScore'),
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: colors['onSurfaceVariant'],
                      fontFamily: 'Noto Kufi Arabic',
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        "$score",
                        style: TextStyle(
                          fontSize: 54,
                          fontWeight: FontWeight.bold,
                          color: colors['primary'],
                          shadows: [
                            Shadow(
                              color: colors['primary']!.withValues(alpha: 0.4),
                              blurRadius: 12,
                            ),
                          ],
                        ),
                      ),
                      Text(
                        " / ",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: colors['outline'],
                        ),
                      ),
                      Text(
                        "$totalQuestions",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: colors['outline'],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // === Progress Bar ===
                  ClipRRect(
                    borderRadius: BorderRadius.circular(99),
                    child: SizedBox(
                      height: 10,
                      child: LinearProgressIndicator(
                        value: successPercentage,
                        backgroundColor: colors['surfaceHighest'],
                        valueColor: AlwaysStoppedAnimation<Color>(
                          colors['primary']!,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // === Stats Row (Time & Speed) ===
            Row(
              children: [
                // Time Card
                Expanded(
                  child: _buildStatCard(
                    colors,
                    locProvider,
                    Icons.timer_outlined,
                    locProvider.translate('time'),
                    timeElapsed,
                    colors['tertiaryContainer'],
                  ),
                ),
                const SizedBox(width: 12),

                // Speed Card
                Expanded(
                  child: _buildStatCard(
                    colors,
                    locProvider,
                    Icons.flash_on,
                    locProvider.translate('speed'),
                    "$speedPercentage%",
                    colors['secondary'],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // === Stat Card Widget ===
  Widget _buildStatCard(
    Map<String, Color> colors,
    LocalizationProvider locProvider,
    IconData icon,
    String label,
    String value,
    Color? iconColor,
  ) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colors['surfaceLow'],
        border: Border.all(color: colors['outlineVariant']!),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor!.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: colors['onSurfaceVariant'],
                  fontSize: 12,
                  fontFamily: 'Noto Kufi Arabic',
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  color: colors['onSurface'],
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // === Action Buttons Mobile ===
  Widget _buildActionButtonsMobile(
    BuildContext context,
    Map<String, Color> colors,
    LocalizationProvider locProvider,
    QuizProvider quizProvider,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Retake Button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: colors['primary'],
              foregroundColor: colors['onPrimary'],
              minimumSize: const Size(double.infinity, 56),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 0,
            ),
            onPressed: () {
              quizProvider.retakeQuiz();
              Navigator.pop(context, true);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.replay, size: 20, color: colors['onPrimary']),
                const SizedBox(width: 8),
                Text(
                  locProvider.translate('retakeQuiz'),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Noto Kufi Arabic',
                    color: colors['onPrimary'],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Review Button
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(double.infinity, 56),
              side: BorderSide(color: colors['outlineVariant']!, width: 2),
              foregroundColor: colors['onSurface'],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const profile()),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.history,
                  size: 20,
                  color: colors['onSurfaceVariant'],
                ),
                const SizedBox(width: 8),
                Text(
                  locProvider.translate('reviewAnswers'),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Noto Kufi Arabic',
                    color: colors['onSurface'],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Setup Button
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(double.infinity, 56),
              side: BorderSide(color: colors['outlineVariant']!, width: 2),
              foregroundColor: colors['onSurface'],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            onPressed: () {
              QuizProvider().resetQuiz();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const MyApp()),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.upload_file_outlined,
                  size: 20,
                  color: colors['onSurfaceVariant'],
                ),
                const SizedBox(width: 8),
                Text(
                  locProvider.translate('goToSetupScreen'),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Noto Kufi Arabic',
                    color: colors['onSurface'],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // === Action Buttons Web ===
  Widget _buildActionButtonsWeb(
    BuildContext context,
    Map<String, Color> colors,
    LocalizationProvider locProvider,
    QuizProvider quizProvider,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Retake Button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: colors['primary'],
              foregroundColor: colors['onPrimary'],
              minimumSize: const Size(double.infinity, 60),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 2,
            ),
            onPressed: () {
              quizProvider.retakeQuiz();
              Navigator.pop(context, true);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.replay, size: 24, color: colors['onPrimary']),
                const SizedBox(height: 8),
                Text(
                  locProvider.translate('retakeQuiz'),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Noto Kufi Arabic',
                    color: colors['onPrimary'],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        // Review Button
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(double.infinity, 60),
              side: BorderSide(color: colors['outlineVariant']!, width: 2),
              foregroundColor: colors['onSurface'],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            onPressed: () {},
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.history,
                  size: 24,
                  color: colors['onSurfaceVariant'],
                ),
                const SizedBox(height: 8),
                Text(
                  locProvider.translate('reviewAnswers'),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Noto Kufi Arabic',
                    color: colors['onSurface'],
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 16),

        // Setup Button
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(double.infinity, 60),
              side: BorderSide(color: colors['outlineVariant']!, width: 2),
              foregroundColor: colors['onSurface'],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            onPressed: () {
              QuizProvider().resetQuiz();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const MyApp()),
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.upload_file_outlined,
                  size: 24,
                  color: colors['onSurfaceVariant'],
                ),
                const SizedBox(height: 8),
                Text(
                  locProvider.translate('goToSetupScreen'),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Noto Kufi Arabic',
                    color: colors['onSurface'],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
