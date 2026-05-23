import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import '../main.dart';

class GeminiService {
  final String _apiKey = "AIzaSyAqUDwdgeimjpArOzIPJqDH-eFrKw8Oxp4";
  // Rate Limiting - تتبع الطلبات في الدقيقة
  static const int maxRequestsPerMinute = 15; // الحد الأقصى من Google (مجاني)
  final List<DateTime> _requestTimestamps = [];

  // متغيرات Rate Limit Error
  String? _rateLimitError;
  int? _resetTime;

  // التحقق من Rate Limit قبل الطلب
  Future<bool> _checkRateLimit() async {
    final now = DateTime.now();
    final oneMinuteAgo = now.subtract(const Duration(minutes: 1));

    // حذف الطلبات القديمة
    _requestTimestamps.removeWhere((time) => time.isBefore(oneMinuteAgo));

    if (_requestTimestamps.length >= maxRequestsPerMinute) {
      _rateLimitError = 'تم تجاوز حد الطلبات المسموح به (60 طلب/دقيقة)';
      final oldestRequest = _requestTimestamps.first;
      _resetTime = oldestRequest
          .add(const Duration(minutes: 1))
          .millisecondsSinceEpoch;
      return false;
    }

    _requestTimestamps.add(now);
    _rateLimitError = null;
    _resetTime = null;
    return true;
  }

  // Getters لحالة Rate Limit
  String? get rateLimitError => _rateLimitError;
  int? get resetTime => _resetTime;
  int get remainingRequests => maxRequestsPerMinute - _requestTimestamps.length;

  Future<({List<Question>? questions, String? error})>
  generateQuestionsFromText({
    required String extractedText,
    required String language,
    required int numberOfQuestions,
    required String difficulty,
  }) async {
    try {
      // التحقق من Rate Limit المحتسب محلياً
      if (!await _checkRateLimit()) {
        return (questions: null, error: _rateLimitError);
      }
      // إعداد الموديل
      final model = GenerativeModel(
        model: 'gemini-3.1-flash-lite',
        apiKey: _apiKey,
        generationConfig: GenerationConfig(
          responseMimeType: 'application/json',
          temperature: 0.7,
          topK: 40,
          topP: 0.95,
          responseSchema: Schema.array(
            description: 'قائمة بالأسئلة',
            items: Schema.object(
              properties: {
                'questionText': Schema.string(description: 'نص السؤال'),
                'options': Schema.array(
                  items: Schema.string(),
                  description: 'أربعة خيارات',
                ),
                'correctAnswerIndex': Schema.integer(
                  description: 'رقم الإجابة الصحيحة',
                ),
              },
              requiredProperties: [
                'questionText',
                'options',
                'correctAnswerIndex',
              ],
            ),
          ),
        ),
      );

      // تنظيف النص - تقليل حجمه لتوفير التوكنات
      String cleanedText = extractedText
          .replaceAll(RegExp(r'\s+'), ' ')
          .replaceAll('\u0000', '')
          .trim();

      if (cleanedText.length > 8000) {
        cleanedText = cleanedText.substring(0, 8000);
      }

      // Prompt محسّن
      final prompt =
          '''أنت معلم خبير. استخرج من النص أدناه ($numberOfQuestions) أسئلة بمستوى ($difficulty) باللغة ($language) فقط.

النص:
$cleanedText''';

      // -------------------------------------------------------
      // إعدادات إعادة المحاولة التلقائية (Retry Mechanism)
      // -------------------------------------------------------
      int maxRetries = 3; // أقصى عدد للمحاولات عند الفشل بسبب السيرفر
      int delaySeconds = 2; // الوقت الأولي للانتظار (ثانيتين)
      GenerateContentResponse? response;

      for (int attempt = 0; attempt <= maxRetries; attempt++) {
        try {
          // محاولة إرسال الطلب
          response = await model.generateContent([Content.text(prompt)]);
          break; // إذا نجح الطلب، اخرج من حلقة التكرار فوراً
        } catch (e) {
          final errorStr = e.toString().toLowerCase();

          // نتحقق إن كان الخطأ بسبب الضغط (503) أو نفاد الكوتا (429) وهناك محاولات متبقية
          if ((errorStr.contains('503') ||
                  errorStr.contains('429') ||
                  errorStr.contains('resource_exhausted')) &&
              attempt < maxRetries) {
            debugPrint(
              "تنبيه: الخادم مشغول (أو طلبات كثيرة). إعادة المحاولة رقم ${attempt + 1} بعد $delaySeconds ثوانٍ...",
            );

            await Future.delayed(Duration(seconds: delaySeconds));
            delaySeconds *= 2; // مضاعفة وقت الانتظار أسّياً (2 -> 4 -> 8)
          } else {
            // إذا كان الخطأ شيئاً آخر (مثل خطأ 400 في الصياغة أو 401 في المفتاح)، أو انتهت المحاولات، قم برمي الخطأ للخارج
            rethrow;
          }
        }
      }
      // -------------------------------------------------------

      if (response != null && response.text != null) {
        debugPrint("--- بدء عملية التنظيف ---");

        String rawText = response.text!;
        int start = rawText.indexOf('[');
        int end = rawText.lastIndexOf(']');

        if (start != -1 && end != -1) {
          String jsonString = rawText.substring(start, end + 1);

          try {
            final List<dynamic> jsonList = jsonDecode(jsonString);

            List<Question> generatedQuestions = jsonList.map((jsonItem) {
              return Question(
                questionText: jsonItem['questionText'] ?? 'سؤال بدون نص',
                options: List<String>.from(jsonItem['options'] ?? []),
                correctAnswerIndex: jsonItem['correctAnswerIndex'] ?? 0,
              );
            }).toList();

            debugPrint("تم تحويل ${generatedQuestions.length} سؤال بنجاح!");
            return (questions: generatedQuestions, error: null);
          } catch (e) {
            debugPrint("خطأ في الـ jsonDecode: $e");
            return (questions: null, error: "فشل في معالجة بيانات الأسئلة.");
          }
        } else {
          debugPrint("لم يتم العثور على مصفوفة JSON في الرد");
          return (
            questions: null,
            error: "الرد لا يحتوي على تنسيق أسئلة صحيح.",
          );
        }
      }
      return (questions: null, error: "فشل في توليد الأسئلة. حاول مجدداً.");
    } catch (e, stack) {
      debugPrint("ERROR: $e");
      debugPrint(stack.toString());

      final errorMessage = _handleError(e);
      return (questions: null, error: errorMessage);
    }
  }

  // معالجة أخطاء API
  String _handleError(dynamic exception) {
    final errorString = exception.toString().toLowerCase();

    if (errorString.contains('429') ||
        errorString.contains('resource_exhausted') ||
        errorString.contains('rate limit') ||
        errorString.contains('quota')) {
      return 'تم استنزاف حد الطلبات المجاني. يرجى المحاولة لاحقاً.';
    } else if (errorString.contains('401') ||
        errorString.contains('unauthenticated') ||
        errorString.contains('unauthorized')) {
      return 'مشكلة في المصادقة. يرجى التحقق من الإعدادات.';
    } else if (errorString.contains('400') ||
        errorString.contains('invalid_argument') ||
        errorString.contains('bad request')) {
      return 'محتوى غير صالح. يرجى التأكد من صيغة الملف.';
    } else if (errorString.contains('500') ||
        errorString.contains(
          '503',
        ) || // تم إضافة دعم الـ 503 هنا أيضاً كخط دفاع أخير
        errorString.contains('internal server')) {
      return 'خطأ في خادم الذكاء الاصطناعي بسبب الضغط العالي. يرجى المحاولة لاحقاً.';
    }
    return 'خطأ في معالجة الطلب. يرجى المحاولة مجدداً.';
  }
}
