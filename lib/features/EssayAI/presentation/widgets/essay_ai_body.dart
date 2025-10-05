import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/core/extensions/context_extension.dart';
import 'package:graduation/core/language/lang_keys.dart';
import 'package:graduation/features/essayAI/presentation/cubit/essay_cubit.dart';
import 'package:graduation/features/essayAI/presentation/cubit/essay_state.dart';
import 'package:graduation/features/generate_choise/presentation/views/widgets/linear_progrees_indecator.dart';
import 'package:graduation/features/overwall/presentation/widgets/custom_app_bar_for_exams.dart';
import 'package:graduation/features/essayAI/presentation/widgets/essay_input_section.dart';
import 'package:graduation/features/essayAI/presentation/widgets/questions_list_section.dart';
import 'package:graduation/features/essayAI/presentation/widgets/corrections_list_section.dart';

class EssayAiBody extends StatefulWidget {
  const EssayAiBody({super.key});

  @override
  State<EssayAiBody> createState() => _EssayAiBodyState();
}

class _EssayAiBodyState extends State<EssayAiBody> {
  final _formKey = GlobalKey<FormState>();
  final _topicController = TextEditingController();
  final _questionsController = TextEditingController();
  List<TextEditingController> _answerControllers = [];

  @override
  void dispose() {
    _topicController.dispose();
    _questionsController.dispose();
    for (var controller in _answerControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarForExams(
        text: context.translate(LangKeys.essay),
        icon: Icons.close,
        onPressed: () => Navigator.pop(context),
      ),
      body: BlocConsumer<EssayCubit, EssayState>(
        listener: _handleStateChanges,
        builder: (context, state) {
          return Column(
            children: [
              // Progress Indicator
              if (state is GeneratingQuestions || state is CorrectingAnswers)
                const LinearProgressIndicatorForGenerateExam(),
              
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 16.h,
                  ),
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // قسم الإدخال
                          EssayInputSection(
                            formKey: _formKey,
                            topicController: _topicController,
                            questionsController: _questionsController,
                            isGenerating: state is GeneratingQuestions,
                            onGeneratePressed: () => _generateQuestions(context),
                          ),

                          // قسم الأسئلة
                          if (state is QuestionsGeneratedSuccess ||
                              state is CorrectingAnswers ||
                              state is AnswersCorrectedSuccess)
                            QuestionsListSection(
                              questions: context.read<EssayCubit>().currentQuestions,
                              answerControllers: _answerControllers,
                              isCorrecting: state is CorrectingAnswers,
                              onCorrectPressed: () => _correctAnswers(context),
                            ),

                          // قسم نتائج التصحيح
                          if (state is AnswersCorrectedSuccess)
                            CorrectionsListSection(
                              corrections: state.corrections,
                              questions: context.read<EssayCubit>().currentQuestions,
                            ),

                          SizedBox(height: 24.h),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _handleStateChanges(BuildContext context, EssayState state) {
    if (state is QuestionsGeneratedSuccess) {
      setState(() {
        _answerControllers = List.generate(
          state.questions.length,
          (_) => TextEditingController(),
        );
      });
    } else if (state is QuestionsGeneratedFailure) {
      _showErrorSnackBar(context, state.error);
    } else if (state is AnswersCorrectedFailure) {
      _showErrorSnackBar(context, state.error);
    }
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _generateQuestions(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final topic = _topicController.text.trim();
      final numberOfQuestions = int.parse(_questionsController.text.trim());

      context.read<EssayCubit>().generateQuestions(
            topic: topic,
            numberOfQuestions: numberOfQuestions,
          );
    }
  }

  void _correctAnswers(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final questions = context.read<EssayCubit>().currentQuestions;
      final answers =
          _answerControllers.map((controller) => controller.text.trim()).toList();

      context.read<EssayCubit>().correctAnswers(
            questions: questions,
            answers: answers,
          );
    }
  }
}
