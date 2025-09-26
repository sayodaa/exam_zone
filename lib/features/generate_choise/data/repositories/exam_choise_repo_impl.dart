import 'package:dartz/dartz.dart';
import 'package:graduation/core/errors/failures.dart';
import 'package:graduation/features/generate_choise/data/models/quation_model.dart';
import 'package:graduation/core/services/generated_choises_services/generate_choise_quations_servise.dart';
import 'package:graduation/features/generate_choise/domain/repo/exam_choise_repo.dart';

class ExamChoiseRepoImpl extends ExamChoiseRepo {
  final RemoteDataSourseExamGenerateChoises remoteDataSourseExamGenerateChoises;

  ExamChoiseRepoImpl({required this.remoteDataSourseExamGenerateChoises});

  @override
  Future<Either<Failure, List<QuestionModel>>> generateQuiz({
    required int numQuestions,
    required String subject,
    required double difficulty,
  }) async {
    try {
      final result = await remoteDataSourseExamGenerateChoises.generateQuiz(
        numQuestions: numQuestions,
        subject: subject,
        difficulty: difficulty,
      );
      return Right(result);
    } catch (e) {
      return left(ServerFailure('Failed to generate quiz: ${e.toString()}'));
    }
  }
}
