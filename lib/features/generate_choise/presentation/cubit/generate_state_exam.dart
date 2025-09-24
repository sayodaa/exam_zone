import 'package:graduation/core/enums/generate_choise_state_enum.dart';
import 'package:graduation/features/generate_choise/data/models/quation_model.dart';

class GenerateExamState {
  List<QuestionModel> questionModels;
  String? error;
  double? difficultyValue;
  GenerateChoiseStateEnum? stateEnum;

  GenerateExamState({
    this.error,
    this.questionModels = const [],
    this.difficultyValue,
    this.stateEnum,
  });

  GenerateExamState copyWith({
    List<QuestionModel>? questionModels,
    GenerateChoiseStateEnum? stateEnum,
    double? difficultyValue,
    String? error,
  }) {
    return GenerateExamState(
      questionModels: questionModels ?? this.questionModels,
      error: error ?? this.error,
      difficultyValue: difficultyValue ?? this.difficultyValue,
      stateEnum: stateEnum ?? this.stateEnum,
    );
  }
}
