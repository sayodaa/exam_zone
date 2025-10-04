import 'package:graduation/features/essayAI/domain/entities/essay_correction.dart';

abstract class EssayRepository {
  Future<List<String>> generateEssayQuestions({
    required String topic,
    required int numberOfQuestions,
  });

  Future<EssayCorrection> correctEssay({
    required String question,
    required String answer,
  });
}
