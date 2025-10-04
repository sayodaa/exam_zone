import 'package:graduation/features/essayAI/domain/entities/essay_correction.dart';

abstract class EssayState {}

class EssayInitial extends EssayState {}

// حالات توليد الأسئلة
class GeneratingQuestions extends EssayState {}

class QuestionsGeneratedSuccess extends EssayState {
  final List<String> questions;
  QuestionsGeneratedSuccess(this.questions);
}

class QuestionsGeneratedFailure extends EssayState {
  final String error;
  QuestionsGeneratedFailure(this.error);
}

// حالات تصحيح الإجابات
class CorrectingAnswers extends EssayState {}

class AnswersCorrectedSuccess extends EssayState {
  final List<EssayCorrection?> corrections;
  AnswersCorrectedSuccess(this.corrections);
}

class AnswersCorrectedFailure extends EssayState {
  final String error;
  AnswersCorrectedFailure(this.error);
}
