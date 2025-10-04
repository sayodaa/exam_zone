import 'package:graduation/features/essayAI/domain/entities/essay_correction.dart';

class EssayCorrectionModel extends EssayCorrection {
  const EssayCorrectionModel({
    required super.score,
    required super.mistakes,
    required super.feedback,
  });

  factory EssayCorrectionModel.fromRawText(String raw) {
    // Normalize line endings to simplify regexes
    final normalized = raw.replaceAll('\r\n', '\n').replaceAll('\r', '\n');

    final scoreReg = RegExp(
      r'(?:Score|الدرجة)\s*[:\-]?\s*(\d{1,2})(?:\s*/\s*\d{1,2})?',
      caseSensitive: false,
    );

    // capture mistakes until next known section label or end
    final mistakesReg = RegExp(
      r'(?:Mistakes|Errors|Issues|الأخطاء)\s*[:\-]?\s*(.*?)(?=\n(?:(?:Feedback|Comment|Advice|الملاحظات)|$))',
      dotAll: true,
      caseSensitive: false,
    );

    final feedbackReg = RegExp(
      r'(?:Feedback|Comment|Advice|الملاحظات)\s*[:\-]?\s*(.*)',
      dotAll: true,
      caseSensitive: false,
    );

    final scoreMatch = scoreReg.firstMatch(normalized);
    final mistakesMatch = mistakesReg.firstMatch(normalized);
    final feedbackMatch = feedbackReg.firstMatch(normalized);

    // Fallback: if score not found, try to find X/10 pattern or any integer 0-10
    int score = 0;
    if (scoreMatch != null) {
      score = int.tryParse(scoreMatch.group(1) ?? '0') ?? 0;
    } else {
      final slashMatch = RegExp(r'\b(\d{1,2})\s*/\s*10\b').firstMatch(normalized);
      if (slashMatch != null) {
        score = int.tryParse(slashMatch.group(1) ?? '0') ?? 0;
      } else {
        final anyNum = RegExp(r'\b([0-9]|10)\b');
        final anyMatch = anyNum.firstMatch(normalized);
        if (anyMatch != null) {
          score = int.tryParse(anyMatch.group(1) ?? '0') ?? 0;
        }
      }
    }

    // Cap score between 0 and 10
    if (score < 0) score = 0;
    if (score > 10) score = 10;

    String mistakes = mistakesMatch?.group(1)?.trim() ?? '';
    String feedback = feedbackMatch?.group(1)?.trim() ?? '';

    // Normalize common empty / none responses
    if (mistakes.isEmpty || mistakes.toLowerCase().contains('no') || mistakes.contains('لا')) {
      mistakes = 'لا توجد أخطاء';
    }
    if (feedback.isEmpty) {
      feedback = 'لا توجد ملاحظات';
    }

    // Debug: print normalized raw response to help troubleshooting parsing issues
    // You can remove this print in production if desired
    // ignore: avoid_print
    print('EssayCorrectionModel.fromRawText normalized:\n$normalized\n---- parsed score: $score');

    return EssayCorrectionModel(
      score: score,
      mistakes: mistakes,
      feedback: feedback,
    );
  }

  // ✅ إضافة method للتحويل إلى Entity
  EssayCorrection toEntity() {
    return EssayCorrection(
      score: score,
      mistakes: mistakes,
      feedback: feedback,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'score': score,
      'mistakes': mistakes,
      'feedback': feedback,
    };
  }

  factory EssayCorrectionModel.fromJson(Map<String, dynamic> json) {
    return EssayCorrectionModel(
      score: json['score'] ?? 0,
      mistakes: json['mistakes'] ?? '',
      feedback: json['feedback'] ?? '',
    );
  }
}
