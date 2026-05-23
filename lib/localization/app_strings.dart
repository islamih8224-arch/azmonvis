class AppStrings {
  // ==========================================
  // 1. Arabic Strings (العربية)
  // ==========================================
  static const Map<String, String> arStrings = {
    // App & Core
    'appTitle': 'مُولّد الاختبارات الذكي',
    'home': 'الرئيسية',
    'history': 'السجل',
    'settings': 'الإعدادات',
    'menu': 'القائمة',
    'profile': 'الملف الشخصي',
    'search': 'بحث',
    'searchHint': 'ابحث...',
    'notifications': 'الإشعارات',
    'close': 'إغلاق',
    'closeButton': 'إغلاق',
    'continueButton': 'متابعة',
    'backButton': 'رجوع',
    'cancelButton': 'إلغاء',
    'saveButton': 'حفظ',
    'openMenu': 'افتح القائمة',

    // Setup & Upload
    'setupTitle': 'قم بإعداد اختبارك المخصص من كتاب PDF',
    'setupSubtitle':
        'قم بضبط الإعدادات أدناه لتوليد أسئلة تناسب مستواك واحتياجاتك بدقة.',
    'languageLabel': 'لغة الاختبار',
    'questionCountLabel': 'عدد الأسئلة',
    'questionCountHint': 'اختر العدد',
    'selectCount': 'اختر الكمية',
    'difficultyLabel': 'مستوى الصعوبة',
    'difficultyDescription': 'سيتم ضبط الأسئلة لتتحدى مستوى معرفتك',
    'beginnerDifficulty': 'مبتدئ',
    'intermediateDifficulty': 'متوسط',
    'advancedDifficulty': 'متقدم',
    'uploadButtonText': 'رفع ملف PDF وتوليد الاختبار الآن',
    'generateButton': 'توليد الاختبار',
    'generateQuizNow': 'توليد الاختبار الآن',
    'uploadPdf': 'رفع ملف PDF',
    'uploadPdfButton': 'رفع PDF',
    'chooseFile': 'اختر ملف',
    'choosePdfFile': 'اختر ملف PDF',
    'dragDropPdf': 'اسحب وأفلت ملف PDF هنا',
    'pdfRequirements': 'يجب أن يحتوي الـ PDF على نص قابل للتحديد',
    'maxFileSize': 'الحد الأقصى المسموح به هو 30 ميجابايت',
    'fileInfo':
        'يدعم الملفات حتى 30 ميجابايت، يفضل أن يكون النص بالداخل قابلاً للتحديد.',
    'uploadHint':
        'يدعم الملفات حتى 30 ميجابايت، يفضل أن يكون النص قابلاً للتحديد.',

    // Loading States
    'loadingText': 'انتظر قليلاً...',
    'pleaseWait': 'يرجى الانتظار...',
    'uploadingPdf': 'جاري رفع ملف PDF...',
    'readingPdf': 'جاري قراءة محتوى الملف...',
    'analyzingContent': 'جاري تحليل المحتوى التعليمي...',
    'creatingQuestions': 'جاري إنشاء أسئلة ذكية...',
    'buildingChoices': 'جاري تصميم خيارات الإجابات...',
    'finalizingQuiz': 'جاري تنسيق الاختبار النهائي...',
    'extractingText': 'جاري استخراج النص من الملف...',
    'generatingQuestions': 'جاري توليد الأسئلة...',
    'loadingSubtitle1': 'الذكاء الاصطناعي يقرأ الكتاب ويولد الأسئلة...',
    'loadingSubtitle2': 'تحليل المفاهيم الرئيسية واستخراج التواريخ...',
    'loadingSubtitle3': 'تصميم خيارات متعددة ذكية لتحدي قدراتك...',
    'loadingSubtitle4': 'تنسيق هيكلية الاختبار النهائي...',
    'processingData': 'معالجة البيانات اللغوية بدقة عالية...',

    // Quiz Screen
    'startQuiz': 'ابدأ الاختبار',
    'startQuizButton': 'ابدأ الاختبار',
    'submitQuiz': 'تسليم الاختبار',
    'submitQuizButton': 'تسليم الاختبار',
    'finishQuiz': 'إنهاء الاختبار',
    'finishQuizButton': 'إنهاء الاختبار',
    'nextQuestion': 'السؤال التالي',
    'nextQuestionButton': 'السؤال التالي',
    'currentExam': 'الاختبار الحالي',
    'progress': 'التقدم',
    'question': 'السؤال',
    'of': 'من',
    'criticalThinking': 'تفكير نقدي',
    'difficultyLevel': 'مستوى الصعوبة',
    'AIHint': 'تلميح الذكاء الاصطناعي',
    'hintText':
        'هذا تلميح مولّد بالذكاء الاصطناعي لمساعدتك على التفكير في الإجابة.',
    'selectAnswer': 'يرجى تحديد إجابة قبل المتابعة',
    'selectAnswerMessage': 'يرجى تحديد إجابة قبل المتابعة',
    'correctAnswer': 'إجابة صحيحة',
    'correctAnswerLabel': 'الإجابة الصحيحة',
    'wrongAnswer': 'إجابة خاطئة',
    'wrongAnswerLabel': 'الإجابة الخاطئة',

    // Result Screen
    'finalResult': 'النتيجة النهائية',
    'quizCompleted': 'اكتمل الاختبار',
    'quizCompletedMessage': 'تم إكمال الاختبار بنجاح',
    'wonMessage': 'تهانينا!',
    'excellentWork': 'لقد أكملت الاختبار بنجاح!',
    'greatJobMessage': 'عمل رائع!',
    'yourFinalScore': 'نتيجتك النهائية',
    'quizStatistics': 'إحصائيات الاختبار',
    'performance': 'الأداء',
    'performanceLabel': 'الأداء',
    'accuracy': 'الدقة',
    'accuracyLabel': 'الدقة',
    'time': 'الوقت',
    'completionTime': 'وقت الإنجاز',
    'speed': 'السرعة',
    'speedRate': 'معدل السرعة',
    'successRate': 'نسبة النجاح',
    'answeredQuestions': 'الأسئلة المجابة',
    'totalQuestions': 'إجمالي الأسئلة',
    'correctAnswers': 'الإجابات الصحيحة',
    'wrongAnswers': 'الإجابات الخاطئة',
    'retakeQuiz': 'إعادة الاختبار',
    'retakeQuizButton': 'إعادة الاختبار',
    'reviewAnswers': 'مراجعة الإجابات',
    'reviewAnswersButton': 'مراجعة الإجابات',
    'goToSetupScreen': 'رفع PDF آخر',
    'loadAnotherPdfButton': 'رفع PDF آخر',
    'quizGeneratedSuccessfully': 'تم توليد الاختبار بنجاح',
    'quizRetakenSuccessfully': 'تم إعادة تشغيل الاختبار بنجاح',

    // Settings & Theme & Language
    'language': 'اللغة',
    'selectLanguage': 'اختر اللغة',
    'selectLanguageTitle': 'اختر اللغة',
    'arabicLanguage': 'العربية',
    'englishLanguage': 'الانجليزية',
    'kurdiSorani': 'الكردية السورانية',
    'languageChanged': 'تم تغيير اللغة بنجاح',
    'theme': 'المظهر',
    'selectTheme': 'اختر المظهر',
    'selectThemeTitle': 'اختر المظهر',
    'systemTheme': 'مظهر النظام',
    'darkTheme': 'غامق',
    'lightTheme': 'فاتح',

    // Navigation Labels & Tooltips
    'homeTab': 'الرئيسية',
    'historyTab': 'السجل',
    'settingsTab': 'الإعدادات',
    'profileTab': 'الملف الشخصي',
    'homeLabel': 'الرئيسية',
    'historyLabel': 'السجل',
    'settingsLabel': 'الإعدادات',
    'menuLabel': 'القائمة',
    'profileLabel': 'الملف الشخصي',
    'homeTooltip': 'الذهاب للرئيسية',
    'historyTooltip': 'عرض سجل الاختبارات',
    'settingsTooltip': 'فتح الإعدادات',

    // Empty States
    'noHistoryAvailable': 'لا يوجد سجل متاح بعد',
    'noHistoryYet': 'لا يوجد سجل اختبارات حتى الآن',
    'featureComingSoon': 'هذه الميزة قادمة قريباً',
    'comingSoon': 'قريباً',
    'featureUnavailable': 'هذه الميزة غير متاحة حالياً',
    'nothingFound': 'لم يتم العثور على شيء',

    // Errors
    'errorOccurred': 'حدث خطأ غير متوقع',
    'networkError': 'يرجى التحقق من اتصالك بالإنترنت',
    'internetError': 'يرجى التحقق من اتصالك بالإنترنت',
    'failedToLoad': 'فشل في تحميل البيانات',
    'tryAgain': 'حاول مجدداً',
    'tryAgainButton': 'حاول مجدداً',
    'noFileSelected': 'لم يتم اختيار ملف أو الملف فارغ.',
    'invalidPdf': 'ملف PDF غير صالح',
    'invalidFile': 'صيغة الملف غير مدعومة أو غير صالحة',
    'emptyPdf': 'ملف PDF فارغ',
    'fileTooLarge': 'الملف المحدد يتجاوز الحجم الأقصى المسموح به',
    'generationFailed': 'فشل الذكاء الاصطناعي في التوليد. حاول مجدداً.',
    'rateLimitExceeded':
        'تم تجاوز حد الطلبات المسموح به. يرجى المحاولة لاحقاً.',
    'quotaExhausted': 'تم استنزاف حد الطلبات المجاني. يرجى المحاولة غداً.',
    'authenticationError': 'مشكلة في المصادقة. يرجى التحقق من الإعدادات.',
    'invalidContent': 'محتوى غير صالح. يرجى التأكد من صيغة الملف.',
    'geminiError': 'خطأ من خادم الذكاء الاصطناعي. يرجى المحاولة مجدداً.',

    'kurdiBadini': 'الكردية البادينية',
    // Decoration / Misc
    'neuralSystemsAnalysis': 'تحليل الأنظمة العصبية',
  };

  // ==========================================
  // 2. English Strings (English)
  // ==========================================
  static const Map<String, String> enStrings = {
    // App & Core
    'appTitle': 'Smart Quiz Generator',
    'home': 'Home',
    'history': 'History',
    'settings': 'Settings',
    'menu': 'Menu',
    'profile': 'Profile',
    'search': 'Search',
    'searchHint': 'Search...',
    'notifications': 'Notifications',
    'close': 'Close',
    'closeButton': 'Close',
    'continueButton': 'Continue',
    'backButton': 'Back',
    'cancelButton': 'Cancel',
    'saveButton': 'Save',
    'openMenu': 'Open Menu',

    // Setup & Upload
    'setupTitle': 'Set Up Your Custom Quiz from PDF',
    'setupSubtitle':
        'Adjust the settings below to generate questions that match your level and needs accurately.',
    'languageLabel': 'Quiz Language',
    'questionCountLabel': 'Number of Questions',
    'questionCountHint': 'Select Quantity',
    'selectCount': 'Select Quantity',
    'difficultyLabel': 'Difficulty Level',
    'difficultyDescription':
        'Questions will be adjusted to challenge your knowledge',
    'beginnerDifficulty': 'Beginner',
    'intermediateDifficulty': 'Intermediate',
    'advancedDifficulty': 'Advanced',
    'uploadButtonText': 'Upload PDF and Generate Quiz Now',
    'generateButton': 'Generate Quiz',
    'generateQuizNow': 'Generate Quiz Now',
    'uploadPdf': 'Upload PDF',
    'uploadPdfButton': 'Upload PDF',
    'chooseFile': 'Choose File',
    'choosePdfFile': 'Choose PDF File',
    'dragDropPdf': 'Drag & Drop PDF Here',
    'pdfRequirements': 'PDF should contain selectable text',
    'maxFileSize': 'Maximum allowed size is 30 MB',
    'fileInfo':
        'Supports files up to 30 MB, preferably with selectable text inside.',
    'uploadHint':
        'Supports files up to 30 MB, preferably with selectable text inside.',

    // Loading States
    'loadingText': 'Please wait...',
    'pleaseWait': 'Please wait...',
    'uploadingPdf': 'Uploading PDF...',
    'readingPdf': 'Reading PDF content...',
    'analyzingContent': 'Analyzing educational content...',
    'creatingQuestions': 'Creating intelligent questions...',
    'buildingChoices': 'Generating multiple choice answers...',
    'finalizingQuiz': 'Finalizing quiz structure...',
    'extractingText': 'Extracting text from file...',
    'generatingQuestions': 'Generating questions...',
    'loadingSubtitle1': 'AI is reading the book and generating questions...',
    'loadingSubtitle2': 'Analyzing key concepts and extracting dates...',
    'loadingSubtitle3':
        'Designing smart multiple choice options to challenge you...',
    'loadingSubtitle4': 'Formatting the final test structure...',
    'processingData': 'Processing language data with high precision...',

    // Quiz Screen
    'startQuiz': 'Start Quiz',
    'startQuizButton': 'Start Quiz',
    'submitQuiz': 'Submit Quiz',
    'submitQuizButton': 'Submit Quiz',
    'finishQuiz': 'Finish Quiz',
    'finishQuizButton': 'Finish Quiz',
    'nextQuestion': 'Next Question',
    'nextQuestionButton': 'Next Question',
    'currentExam': 'Current Exam',
    'progress': 'Progress',
    'question': 'Question',
    'of': 'of',
    'criticalThinking': 'Critical Thinking',
    'difficultyLevel': 'Difficulty Level',
    'AIHint': 'AI Hint',
    'hintText':
        'This is an AI-generated hint to help you think critically about the question.',
    'selectAnswer': 'Please select an answer before continuing',
    'selectAnswerMessage': 'Please select an answer before continuing',
    'correctAnswer': 'Correct Answer',
    'correctAnswerLabel': 'Correct Answer',
    'wrongAnswer': 'Wrong Answer',
    'wrongAnswerLabel': 'Wrong Answer',

    // Result Screen
    'finalResult': 'Final Result',
    'quizCompleted': 'Quiz Completed',
    'quizCompletedMessage': 'Quiz Completed Successfully',
    'wonMessage': 'Congratulations!',
    'excellentWork': 'You have completed the quiz successfully!',
    'greatJobMessage': 'Great job!',
    'yourFinalScore': 'Your Final Score',
    'quizStatistics': 'Quiz Statistics',
    'performance': 'Performance',
    'performanceLabel': 'Performance',
    'accuracy': 'Accuracy',
    'accuracyLabel': 'Accuracy',
    'time': 'Time',
    'completionTime': 'Completion Time',
    'speed': 'Speed',
    'speedRate': 'Speed Rate',
    'successRate': 'Success Rate',
    'answeredQuestions': 'Answered Questions',
    'totalQuestions': 'Total Questions',
    'correctAnswers': 'Correct Answers',
    'wrongAnswers': 'Wrong Answers',
    'retakeQuiz': 'Retake Quiz',
    'retakeQuizButton': 'Retake Quiz',
    'reviewAnswers': 'Review Answers',
    'reviewAnswersButton': 'Review Answers',
    'goToSetupScreen': 'Load Another PDF',
    'loadAnotherPdfButton': 'Load Another PDF',
    'quizGeneratedSuccessfully': 'Quiz generated successfully',
    'quizRetakenSuccessfully': 'Quiz restarted successfully',

    // Settings & Theme & Language
    'language': 'Language',
    'selectLanguage': 'Select Language',
    'selectLanguageTitle': 'Select Language',
    'arabicLanguage': 'Arabic',
    'englishLanguage': 'English',
    'kurdiSorani': 'Sorani Kurdish',
    'languageChanged': 'Language changed successfully',
    'theme': 'Theme',
    'selectTheme': 'Select Theme',
    'selectThemeTitle': 'Select Theme',
    'systemTheme': 'System Theme',
    'darkTheme': 'Dark',
    'lightTheme': 'Light',

    // Navigation Labels & Tooltips
    'homeTab': 'Home',
    'historyTab': 'History',
    'settingsTab': 'Settings',
    'profileTab': 'Profile',
    'homeLabel': 'Home',
    'historyLabel': 'History',
    'settingsLabel': 'Settings',
    'menuLabel': 'Menu',
    'profileLabel': 'Profile',
    'homeTooltip': 'Go to Home',
    'historyTooltip': 'View Quiz History',
    'settingsTooltip': 'Open Settings',

    // Empty States
    'noHistoryAvailable': 'No history available yet',
    'noHistoryYet': 'No quiz history yet',
    'featureComingSoon': 'This feature is coming soon',
    'comingSoon': 'Coming soon',
    'featureUnavailable': 'This feature is currently unavailable',
    'nothingFound': 'Nothing found',

    // Errors
    'errorOccurred': 'An unexpected error occurred',
    'networkError': 'Please check your internet connection',
    'internetError': 'Please check your internet connection',
    'failedToLoad': 'Failed to load data',
    'tryAgain': 'Try Again',
    'tryAgainButton': 'Try Again',
    'noFileSelected': 'No file selected or file is empty.',
    'invalidPdf': 'Invalid PDF file',
    'invalidFile': 'Unsupported or invalid file format',
    'emptyPdf': 'PDF file is empty',
    'fileTooLarge': 'The selected file exceeds the maximum allowed size',
    'generationFailed': 'AI failed to generate questions. Try again.',
    'rateLimitExceeded': 'Rate limit exceeded. Please try again later.',
    'quotaExhausted': 'Free quota exhausted. Please try again tomorrow.',
    'authenticationError': 'Authentication error. Please check your settings.',
    'invalidContent': 'Invalid content. Please check file format.',
    'geminiError': 'AI server error. Please try again.',

    'kurdiBadini': 'Kurdish Badini',
    // Decoration / Misc
    'neuralSystemsAnalysis': 'Neural Systems Analysis',
  };

  // ==========================================
  // 3. Kurdish Sorani Strings (کوردی سۆرانی)
  // ==========================================
  static const Map<String, String> ckStrings = {
    // App & Core
    'appTitle': 'دروستکەری تاقیکردنەوەی زیرەک',
    'home': 'سەرەکی',
    'history': 'مێژوو',
    'settings': 'ڕێکخستنەکان',
    'menu': 'مێنیو',
    'profile': 'پرۆفایل',
    'search': 'گەڕان',
    'searchHint': 'گەڕان...',
    'notifications': 'ئاگادارییەکان',
    'close': 'داخستن',
    'closeButton': 'داخستن',
    'continueButton': 'بەردەوام بە',
    'backButton': 'گەڕانەوە',
    'cancelButton': 'هەڵوەشاندنەوە',
    'saveButton': 'پاشەکەوتکردن',
    'openMenu': 'کردنەوەی مێنیو',

    'kurdiBadini': 'بادینی',
    'kurdiSorani': 'سۆرانی',
    'arabicLanguage': 'عەرەبی',
    'englishLanguage': 'ئینگلێزی',
    // Setup & Upload
    'setupTitle': 'تاقیکردنەوەی تایبەتی خۆت لە PDF ئامادە بکە',
    'setupSubtitle':
        'ڕێکخستنەکانی خوارەوە بگۆڕە بۆ دروستکردنی پرسیاری گونجاو بە ئاست و پێداویستییەکانت.',
    'languageLabel': 'زمانی تاقیکردنەوە',
    'questionCountLabel': 'ژمارەی پرسیارەکان',
    'questionCountHint': 'دیاریکردنی ژمارە',
    'selectCount': 'دیاریکردنی ژمارە',
    'difficultyLabel': 'ئاستی قورسی',
    'difficultyDescription':
        'پرسیارەکان ڕێکدەخرێن بۆ تاقیکردنەوەی ئاستی زانیاریت',
    'beginnerDifficulty': 'سەرەتایی',
    'intermediateDifficulty': 'ناوەند',
    'advancedDifficulty': 'پێشکەوتوو',
    'uploadButtonText': 'بارکردنی PDF و دروستکردنی تاقیکردنەوە',
    'generateButton': 'دروستکردنی تاقیکردنەوە',
    'generateQuizNow': 'ئێستا تاقیکردنەوەکە دروست بکە',
    'uploadPdf': 'بارکردنی PDF',
    'uploadPdfButton': 'بارکردنی PDF',
    'chooseFile': 'هەڵبژاردنی پەڕگە',
    'choosePdfFile': 'هەڵبژاردنی پەڕگەی PDF',
    'dragDropPdf': 'پەڕگەی PDF لێرە دابنێ',
    'pdfRequirements': 'پێویستە PDF دەقی دیاریکراوی تێدابێت',
    'maxFileSize': 'گەورەترین قەبارەی ڕێگەپێدراو 30 مێگابایتە',
    'fileInfo':
        'پشتگیری پەڕگەکان دەکات تا 30 مێگابایت، باشترە دەقەکەی ناوەوەی دیاری بکرێت.',
    'uploadHint':
        'پشتگیری پەڕگەکان دەکات تا 30 مێگابایت، باشترە دەقەکەی ناوەوەی دیاری بکرێت.',

    // Loading States
    'loadingText': 'تکایە چاوەڕێ بکە...',
    'pleaseWait': 'تکایە چاوەڕێ بکە...',
    'uploadingPdf': 'بارکردنی PDF...',
    'readingPdf': 'خوێندنەوەی ناوەڕۆکی PDF...',
    'analyzingContent': 'شیکردنەوەی ناوەڕۆکی پەروەردەیی...',
    'creatingQuestions': 'دروستکردنی پرسیاری زیرەک...',
    'buildingChoices': 'دروستکردنی وەڵامی هەڵبژاردن...',
    'finalizingQuiz': 'ڕێکخستنی پێکهاتەی تاقیکردنەوە...',
    'extractingText': 'دەرهێنانی دەق لە پەڕگەکە...',
    'generatingQuestions': 'دروستکردنی پرسیارەکان...',
    'loadingSubtitle1':
        'ژیری دەستکرد کتێبەکە دەخوێنێتەوە و پرسیار دروست دەکات...',
    'loadingSubtitle2':
        'شیکردنەوەی چەمکە سەرەکییەکان و دەرهێنانی بەروارەکان...',
    'loadingSubtitle3':
        'دروستکردنی هەڵبژاردەی زیرەک بۆ تاقیکردنەوەی تواناکانت...',
    'loadingSubtitle4': 'ڕێکخستنی شێوازی کۆتایی تاقیکردنەوەکە...',
    'processingData': 'چارەسەرکردنی داتای زمانەوانی بە وردی بەرز...',

    // Quiz Screen
    'startQuiz': 'دەستپێکردنی تاقیکردنەوە',
    'startQuizButton': 'دەستپێکردنی تاقیکردنەوە',
    'submitQuiz': 'ناردنی تاقیکردنەوە',
    'submitQuizButton': 'ناردنی تاقیکردنەوە',
    'finishQuiz': 'کۆتاییهێنان بە تاقیکردنەوە',
    'finishQuizButton': 'کۆتاییهێنان بە تاقیکردنەوە',
    'nextQuestion': 'پرسیاری داهاتوو',
    'nextQuestionButton': 'پرسیاری داهاتوو',
    'currentExam': 'تاقیکردنەوەی ئێستا',
    'progress': 'بەرەوپێشچوون',
    'question': 'پرسیار',
    'of': 'لە',
    'criticalThinking': 'بیرکردنەوەی ڕەخنەگرانە',
    'difficultyLevel': 'ئاستی قورسی',
    'AIHint': 'ئاماژەی ژیری دەستکرد',
    'hintText': 'ئەمە ئاماژەیەکی ژیری دەستکردە بۆ یارمەتیدانت لە بیرکردنەوە.',
    'selectAnswer': 'تکایە پێش بەردەوامبوون وەڵامێک هەڵبژێرە',
    'selectAnswerMessage': 'تکایە پێش بەردەوامبوون وەڵامێک هەڵبژێرە',
    'correctAnswer': 'وەڵامی ڕاست',
    'correctAnswerLabel': 'وەڵامی ڕاست',
    'wrongAnswer': 'وەڵامی هەڵە',
    'wrongAnswerLabel': 'وەڵامی هەڵە',

    // Result Screen
    'finalResult': 'ئەنجامی کۆتایی',
    'quizCompleted': 'تاقیکردنەوە تەواو بوو',
    'quizCompletedMessage': 'تاقیکردنەوەکە بە سەرکەوتوویی تەواو بوو',
    'wonMessage': 'پیرۆزە!',
    'excellentWork': 'تاقیکردنەوەکەت بە سەرکەوتوویی تەواو کرد!',
    'greatJobMessage': 'کاری زۆر باشە!',
    'yourFinalScore': 'ئەنجامی کۆتاییت',
    'quizStatistics': 'ئامارەکانی تاقیکردنەوە',
    'performance': 'ئاستی کارکردن',
    'performanceLabel': 'ئاستی کارکردن',
    'accuracy': 'وردی',
    'accuracyLabel': 'وردی',
    'time': 'کات',
    'completionTime': 'کاتی تەواوکردن',
    'speed': 'خێرایی',
    'speedRate': 'ڕێژەی خێرایی',
    'successRate': 'ڕێژەی سەرکەوتن',
    'answeredQuestions': 'پرسیارە وەڵامدراوەکان',
    'totalQuestions': 'کۆی گشتی پرسیارەکان',
    'correctAnswers': 'وەڵامە ڕاستەکان',
    'wrongAnswers': 'وەڵامە هەڵەکان',
    'retakeQuiz': 'دوبارەکردنەوەی تاقیکردنەوە',
    'retakeQuizButton': 'دوبارەکردنەوەی تاقیکردنەوە',
    'reviewAnswers': 'پێداچوونەوەی وەڵامەکان',
    'reviewAnswersButton': 'پێداچوونەوەی وەڵامەکان',
    'goToSetupScreen': 'بارکردنی PDFێکی تر',
    'loadAnotherPdfButton': 'بارکردنی PDFێکی تر',
    'quizGeneratedSuccessfully': 'تاقیکردنەوەکە بە سەرکەوتوویی دروست کرا',
    'quizRetakenSuccessfully': 'تاقیکردنەوەکە بە سەرکەوتوویی دەستی پێکردەوە',

    // Settings & Theme & Language
    'language': 'زمان',
    'selectLanguage': 'هەڵبژاردنی زمان',
    'selectLanguageTitle': 'هەڵبژاردنی زمان',
    'kurdiKurmanci': 'کوردی کورمانجی',
    'languageChanged': 'زمانەکە بە سەرکەوتوویی گۆڕدرا',
    'theme': 'ڕووکار',
    'selectTheme': 'هەڵبژاردنی ڕووکار',
    'selectThemeTitle': 'هەڵبژاردنی ڕووکار',
    'systemTheme': 'ڕووکاری سیستەم',
    'darkTheme': 'تاریک',
    'lightTheme': 'ڕووناک',

    // Navigation Labels & Tooltips
    'homeTab': 'سەرەکی',
    'historyTab': 'مێژوو',
    'settingsTab': 'ڕێکخستنەکان',
    'profileTab': 'پرۆفایل',
    'homeLabel': 'سەرەکی',
    'historyLabel': 'مێژوو',
    'settingsLabel': 'ڕێکخستنەکان',
    'menuLabel': 'مێنیو',
    'profileLabel': 'پرۆفایل',
    'homeTooltip': 'بڕۆ بۆ سەرەکی',
    'historyTooltip': 'بینینی مێژووی تاقیکردنەوەکان',
    'settingsTooltip': 'کردنەوەی ڕێکخستنەکان',

    // Empty States
    'noHistoryAvailable': 'هیچ مێژوویەک بەردەست نییە',
    'noHistoryYet': 'تا ئێستا هیچ مێژوویەکی تاقیکردنەوە نییە',
    'featureComingSoon': 'ئەم تایبەتمەندییە بەمزوانە بەردەست دەبێت',
    'comingSoon': 'بەمزوانە',
    'featureUnavailable': 'ئەم تایبەتمەندییە لە ئێستادا بەردەست نییە',
    'nothingFound': 'هیچ نەدۆزرایەوە',

    // Errors
    'errorOccurred': 'هەڵەیەکی چاوەڕواننەکراو ڕوویدا',
    'networkError': 'تکایە پشکنین بۆ هێڵی ئینتەرنێتەکەت بکە',
    'internetError': 'تکایە پشکنین بۆ هێڵی ئینتەرنێتەکەت بکە',
    'failedToLoad': 'نەتوانرا زانیارییەکان باربکرێن',
    'tryAgain': 'دووبارە هەوڵبدەرەوە',
    'tryAgainButton': 'دووبارە هەوڵبدەرەوە',
    'noFileSelected': 'هیچ پەڕگەیەک هەڵنەبژێردراوە یان پەڕگەکە بەتاڵە.',
    'invalidPdf': 'پەڕگەی PDF نادروستە',
    'invalidFile': 'جۆری پەڕگەکە پشتگیری ناکرێت یان نادروستە',
    'emptyPdf': 'پەڕگەی PDF بەتاڵە',
    'fileTooLarge': 'پەڕگەی هەڵبژێردراو لە قەبارەی ڕێگەپێدراو گەورەترە',
    'generationFailed':
        'ژیری دەستکرد نەیتوانی پرسیارەکان دروست بکات. هەوڵبدەرەوە.',
    'rateLimitExceeded':
        'سنووری داواکارییەکان تێپەڕیوە. تکایە دواتر هەوڵبدەرەوە.',
    'quotaExhausted': 'کۆتای خۆڕایی تەواو بووە. تکایە بەیانی هەوڵبدەرەوە.',
    'authenticationError': 'هەڵە لە چوونەژوورەوە. تکایە ڕێکخستنەکانت بپشکنە.',
    'invalidContent': 'ناوەڕۆک نادروستە. تکایە جۆری پەڕگەکە بپشکنە.',
    'geminiError': 'هەڵەی سێرڤەری ژیری دەستکرد. تکایە هەوڵبدەرەوە.',

    // Decoration / Misc
    'neuralSystemsAnalysis': 'شیکاری سیستەمە دەمارییەکان',
  };

  // ==========================================
  // 4. Kurdish Badini Strings (کوردی بادینی)
  // ==========================================
  static const Map<String, String> ckKmStrings = {
    // App & Core
    'appTitle': 'دروستکەرێ ئەزموونا زیرەک',
    'home': 'سەرەکی',
    'history': 'دیرۆک',
    'settings': 'ڕێکخستن',
    'menu': 'مێنیو',
    'profile': 'پرۆفایل',
    'search': 'لێگەڕیان',
    'searchHint': 'لێگەڕیان...',
    'notifications': 'ئاگەهداری',
    'close': 'داخستن',
    'closeButton': 'داخستن',
    'continueButton': 'بەردەوام بە',
    'backButton': 'بۆ دواڤە',
    'cancelButton': 'بەتاڵ بکە',
    'saveButton': 'پاراستن',
    'openMenu': 'مێنیویێ ڤەکە',
    'kurdiBadini': 'بادینی',
    'kurdiSorani': 'سورانی',
    'arabicLanguage': 'عەرەبی',
    'englishLanguage': 'ئینگلێزی',
    // Setup & Upload
    'setupTitle': 'ئەزموونا خۆ یا تایبەت ژ PDF ئامادە بکە',
    'setupSubtitle':
        'ڕێکخستنێن خوارێ بگهۆڕە دا کو پرسیار ل دویڤ ئاستێ تە بهێنە دروستکرن.',
    'languageLabel': 'زمانێ ئەزموونێ',
    'questionCountLabel': 'هژمارا پرسیاران',
    'questionCountHint': 'هژمارێ هەلبژێرە',
    'selectCount': 'هژمارێ هەلبژێرە',
    'difficultyLabel': 'ئاستێ زەحمەتیێ',
    'difficultyDescription': 'پرسیار دێ هێنە ڕێکخستن بۆ تاقیکرنا زانیاریێن تە',
    'beginnerDifficulty': 'دەستپێک',
    'intermediateDifficulty': 'ناڤنجی',
    'advancedDifficulty': 'پێشکەفتی',
    'uploadButtonText': 'PDF بار بکە و ئەزموونێ دروست بکە',
    'generateButton': 'ئەزموونێ دروست بکە',
    'generateQuizNow': 'نوکە ئەزموونێ دروست بکە',
    'uploadPdf': 'PDF بار بکە',
    'uploadPdfButton': 'PDF بار بکە',
    'chooseFile': 'فایلێ هەلبژێرە',
    'choosePdfFile': 'فایلێ PDF هەلبژێرە',
    'dragDropPdf': 'فایلێ PDF ل ڤێرێ دابنێ',
    'pdfRequirements': 'پێدڤیە PDF دەقێ دەستنیشانکری هەبیت',
    'maxFileSize': 'مەزنترین قەبارەیێ ڕێپێدای 30 مێگابایتە',
    'fileInfo':
        'پشتەڤانیا فایلان تا 30 مێگابایت دکەت، باشترە دەقێ ناڤدا بهێتە دەستنیشانکرن.',
    'uploadHint':
        'پشتەڤانیا فایلان تا 30 مێگابایت دکەت، باشترە دەقێ ناڤدا بهێتە دەستنیشانکرن.',

    // Loading States
    'loadingText': 'هیڤیە چاڤەڕێ بە...',
    'pleaseWait': 'هیڤیە چاڤەڕێ بە...',
    'uploadingPdf': 'PDF دهێتە بارکرن...',
    'readingPdf': 'ناڤەڕۆکا PDF دهێتە خواندن...',
    'analyzingContent': 'ناڤەڕۆکا پەروەردەیی دهێتە شیکرن...',
    'creatingQuestions': 'پرسیارێن زیرەک دهێنە دروستکرن...',
    'buildingChoices': 'بەرسڤێن هەلبژارتنێ دهێنە ئامادەکرن...',
    'finalizingQuiz': 'شێوازێ ئەزموونێ دهێتە تەمامکرن...',
    'extractingText': 'دەق ژ فایلێ دهێتە دەرخستن...',
    'generatingQuestions': 'پرسیار دهێنە دروستکرن...',
    'loadingSubtitle1':
        'ژیرییا دەستکرد پەرتووکێ دخوانیت و پرسیاران دروست دکەت...',
    'loadingSubtitle2': 'تێگەهێن سەرەکی شی دکەت و دیرۆکان دەردێخیت...',
    'loadingSubtitle3': 'هەلبژارتنێن زیرەک بۆ تاقیکرنا تە دیزاین دکەت...',
    'loadingSubtitle4': 'شێوازێ دووماهیێ یێ ئەزموونێ دهێتە ئامادەکرن...',
    'processingData':
        'داتایێن زمانەڤانی ب هویربینیەکا بەرز دهێنە چارەسەرکرن...',

    // Quiz Screen
    'startQuiz': 'ئەزموونێ دەستپێبکە',
    'startQuizButton': 'ئەزموونێ دەستپێبکە',
    'submitQuiz': 'ئەزموونێ بنێڕە',
    'submitQuizButton': 'ئەزموونێ بنێڕە',
    'finishQuiz': 'ئەزموونێ ب دووماهی بینە',
    'finishQuizButton': 'ئەزموونێ ب دووماهی بینە',
    'nextQuestion': 'پرسیارا دیڤدا',
    'nextQuestionButton': 'پرسیارا دیڤدا',
    'currentExam': 'ئەزموونا نوکە',
    'progress': 'پێشڤەچوون',
    'question': 'پرسیار',
    'of': 'ژ',
    'criticalThinking': 'هزرکرنا ڕەخنەگرانە',
    'difficultyLevel': 'ئاستێ زەحمەتیێ',
    'AIHint': 'ئاماژەیا ژیرییا دەستکرد',
    'hintText':
        'ئەڤە ئاماژەیەکە ژ لایێ ژیرییا دەستکرد ڤە هاتیە دروستکرن بۆ هاریکاریا تە.',
    'selectAnswer': 'هیڤیە بەری بەردەوامبوونێ بەرسڤەکێ هەلبژێرە',
    'selectAnswerMessage': 'هیڤیە بەری بەردەوامبوونێ بەرسڤەکێ هەلبژێرە',
    'correctAnswer': 'بەرسڤا ڕاست',
    'correctAnswerLabel': 'بەرسڤا ڕاست',
    'wrongAnswer': 'بەرسڤا خەلەت',
    'wrongAnswerLabel': 'بەرسڤا خەلەت',

    // Result Screen
    'finalResult': 'ئەنجامێ دووماهیێ',
    'quizCompleted': 'ئەزموون ب دووماهی هات',
    'quizCompletedMessage': 'ئەزموون ب سەرکەفتیانە ب دووماهی هات',
    'wonMessage': 'پیرۆزە!',
    'excellentWork': 'تە ئەزموون ب سەرکەفتیانە ب دووماهی ئینا!',
    'greatJobMessage': 'کارەکێ باشە!',
    'yourFinalScore': 'نمرەیا تە یا دووماهیێ',
    'quizStatistics': 'ئامارێن ئەزموونێ',
    'performance': 'ئاستێ کارکرنێ',
    'performanceLabel': 'ئاستێ کارکرنێ',
    'accuracy': 'دروستی',
    'accuracyLabel': 'دروستی',
    'time': 'دەم',
    'completionTime': 'دەمێ ب دووماهی ئینانێ',
    'speed': 'لەزاتی',
    'speedRate': 'ڕێژەیا لەزاتیێ',
    'successRate': 'ڕێژەیا سەرکەفتنێ',
    'answeredQuestions': 'پرسیارێن بەرسڤدراو',
    'totalQuestions': 'سەرجەمێ پرسیاران',
    'correctAnswers': 'بەرسڤێن ڕاست',
    'wrongAnswers': 'بەرسڤێن خەلەت',
    'retakeQuiz': 'ئەزموونێ دووبارە بکەڤە',
    'retakeQuizButton': 'ئەزموونێ دووبارە بکەڤە',
    'reviewAnswers': 'پێداچوونێ ل بەرسڤان بکە',
    'reviewAnswersButton': 'پێداچوونێ ل بەرسڤان بکە',
    'goToSetupScreen': 'PDFەکێ دی بار بکە',
    'loadAnotherPdfButton': 'PDFەکێ دی بار بکە',
    'quizGeneratedSuccessfully': 'ئەزموون ب سەرکەفتیانە هاتە دروستکرن',
    'quizRetakenSuccessfully': 'ئەزموون ب سەرکەفتیانە دەستپێکرەڤە',

    // Settings & Theme & Language
    'language': 'زمان',
    'selectLanguage': 'زمانێ هەلبژێرە',
    'selectLanguageTitle': 'زمانێ هەلبژێرە',
    'kurdiKurmanci': 'کوردی بادینی',
    'languageChanged': 'زمان ب سەرکەفتیانە هاتە گهوڕین',
    'theme': 'ڕووکار',
    'selectTheme': 'ڕووکارێ هەلبژێرە',
    'selectThemeTitle': 'ڕووکارێ هەلبژێرە',
    'systemTheme': 'ڕووکارێ سیستەمی',
    'darkTheme': 'تاری',
    'lightTheme': 'ڕۆهن',

    // Navigation Labels & Tooltips
    'homeTab': 'سەرەکی',
    'historyTab': 'دیرۆک',
    'settingsTab': 'ڕێکخستن',
    'profileTab': 'پرۆفایل',
    'homeLabel': 'سەرەکی',
    'historyLabel': 'دیرۆک',
    'settingsLabel': 'ڕێکخستن',
    'menuLabel': 'مێنیو',
    'profileLabel': 'پرۆفایل',
    'homeTooltip': 'هەڕە سەرەکی',
    'historyTooltip': 'دیرۆکا ئەزموونێ ببینە',
    'settingsTooltip': 'ڕێکخستنان ڤەکە',

    // Empty States
    'noHistoryAvailable': 'چ دیرۆک نینە',
    'noHistoryYet': 'هێشتا چ دیرۆکێن ئەزموونێ نینن',
    'featureComingSoon': 'ئەڤ تایبەتمەندییە دێ نێزیکدا بەردەست بیت',
    'comingSoon': 'نێزیکدا',
    'featureUnavailable': 'ئەڤ تایبەتمەندییە نوکە یا بەردەست نینە',
    'nothingFound': 'چ تشت نەهاتە دیتن',

    // Errors
    'errorOccurred': 'خەلەتیەکا نەچاڤەڕێکری ڕویدا',
    'networkError': 'هیڤیە هێلا ئینتەرنێتا خۆ کۆنترۆل بکە',
    'internetError': 'هیڤیە هێلا ئینتەرنێتا خۆ کۆنترۆل بکە',
    'failedToLoad': 'بارکرنا داتایان ب سەرنەکەفت',
    'tryAgain': 'دووبارە بزاڤێ بکە',
    'tryAgainButton': 'دووبارە بزاڤێ بکە',
    'noFileSelected': 'چ فایل نەهاتینە هەلبژارتن یان فایل یێ ڤالایە.',
    'invalidPdf': 'فایلێ PDF یێ دروست نینە',
    'invalidFile': 'فۆرماتا فایلێ یا دروست نینە یان پشتەڤانی لێ ناهێتەکرن',
    'emptyPdf': 'فایلێ PDF یێ ڤالایە',
    'fileTooLarge': 'قەبارەیێ فایلێ هەلبژارتی ژ یێ ڕێپێدای مەزنترە',
    'generationFailed':
        'ژیرییا دەستکرد نەشیا پرسیاران دروست بکەت. دووبارە بزاڤێ بکە.',
    'rateLimitExceeded':
        'سنوورێ داخازیان دەرباز بوو. هیڤیە پاشتر دووبارە بزاڤێ بکە.',
    'quotaExhausted':
        'کۆتایا بێبەرامبەر ب دووماهی هات. هیڤیە سوبەهی بزاڤێ بکەڤە.',
    'authenticationError':
        'خەلەتی د چوونەژوورێ دا. هیڤیە ڕێکخستنێن خۆ کۆنترۆل بکە.',
    'invalidContent': 'ناڤەڕۆک یا دروست نینە. هیڤیە فۆرماتا فایلێ کۆنترۆل بکە.',
    'geminiError': 'خەلەتی ل سێرڤەرێ ژیرییا دەستکرد. هیڤیە دووبارە بزاڤێ بکە.',

    // Decoration / Misc
    'neuralSystemsAnalysis': 'شیکاریا سیستەمێن دەماری',
  };

  /// الدالة الرئيسية للحصول على النص بناءً على اللغة والمفتاح
  static String getString(String key, String languageCode) {
    switch (languageCode) {
      case 'ar':
        return arStrings[key] ?? key;
      case 'en':
        return enStrings[key] ?? key;
      case 'ck':
        return ckStrings[key] ?? key;
      case 'ck_km':
        return ckKmStrings[key] ?? key;
      default:
        return arStrings[key] ?? key;
    }
  }

  /// دالة للحصول على خريطة اللغة كاملة
  static Map<String, String> getLanguageMap(String languageCode) {
    switch (languageCode) {
      case 'ar':
        return arStrings;
      case 'en':
        return enStrings;
      case 'ck':
        return ckStrings;
      case 'ck_km':
        return ckKmStrings;
      default:
        return arStrings;
    }
  }
}
