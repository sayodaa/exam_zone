import 'package:graduation/features/essayAI/domain/repositories/essay_repository.dart';

class GenerateEssayQuestionsUseCase {
  final EssayRepository repository;

  GenerateEssayQuestionsUseCase(this.repository);

  Future<List<String>> call({
    required String topic,
    required int numberOfQuestions,
  }) async {
    if (topic.trim().isEmpty) {
      throw Exception('الموضوع لا يمكن أن يكون فارغاً');
    }
    if (numberOfQuestions <= 0) {
      throw Exception('عدد الأسئلة يجب أن يكون أكبر من صفر');
    }

    return await repository.generateEssayQuestions(
      topic: topic,
      numberOfQuestions: numberOfQuestions,
    );
  }
}
