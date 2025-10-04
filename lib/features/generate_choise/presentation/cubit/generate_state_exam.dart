import 'package:graduation/features/generate_choise/data/models/quation_model.dart';

/// Base state for generate exam
class GenerateExamState {
  final List<QuestionModel> questionModels;
  final String? error;
  final double difficultyValue;
  final bool isGenerating;
  final double generatingProgress;

  const GenerateExamState({
    this.questionModels = const [],
    this.error,
    this.difficultyValue = 0.0,
    this.isGenerating = false,
    this.generatingProgress = 0.0,
  });

  GenerateExamState copyWith({
    List<QuestionModel>? questionModels,
    String? error,
    double? difficultyValue,
    bool? isGenerating,
    double? generatingProgress,
  }) {
    return GenerateExamState(
      questionModels: questionModels ?? this.questionModels,
      error: error ?? this.error,
      difficultyValue: difficultyValue ?? this.difficultyValue,
      isGenerating: isGenerating ?? this.isGenerating,
      generatingProgress: generatingProgress ?? this.generatingProgress,
    );
  }
}

class GenerateExamInitial extends GenerateExamState {
  const GenerateExamInitial() : super();
}

class GeneratingExamInProgress extends GenerateExamState {
  const GeneratingExamInProgress(double progress)
      : super(isGenerating: true, generatingProgress: progress);
}

class GenerateExamSuccess extends GenerateExamState {
  const GenerateExamSuccess(List<QuestionModel> questions)
      : super(questionModels: questions, isGenerating: false, generatingProgress: 0.0);
}

class GenerateExamFailure extends GenerateExamState {
  const GenerateExamFailure(String error)
      : super(error: error, isGenerating: false, generatingProgress: 0.0);
}
