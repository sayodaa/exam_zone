import 'package:flutter/material.dart';
import 'package:graduation/core/common/widgets/text_app.dart';
import 'package:graduation/core/enums/generate_choise_state_enum.dart';
import 'package:graduation/core/extensions/context_extension.dart';
import 'package:graduation/core/language/lang_keys.dart';
import 'package:graduation/core/styles/app_text_styles.dart';
import 'package:graduation/features/generate_choise/presentation/cubit/generate_cubit_exam.dart';
import 'package:graduation/features/generate_choise/presentation/cubit/generate_state_exam.dart';

class GenerateExamButton extends StatelessWidget {
  const GenerateExamButton({
    super.key,
    required this.cubit,
    required this.state,
  });

  final GenerateExamCubit cubit;
  final GenerateExamState state;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          if (cubit.formKey.currentState!.validate()) {
            cubit.generateExam(
              numberOfQuestions: int.parse(cubit.questionsController.text),
              subject: cubit.subjectController.text,
            );
          }
        },

        style: Theme.of(context).elevatedButtonTheme.style,
        child: state.stateEnum == GenerateChoiseStateEnum.generatingInProgress
            ? SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color?>(
                    Theme.of(context).textTheme.bodyLarge!.color,
                  ),
                ),
              )
            : TextApp(
                text: (context).translate(LangKeys.generateExam),
                style: AppTextStyles.body16(
                  context,
                ).copyWith(fontWeight: FontWeight.bold),
              ),
      ),
    );
  }
}
