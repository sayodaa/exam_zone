
import 'package:graduation/features/essayAI/domain/entities/essay_correction.dart';
import 'package:graduation/features/essayAI/domain/repositories/essay_repository.dart';

class CorrectEssayUseCase {
  final EssayRepository repository;

  CorrectEssayUseCase(this.repository);

  Future<EssayCorrection> call({
    required String answer,
    required String question,
  }) async {

    return await repository.correctEssay(
      answer: answer,
      question: question,
    );
  }
}
