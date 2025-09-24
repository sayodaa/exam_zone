import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/core/common/toast/show_toast.dart';
import 'package:graduation/core/common/widgets/text_app.dart';
import 'package:graduation/core/enums/generate_choise_state_enum.dart';
import 'package:graduation/core/extensions/context_extension.dart';
import 'package:graduation/core/language/lang_keys.dart';
import 'package:graduation/core/routes/app_routes.dart';
import 'package:graduation/core/styles/app_text_styles.dart';
import 'package:graduation/core/styles/styles.dart';
import 'package:graduation/features/generate_choise/presentation/cubit/generate_cubit_exam.dart';
import 'package:graduation/features/generate_choise/presentation/cubit/generate_state_exam.dart';
import 'package:graduation/features/generate_choise/presentation/widgets/generate_exam_button.dart';
import 'package:graduation/features/generate_choise/presentation/widgets/input_for_generate_exam.dart';
import 'package:graduation/features/generate_choise/presentation/widgets/linear_progrees_indecator.dart';
import 'package:graduation/features/generate_choise/presentation/widgets/slider_difficalty.dart';

class GenerateExamBody extends StatelessWidget {
  const GenerateExamBody({super.key});

  @override
  Widget build(BuildContext context) {
    final GenerateExamCubit cubit = context.watch<GenerateExamCubit>();
    return BlocConsumer<GenerateExamCubit, GenerateExamState>(
      listener: (context, state) {
        if (state.stateEnum == GenerateChoiseStateEnum.success) {
          _successState(cubit, context, state);
        } else if (state.stateEnum == GenerateChoiseStateEnum.failure) {
          _failureState(cubit, state);
        }
      },
      builder: (BuildContext context, state) {
        return Form(
          key: cubit.formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppColorsStyles.defaultPadding.w,
              vertical: AppColorsStyles.defaultPadding.h,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InputForGenerateExam(cubit: cubit),
                  SizedBox(height: 40.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextApp(
                        text: context.translate(LangKeys.difficultyLevel),
                        style: AppTextStyles.medium16(context),
                      ),
                      TextApp(
                        text: difficultyLabel(context) ?? '',
                        style: AppTextStyles.semiBold16(context),
                      ),
                    ],
                  ),
                  SliderDifficalty(),
                  SizedBox(height: 30.h),
                  GenerateExamButton(cubit: cubit, state: state),
                  SizedBox(height: 40.h),
                  if (state.stateEnum ==
                      GenerateChoiseStateEnum.generatingInProgress) ...[
                    TextApp(
                      text: (context).translate(LangKeys.generatingExam),
                      style: AppTextStyles.body14(context),
                    ),
                    SizedBox(height: 8.h),
                    LinearProgressIndicatorForGenerateExam(),
                    SizedBox(height: 8.h),
                    TextApp(
                      text: (context).translate(LangKeys.mayTakeSeconds),
                      style: AppTextStyles.caption12(context),
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _failureState(GenerateExamCubit cubit, GenerateExamState state) {
    ShowToast.showToastErrorTop(message: state.error!);
  }

  void _successState(
    GenerateExamCubit cubit,
    BuildContext context,
    GenerateExamState state,
  ) {
    cubit.subjectController.clear();
    cubit.questionsController.clear();
    Navigator.pushReplacementNamed(
      context,
      AppRoutes.examScreen,
      arguments: state.questionModels,
    );
  }
}
