import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizz_app/localization/localization_provider.dart';
import 'package:quizz_app/providers/quiz_provider.dart';
import 'package:quizz_app/providers/theme_provider.dart';
import 'package:quizz_app/screens/profile_screen.dart';
import 'package:quizz_app/screens/quizz_screen.dart';
import 'dart:math' as math;
import 'package:quizz_app/providers/setup_provider.dart';

class SetupScreen extends StatefulWidget {
  const SetupScreen({super.key});

  @override
  State<SetupScreen> createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _rotationController;
  int _currentTextIndex = 0;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat();

    _startTextRotation();
  }

  late Timer _textTimer;

  void _startTextRotation() {
    _textTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (!mounted) return;

      setState(() {
        _currentTextIndex = (_currentTextIndex + 1) % 4;
      });
    });
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _animationController.dispose();
    _textTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final locProvider = context.watch<LocalizationProvider>();
    final setupProvider = context.watch<SetupProvider>();
    final colors = themeProvider.getColors();

    return Directionality(
      textDirection: locProvider.textDirection,
      child: Consumer<SetupProvider>(
        builder: (context, setup, child) {
          if (SetupProvider.isReady) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Provider.of<QuizProvider>(
                context,
                listen: false,
              ).startNewQuiz(SetupProvider.questions);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const QuizzScreen()),
              );
            });
          }

          return Scaffold(
            backgroundColor: colors['background'],
            appBar: _buildAppBar(context, colors, locProvider, themeProvider),
            body: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: setupProvider.isLoading
                  ? _buildLoadingUI(context, colors, locProvider)
                  : LayoutBuilder(
                      builder: (context, constraints) {
                        final isMobile = constraints.maxWidth < 768;
                        return isMobile
                            ? _buildSetupUIMobile(
                                context,
                                colors,
                                locProvider,
                                setupProvider,
                              )
                            : _buildSetupUIWeb(
                                context,
                                colors,
                                locProvider,
                                setupProvider,
                              );
                      },
                    ),
            ),
          );
        },
      ),
    );
  }

  // === AppBar ===
  AppBar _buildAppBar(
    BuildContext context,
    Map<String, Color> colors,
    LocalizationProvider locProvider,
    ThemeProvider themeProvider,
  ) {
    return AppBar(
      backgroundColor: colors['surface'],
      elevation: 0,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(
          color: colors['outlineVariant']!.withValues(alpha: 0.5),
          height: 1.0,
        ),
      ),
      leading: IconButton(
        icon: Icon(Icons.menu, color: colors['primary']),
        onPressed: () {},
      ),
      title: Text(
        locProvider.translate('appTitle'),
        style: TextStyle(
          color: colors['primary'],
          fontWeight: FontWeight.bold,
          fontSize: 20,
          fontFamily: 'Noto Kufi Arabic',
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: Icon(
            themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
            color: colors['primary'],
            size: 24,
          ),
          onPressed: () => themeProvider.toggleTheme(),
        ),
        IconButton(
          icon: Icon(Icons.account_circle, color: colors['primary'], size: 28),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => profile()),
            );
          },
        ),
      ],
    );
  }

  // === Setup UI Mobile ===
  Widget _buildSetupUIMobile(
    BuildContext context,
    Map<String, Color> colors,
    LocalizationProvider locProvider,
    SetupProvider setupProvider,
  ) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Image.asset('assets/images/logo.png', height: 100, width: 100),
          const SizedBox(height: 24),

          // === Title ===
          Text(
            locProvider.translate('setupTitle'),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: colors['onSurface'],
              fontFamily: 'Noto Kufi Arabic',
            ),
          ),
          const SizedBox(height: 10),

          // === Subtitle ===
          Text(
            locProvider.translate('setupSubtitle'),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: colors['onSurfaceVariant'],
              height: 1.5,
              fontFamily: 'Noto Kufi Arabic',
            ),
          ),
          const SizedBox(height: 28),

          // === Language Card ===
          _buildLanguageCard(context, colors, locProvider, setupProvider),
          const SizedBox(height: 16),

          // === Question Count Card ===
          _buildQuestionCountCard(context, colors, locProvider, setupProvider),
          const SizedBox(height: 16),

          // === Difficulty Card ===
          _buildDifficultyCard(context, colors, locProvider, setupProvider),
          const SizedBox(height: 28),

          // === Generate Button ===
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0058BD),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
              ),
              icon: const Icon(Icons.cloud_upload_rounded, size: 22),
              label: Text(
                locProvider.translate('generateButton'),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Noto Kufi Arabic',
                ),
              ),
              onPressed: () => _handleGenerateQuiz(context, locProvider),
            ),
          ),
          const SizedBox(height: 12),

          // === Info Text ===
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.info_rounded,
                size: 16,
                color: colors['onSurfaceVariant'],
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  locProvider.translate('fileInfo'),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
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

  // === Setup UI Web ===
  Widget _buildSetupUIWeb(
    BuildContext context,
    Map<String, Color> colors,
    LocalizationProvider locProvider,
    SetupProvider setupProvider,
  ) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Image.asset('assets/images/logo.png', height: 140, width: 140),
              const SizedBox(height: 32),

              // === Title ===
              Text(
                locProvider.translate('setupTitle'),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: colors['onSurface'],
                  fontFamily: 'Noto Kufi Arabic',
                ),
              ),
              const SizedBox(height: 12),

              // === Subtitle ===
              SizedBox(
                width: 400,
                child: Text(
                  locProvider.translate('setupSubtitle'),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: colors['onSurfaceVariant'],
                    height: 1.6,
                    fontFamily: 'Noto Kufi Arabic',
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // === Cards Row ===
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // === Left Column: Language & Question Count ===
                  Expanded(
                    child: Column(
                      children: [
                        _buildLanguageCard(
                          context,
                          colors,
                          locProvider,
                          setupProvider,
                        ),
                        const SizedBox(height: 20),
                        _buildQuestionCountCard(
                          context,
                          colors,
                          locProvider,
                          setupProvider,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),

                  // === Right Column: Difficulty ===
                  Expanded(
                    child: _buildDifficultyCard(
                      context,
                      colors,
                      locProvider,
                      setupProvider,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),

              // === Generate Button ===
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 300,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0058BD),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 4,
                      ),
                      icon: const Icon(Icons.cloud_upload_rounded, size: 24),
                      label: Text(
                        locProvider.translate('generateQuizNow'),
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Noto Kufi Arabic',
                        ),
                      ),
                      onPressed: () =>
                          _handleGenerateQuiz(context, locProvider),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // === Info Text ===
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.info_rounded,
                    size: 18,
                    color: colors['onSurfaceVariant'],
                  ),
                  const SizedBox(width: 12),
                  SizedBox(
                    width: 400,
                    child: Text(
                      locProvider.translate('fileInfo'),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        color: colors['onSurfaceVariant'],
                        fontFamily: 'Noto Kufi Arabic',
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // === Language Card ===
  Widget _buildLanguageCard(
    BuildContext context,
    Map<String, Color> colors,
    LocalizationProvider locProvider,
    SetupProvider setupProvider,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colors['surfaceContainer'],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colors['outlineVariant']!, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // === Header with Icon ===
          Row(
            children: [
              Icon(Icons.language_rounded, color: colors['primary'], size: 22),
              const SizedBox(width: 8),
              Text(
                locProvider.translate('languageLabel'),
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: colors['onSurface'],
                  fontFamily: 'Noto Kufi Arabic',
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // === Language Buttons ===
          Wrap(
            spacing: 10,
            runSpacing: 10,
            alignment: locProvider.textDirection == TextDirection.rtl
                ? WrapAlignment.end
                : WrapAlignment.start,
            children: [
              _buildLanguageButton(
                context,
                AppLanguage.arabic,
                locProvider.translate('arabicLanguage'),
                colors,
                locProvider,
              ),
              _buildLanguageButton(
                context,
                AppLanguage.english,
                locProvider.translate('englishLanguage'),
                colors,
                locProvider,
              ),
              _buildLanguageButton(
                context,
                AppLanguage.sorani,
                locProvider.translate('kurdiSorani'),
                colors,
                locProvider,
              ),
              _buildLanguageButton(
                context,
                AppLanguage.kurmanji,
                locProvider.translate('kurdiBadini'),
                colors,
                locProvider,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageButton(
    BuildContext context,
    AppLanguage language,
    String label,
    Map<String, Color> colors,
    LocalizationProvider locProvider,
  ) {
    final isSelected = locProvider.currentLanguage == language;

    return InkWell(
      onTap: () => locProvider.changeLanguage(language),
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? colors['primary']!.withValues(alpha: 0.15)
              : colors['surfaceLow'],
          border: Border.all(
            color: isSelected ? colors['primary']! : colors['outlineVariant']!,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isSelected)
              Padding(
                padding: const EdgeInsets.only(left: 6),
                child: Icon(
                  Icons.check_circle,
                  size: 16,
                  color: colors['primary'],
                ),
              ),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: isSelected
                    ? colors['primary']
                    : colors['onSurfaceVariant'],
                fontFamily: 'Noto Kufi Arabic',
              ),
            ),
          ],
        ),
      ),
    );
  }

  // === Question Count Card ===
  Widget _buildQuestionCountCard(
    BuildContext context,
    Map<String, Color> colors,
    LocalizationProvider locProvider,
    SetupProvider setupProvider,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colors['surfaceContainer'],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colors['outlineVariant']!, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // === Header with Icon ===
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.list_rounded,
                    color: colors['secondary'],
                    size: 22,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    locProvider.translate('questionCountLabel'),
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: colors['onSurface'],
                      fontFamily: 'Noto Kufi Arabic',
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),

          // === Question Count Buttons ===
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: setupProvider.questionCounts.map((count) {
              final isSelected = setupProvider.selectedQuestionCount == count;
              return InkWell(
                onTap: () => setupProvider.changeQuestionCount(count),
                borderRadius: BorderRadius.circular(14),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 50,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? colors['secondary']
                        : colors['surfaceLow'],
                    border: Border.all(
                      color: isSelected
                          ? colors['secondary']!
                          : colors['outlineVariant']!,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Text(
                    "$count",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isSelected
                          ? colors['onSecondary']
                          : colors['onSurface'],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // === Difficulty Card ===
  Widget _buildDifficultyCard(
    BuildContext context,
    Map<String, Color> colors,
    LocalizationProvider locProvider,
    SetupProvider setupProvider,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colors['surfaceContainer'],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colors['outlineVariant']!, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // === Header with Icon ===
          Row(
            children: [
              Icon(Icons.speed_rounded, color: colors['tertiary'], size: 22),
              const SizedBox(width: 8),
              Text(
                locProvider.translate('difficultyLabel'),
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: colors['onSurface'],
                  fontFamily: 'Noto Kufi Arabic',
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // === Difficulty Options ===
          Column(
            children: setupProvider.difficulties.map((diff) {
              final isSelected = setupProvider.selectedDifficulty == diff;
              final icon =
                  setupProvider.difficultyIcons[diff] ??
                  Icons.sentiment_satisfied_alt_outlined;

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: InkWell(
                  onTap: () => setupProvider.changeDifficulty(diff),
                  borderRadius: BorderRadius.circular(14),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? colors['primary']!.withValues(alpha: 0.15)
                          : colors['surfaceLow'],
                      border: Border.all(
                        color: isSelected
                            ? colors['primary']!
                            : colors['outlineVariant']!,
                        width: isSelected ? 2 : 1,
                      ),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          isSelected
                              ? Icons.radio_button_checked
                              : Icons.radio_button_off,
                          size: 20,
                          color: isSelected
                              ? colors['primary']
                              : colors['outlineVariant'],
                        ),
                        const SizedBox(width: 12),
                        Icon(
                          icon,
                          size: 20,
                          color: isSelected
                              ? colors['primary']
                              : colors['onSurfaceVariant'],
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            locProvider.translate(diff),
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.w500,
                              color: isSelected
                                  ? colors['primary']
                                  : colors['onSurface'],
                              fontFamily: 'Noto Kufi Arabic',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // === Loading UI ===
  Widget _buildLoadingUI(
    BuildContext context,
    Map<String, Color> colors,
    locProvider,
  ) {
    final progress = context.watch<SetupProvider>().loadingProgress;

    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Rounded Square Progress Indicator
            Container(
              width: 240,
              height: 280,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    colors['primary']!.withValues(alpha: 0.3),
                    colors['primary']!.withValues(alpha: 0.05),
                  ],
                ),
                border: Border.all(
                  color: colors['primary']!.withValues(alpha: 0.15),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: colors['primary']!.withValues(alpha: 0.15),
                    blurRadius: 30,
                    spreadRadius: 10,
                  ),
                ],
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Rotating gradient stroke (top-right corner)
                  AnimatedBuilder(
                    animation: _rotationController,
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: _rotationController.value * 2 * math.pi,
                        child: Container(
                          width: 240,
                          height: 280,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(32),
                            gradient: SweepGradient(
                              transform: const GradientRotation(-math.pi / 4),
                              colors: [
                                colors['primary']!,
                                colors['primary']!.withValues(alpha: 0.4),
                                Colors.transparent,
                                Colors.transparent,
                              ],
                              stops: const [0.0, 0.3, 0.6, 1.0],
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  // Inner content container
                  Container(
                    width: 238,
                    height: 278,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: colors['background'],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Sparkle Icon
                        TweenAnimationBuilder<double>(
                          tween: Tween(begin: 1.0, end: 1.2),
                          duration: const Duration(milliseconds: 1200),
                          curve: Curves.easeInOut,
                          onEnd: () {
                            // Reset animation
                          },
                          builder: (context, scale, child) {
                            return Transform.scale(
                              scale: scale,
                              child: Icon(
                                Icons.auto_awesome_rounded,
                                color: colors['primary'],
                                size: 42,
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 16),

                        // Percentage
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              "%",
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w600,
                                color: colors['onSurface']!.withValues(
                                  alpha: 0.6,
                                ),
                                fontFamily: 'Noto Kufi Arabic',
                              ),
                            ),
                            const SizedBox(width: 4),
                            TweenAnimationBuilder<int>(
                              tween: IntTween(begin: 0, end: progress.toInt()),
                              duration: const Duration(milliseconds: 800),
                              builder: (context, value, child) {
                                return Text(
                                  value.toString(),
                                  style: TextStyle(
                                    fontSize: 56,
                                    fontWeight: FontWeight.bold,
                                    color: colors['onSurface'],
                                    fontFamily: 'Noto Kufi Arabic',
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Progress dots (top and bottom)
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: colors['primary']!.withValues(alpha: 0.4),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 12,
                    left: 12,
                    child: Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: colors['primary']!.withValues(alpha: 0.4),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // Main heading
            Text(
              locProvider.translate('loadingText'),
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: colors['onSurface'],
                fontFamily: 'Noto Kufi Arabic',
                letterSpacing: 0.5,
              ),
            ),

            const SizedBox(height: 16),

            // Animated subtext with fade transition
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: SizedBox(
                height: 54,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  transitionBuilder: (child, animation) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                  child: Text(
                    [
                      locProvider.translate('loadingSubtitle1'),
                      locProvider.translate('loadingSubtitle2'),
                      locProvider.translate('loadingSubtitle3'),
                      locProvider.translate('loadingSubtitle4'),
                    ][_currentTextIndex],
                    key: ValueKey<int>(_currentTextIndex),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: colors['onSurfaceVariant']!.withValues(alpha: 0.7),
                      height: 1.6,
                      fontFamily: 'Noto Kufi Arabic',
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Processing indicator with animated dots
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animated dots
                SizedBox(
                  width: 32,
                  height: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        child: ScaleTransition(
                          scale: Tween<double>(begin: 0.5, end: 1.0).animate(
                            CurvedAnimation(
                              parent: _animationController,
                              curve: Interval(
                                index * 0.2,
                                index * 0.2 + 0.6,
                                curve: Curves.easeInOut,
                              ),
                            ),
                          ),
                          child: Container(
                            width: 4,
                            height: 4,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: colors['primary'],
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  locProvider.translate('processingData'),
                  style: TextStyle(
                    fontSize: 13,
                    color: colors['primary']!.withValues(alpha: 0.6),
                    fontFamily: 'Noto Kufi Arabic',
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleGenerateQuiz(
    BuildContext context,
    LocalizationProvider locProvider,
  ) async {
    final setupProvider = context.read<SetupProvider>();
    final themeProvider = context.read<ThemeProvider>();
    final messenger = ScaffoldMessenger.of(context);
    final colors = themeProvider.getColors();

    setupProvider.selectedLanguage = locProvider.currentLanguage.displayName;

    final result = await setupProvider.generateQuiz();

    // التحقق من الأخطاء أولاً
    if (setupProvider.errorMessage != null) {
      _showCustomSnackBar(
        messenger: messenger,
        message: setupProvider.errorMessage!,
        colors: colors,
        textDirection: locProvider.textDirection,
        isError: true,
      );
      return; // ✅ خروج من الدالة
    }

    if (result == null) {
      _showCustomSnackBar(
        messenger: messenger,
        message: locProvider.translate('noFileSelected'),
        colors: colors,
        textDirection: locProvider.textDirection,
      );
      return; // ✅ خروج من الدالة
    }

    if (result.isEmpty) {
      _showCustomSnackBar(
        messenger: messenger,
        message: locProvider.translate('generationFailed'),
        colors: colors,
        textDirection: locProvider.textDirection,
        isError: true,
      );
      return; // ✅ خروج من الدالة
    }

    // ✅ الآن فقط ننتقل للصحة التالية
    if (context.mounted) {
      Provider.of<QuizProvider>(context, listen: false).startNewQuiz(result);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const QuizzScreen()),
      );
    }
  }

  void _showCustomSnackBar({
    required ScaffoldMessengerState messenger,
    required String message,
    required Map<String, Color> colors,
    required TextDirection textDirection,
    bool isError = false, // ميزة إضافية لتغيير اللون عند الخطأ
  }) {
    // نقوم بإلغاء أي SnackBar ظاهر حالياً لمنع تراكم الرسائل
    messenger.hideCurrentSnackBar();

    messenger.showSnackBar(
      SnackBar(
        backgroundColor: isError ? Colors.redAccent : colors['surfaceHigh'],
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(
          16,
        ), // يعطي مسافة جمالية حول الـ Bento Box التابع لك
        content: Text(
          message,
          textDirection: textDirection,
          style: TextStyle(
            color: isError ? Colors.white : colors['onSurface'],
            fontFamily: 'Noto Kufi Arabic',
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
