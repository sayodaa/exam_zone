import 'dart:convert';

import 'package:graduation/features/essayAI/data/essay_model.dart';
import 'package:graduation/features/essayAI/domain/entities/essay_correction.dart';
import 'package:http/http.dart' as http;

abstract class EssayRemoteDataSource {
  Future<List<String>> generateEssayQuestions({
    required String topic,
    required int numberOfQuestions,
  });

  Future<EssayCorrection> correctEssay({
    required String question,
    required String answer,
  });
}

class EssayRemoteDataSourceImpl implements EssayRemoteDataSource {
  static const String _apiKey = 'sk-02e178544f904b9696c835285265f303';//sk-02e178544f904b9696c835285265f303
  static const String _model = "deepseek-chat";
  static final Uri _apiUrl = Uri.parse(
    "https://api.deepseek.com/v1/chat/completions",
  );

  final http.Client client;

  EssayRemoteDataSourceImpl({required this.client});

  Map<String, String> get _headers => {
    "Content-Type": "application/json",
    "Accept": "application/json",
    "Authorization": "Bearer $_apiKey",
  };

  @override
  Future<List<String>> generateEssayQuestions({
    required String topic,
    required int numberOfQuestions,
  }) async {
    final prompt =
        '''
أنشئ $numberOfQuestions أسئلة مقالية عن "$topic".
يجب أن تكون الأسئلة:
أسئلة سهلة و اجابتها مختصرة

أرجع الأسئلة فقط في قائمة مرقمة بدون أي شرح إضافي.
مثال:
1. السؤال الأول
2. السؤال الثاني
''';

    final result = await _callAI(prompt);

    final questions = result
        .split(RegExp(r'\n+'))
        .map((e) => e.replaceAll(RegExp(r'^\d+[\.\)]\s*'), '').trim())
        .where((q) => q.isNotEmpty && q.length > 10)
        .toList();

    if (questions.isEmpty) {
      throw Exception('فشل في توليد الأسئلة');
    }
    print(questions);
    return questions;
  }

  @override
  Future<EssayCorrection> correctEssay({
    required String question,
    required String answer,
  }) async {
    final prompt =
        '''
أنت مدرس محترف. صحح إجابة الطالب التالية بناءً على السؤال المقالي.

السؤال: $question

إجابة الطالب:
$answer

قدم تقييماً شاملاً يتضمن:
1. الدرجة: من 10
2. الأخطاء: (قواعد، إملاء، محتوى)
3. الملاحظات: ملاحظات بناءة ومفصلة

قم بتنسيق الرد بالضبط كالتالي:
الدرجة: X
الأخطاء: [اذكر الأخطاء أو اكتب "لا توجد أخطاء"]
الملاحظات: [ملاحظاتك التفصيلية]
''';

    final result = await _callAI(prompt);

    // ✅ الحل: تحويل Model إلى Entity قبل الإرجاع
    final model = EssayCorrectionModel.fromRawText(result);
    return EssayCorrection(
      mistakes: model.mistakes,
      score: model.score,
      feedback: model.feedback,
    );
  }

  Future<String> _callAI(String prompt) async {
    try {
      final body = jsonEncode({
        "model": _model,
        "messages": [
          {"role": "user", "content": prompt.trim()},
        ],
        "temperature": 0.7,
        "max_tokens": 2000,
      });

      final response = await client
          .post(_apiUrl, headers: _headers, body: body)
          .timeout(
            const Duration(seconds: 30),
            onTimeout: () {
              throw Exception('انتهت مهلة الاتصال بالخادم');
            },
          );

      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        final content = data['choices']?[0]?['message']?['content'];

        if (content == null || content.toString().trim().isEmpty) {
          throw Exception('استجابة فارغة من الخادم');
        }

        return content.toString().trim();
      } else {
        final errorBody = utf8.decode(response.bodyBytes);
        throw Exception(
          "API Error: ${response.statusCode} - ${response.reasonPhrase}\n$errorBody",
        );
      }
    } catch (e) {
      throw Exception("خطأ في الاتصال بالـ API: $e");
    }
  }
}
