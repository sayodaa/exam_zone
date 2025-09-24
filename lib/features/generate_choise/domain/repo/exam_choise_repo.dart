import 'package:dartz/dartz.dart';
import 'package:graduation/core/errors/failures.dart';
import 'package:graduation/features/generate_choise/data/models/quation_model.dart';

abstract class ExamChoiseRepo {

  Future<Either<Failure , List<QuestionModel>>>generateQuiz({
    required int numQuestions,
    required String subject,
    required double difficulty,
  });
}
