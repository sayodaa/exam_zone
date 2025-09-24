import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/core/extensions/context_extension.dart';
import 'package:graduation/core/language/app_localizations.dart';
import 'package:graduation/core/language/lang_keys.dart';
import 'package:graduation/features/generate_choise/presentation/cubit/generate_cubit_exam.dart';
import 'package:graduation/features/overwall/presentation/widgets/input_field.dart';
class InputForGenerateExam extends StatelessWidget {
  const InputForGenerateExam({super.key, required this.cubit});
  final GenerateExamCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BuildInputField(
                    label: (context).translate(LangKeys.selectSubject),
                    controller: cubit.subjectController,
                    validator: (value) => value!.isEmpty
                        ? (context).translate(
                            LangKeys.enterExamTitle,
                          ) // Reused for simplicity
                        : null,
                  ),
                  SizedBox(height: 20.h),
                  BuildInputField(
                    label: AppLocalizations.of(
                      context,
                    )!.translate(LangKeys.numberOfQuestions),
                    controller: cubit.questionsController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return (context).translate(LangKeys.numberOfQuestions);
                      }
                      if (int.tryParse(value) == null ||
                          int.parse(value) <= 0) {
                        return (context).translate(
                          LangKeys.enterDuration,
                        ); // Reused for simplicity
                      }
                      return null;
                    },
                  ),
      ],
    );
  }
}
