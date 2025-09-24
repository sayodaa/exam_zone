import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/core/enums/generate_choise_state_enum.dart';
import 'package:graduation/features/generate_choise/data/services/generate_quations_servise.dart';
import 'package:graduation/features/generate_choise/presentation/cubit/generate_state_exam.dart';

class GenerateExamCubit extends Cubit<GenerateExamState> {
  GenerateExamCubit()
    : super(GenerateExamState(stateEnum: GenerateChoiseStateEnum.initial));
  final formKey = GlobalKey<FormState>();
  final subjectController = TextEditingController();
  final questionsController = TextEditingController();

  Future<void> generateExam({
    required String subject,
    required int numberOfQuestions,
  }) async {
    emit(
      state.copyWith(stateEnum: GenerateChoiseStateEnum.generatingInProgress),
    );
    try {

      final questionModels = await generateQuiz(
        numQuestions: numberOfQuestions,
        subject: subject,
        difficulty: state.difficultyValue ?? 0.5,
      );

      emit(state.copyWith(stateEnum: GenerateChoiseStateEnum.success));

      emit(
        state.copyWith(
          questionModels: questionModels,
          stateEnum: GenerateChoiseStateEnum.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          stateEnum: GenerateChoiseStateEnum.failure,
          error: e.toString(),
        ),
      );
    }
  }
}
