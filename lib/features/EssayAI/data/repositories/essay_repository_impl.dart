import 'package:graduation/features/essayAI/data/datasources/essay_remote_datasource.dart' show EssayRemoteDataSource;
import 'package:graduation/features/essayAI/domain/repositories/essay_repository.dart';
import 'package:graduation/features/essayAI/domain/entities/essay_correction.dart';

class EssayRepositoryImpl implements EssayRepository {
  final EssayRemoteDataSource remoteDataSource;

  EssayRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<String>> generateEssayQuestions({
    required String topic,
    required int numberOfQuestions,
  }) async {
    try {
      return await remoteDataSource.generateEssayQuestions(
        topic: topic,
        numberOfQuestions: numberOfQuestions,
      );
    } catch (e) {
      throw Exception('فشل في توليد الأسئلة: $e');
    }
  }

  @override
  Future<EssayCorrection> correctEssay({
    required String question,
    required String answer,
  }) async {
    try {
      return await remoteDataSource.correctEssay(
        question: question,
        answer: answer,
      );
    } catch (e) {
      throw Exception('فشل في تصحيح الإجابة: $e');
    }
  }
}
