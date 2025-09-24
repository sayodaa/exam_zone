import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/core/enums/generate_choise_state_enum.dart';
import 'package:graduation/features/generate_choise/domain/repo/exam_choise_repo.dart';
import 'package:graduation/features/generate_choise/presentation/cubit/generate_state_exam.dart';

class GenerateExamCubit extends Cubit<GenerateExamState> {
  GenerateExamCubit(this.examChoiseRepo)
    : super(GenerateExamState(stateEnum: GenerateChoiseStateEnum.initial));
  final formKey = GlobalKey<FormState>();
  final subjectController = TextEditingController();
  final questionsController = TextEditingController();
  final ExamChoiseRepo examChoiseRepo;

  Future<void> generateExam({
    required String subject,
    required int numberOfQuestions,
  }) async {
    emit(
      state.copyWith(stateEnum: GenerateChoiseStateEnum.generatingInProgress),
    );

    final result = await examChoiseRepo.generateQuiz(
      numQuestions: numberOfQuestions,
      subject: subject,
      difficulty: state.difficultyValue ?? 0.5,
    );

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            stateEnum: GenerateChoiseStateEnum.failure,
            error: failure.toString(),
          ),
        );
      },
      (questionModels) {
        emit(
          state.copyWith(
            questionModels: questionModels,
            stateEnum: GenerateChoiseStateEnum.success,
          ),
        );
      },
    );
  }
}
