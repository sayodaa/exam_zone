import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/features/generate_choise/domain/repo/exam_choise_repo.dart';
import 'package:graduation/features/generate_choise/presentation/cubit/generate_state_exam.dart';

class GenerateExamCubit extends Cubit<GenerateExamState> {
  GenerateExamCubit(this.examChoiseRepo) : super(const GenerateExamInitial());
  final formKey = GlobalKey<FormState>();
  final subjectController = TextEditingController();
  final questionsController = TextEditingController();
  final ExamChoiseRepo examChoiseRepo;

  Future<void> generateExam({
    required String subject,
    required int numberOfQuestions,
  }) async {
    try {
      emit(const GeneratingExamInProgress(0));

      for (int i = 0; i <= 100; i += 25) {
        await Future.delayed(const Duration(milliseconds: 150));
        emit(GeneratingExamInProgress(i / 100));
      }

      final result = await examChoiseRepo.generateQuiz(
        numQuestions: numberOfQuestions,
        subject: subject,
        difficulty: state.difficultyValue,
      );

      result.fold(
        (failure) => emit(GenerateExamFailure(failure.toString())),
        (questionModels) => emit(GenerateExamSuccess(questionModels)),
      );
    } catch (e) {
      emit(GenerateExamFailure(e.toString()));
    }
  }
}
