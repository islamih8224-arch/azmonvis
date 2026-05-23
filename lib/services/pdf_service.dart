import 'package:file_picker/file_picker.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class PdfServiceCrossPlatform {
  Future<({String? text, String? error})> pickAndExtractText() async {
    try {
      // 1. اختيار الملف
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
        withData: true, // إجباري للويب
      );

      if (result != null && result.files.single.bytes != null) {
        var fileBytes = result.files.single.bytes!;

        // 2. تحميل المستند
        final PdfDocument document = PdfDocument(inputBytes: fileBytes);
        StringBuffer fullText = StringBuffer();

        // 3. إنشاء المستخرج
        final PdfTextExtractor extractor = PdfTextExtractor(document);

        // 4. استخراج النص صفحة صفحة لتفادي الـ FormatException في الويب
        for (int i = 0; i < document.pages.count; i++) {
          try {
            // استخراج نص الصفحة الحالية (الفهرس يبدأ من 0)
            String pageText = extractor.extractText(
              startPageIndex: i,
              endPageIndex: i,
            );
            fullText.write(pageText);
          } catch (pageError) {
            // إذا حدث خطأ في صفحة بسبب ترميز جافا سكريبت، نطبع تحذير ونكمل الباقي
            print(
              "تنبيه: تعذر قراءة الصفحة رقم ${i + 1} بسبب مشكلة ترميز الحروف.",
            );
            continue;
          }
        }

        // 5. إغلاق المستند
        document.dispose();

        return (text: fullText.toString(), error: null);
      }

      return (text: null, error: null); // تم الإلغاء
    } catch (e, stackTrace) {
      print("خطأ رئيسي أثناء استخراج النص: $e");
      print("تفاصيل الخطأ: $stackTrace");
      return (text: null, error: 'حدث خطأ غير متوقع أثناء معالجة الملف.');
    }
  }
}
/*

import 'package:file_picker/file_picker.dart';
import 'package:read_pdf_text/read_pdf_text.dart';

class PdfServiceCrossPlatform {
  Future<({String? text, String? error})> pickAndExtractText() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
        withData: false,
      );

      if (result != null && result.files.single.path != null) {
        String filePath = result.files.single.path!;

        // استخراج النص مباشرة من مسار الملف
        String text = await ReadPdfText.getPDFtext(filePath);

        return (text: text, error: null);
      }

      return (text: null, error: null); // تم الإلغاء
    } catch (e) {
      print("خطأ أثناء قراءة الـ PDF: $e");
      return (text: null, error: 'حدث خطأ أثناء قراءة الملف: $e');
    }
  }
}

*/