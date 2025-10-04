import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/features/essayAI/domain/entities/essay_correction.dart';
import 'package:graduation/features/essayAI/domain/usecases/correct_essay_usecase.dart';
import 'package:graduation/features/essayAI/domain/usecases/generate_essay_questions_usecase.dart';
import 'package:graduation/features/essayAI/presentation/cubit/essay_state.dart';

class EssayCubit extends Cubit<EssayState> {
  final GenerateEssayQuestionsUseCase generateQuestionsUseCase;
  final CorrectEssayUseCase correctEssayUseCase;

  List<String> _currentQuestions = [];
  List<EssayCorrection?> _currentCorrections = [];

  EssayCubit({
    required this.generateQuestionsUseCase,
    required this.correctEssayUseCase,
  }) : super(EssayInitial());

  List<String> get currentQuestions => _currentQuestions;
  List<EssayCorrection?> get currentCorrections => _currentCorrections;

  Future<void> generateQuestions({
    required String topic,
    required int numberOfQuestions,
  }) async {
    emit(GeneratingQuestions());
    try {
      final questions = await generateQuestionsUseCase(
        topic: topic,
        numberOfQuestions: numberOfQuestions,
      );
      
      _currentQuestions = questions;
      _currentCorrections = List.filled(questions.length, null);
      
      emit(QuestionsGeneratedSuccess(questions));
    } catch (e) {
      emit(QuestionsGeneratedFailure(e.toString()));
    }
  }

  Future<void> correctAnswers({
    required List<String> questions,
    required List<String> answers,
  }) async {
    if (questions.length != answers.length) {
      emit(AnswersCorrectedFailure('عدد الأسئلة لا يتطابق مع عدد الإجابات'));
      return;
    }

    emit(CorrectingAnswers());
    try {
      List<EssayCorrection?> corrections = [];
      
      for (int i = 0; i < questions.length; i++) {
        if (answers[i].trim().isEmpty) {
          corrections.add(null);
          continue;
        }
        
        final correction = await correctEssayUseCase(
          question: questions[i],
          answer: answers[i],
        );
        corrections.add(correction as EssayCorrection?);
      }
      
      _currentCorrections = corrections;
      emit(AnswersCorrectedSuccess(corrections));
    } catch (e) {
      emit(AnswersCorrectedFailure(e.toString()));
    }
  }

  void reset() {
    _currentQuestions = [];
    _currentCorrections = [];
    emit(EssayInitial());
  }
}
