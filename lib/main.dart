import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizz_app/localization/localization_provider.dart';
import 'package:quizz_app/providers/quiz_provider.dart';
import 'package:quizz_app/providers/theme_provider.dart' hide ThemeMode;
import 'package:quizz_app/providers/setup_provider.dart';
import 'package:quizz_app/screens/profile_screen.dart';
import 'package:quizz_app/screens/setting_screen.dart';
import 'package:quizz_app/screens/setup_quizz_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LocalizationProvider()),
        ChangeNotifierProvider(create: (_) => SetupProvider()),
        ChangeNotifierProvider(create: (_) => QuizProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  int selectedIndex = 0;

  // بدلاً من القائمة السابقة، استخدم دالة بسيطة
  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return const SetupScreen();
      case 1:
        return const profile(); // تأكد من تسمية الكلاسات تبدأ بحرف كبير
      case 2:
        return const setting();
      default:
        return const SetupScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final isDarkMode = themeProvider.isDarkMode;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _buildLightTheme(),
      darkTheme: _buildDarkTheme(),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: SafeArea(
        child: Scaffold(
          body: _getPage(selectedIndex),

          bottomNavigationBar: BottomNavigationBar(
            currentIndex: selectedIndex,

            onTap: (index) {
              setState(() {
                selectedIndex = index;
              });
            },

            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                icon: Icon(Icons.history),
                label: 'History',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
          ),
        ),
      ),
    );
  }

  ThemeData _buildLightTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: const Color(0xFFFAFBFF),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFFFFFFFF),
        surfaceTintColor: Colors.transparent,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xFFFFFFFF),
      ),
    );
  }

  ThemeData _buildDarkTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF11131B),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF1D1F28),
        surfaceTintColor: Colors.transparent,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xFF1D1F28),
      ),
    );
  }
}

class Question {
  final int correctAnswerIndex;
  final String questionText;
  final List<String> options;

  Question({
    required this.questionText,
    required this.options,
    required this.correctAnswerIndex,
  });
}
