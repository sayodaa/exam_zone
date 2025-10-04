import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/constantes.dart';
import 'package:graduation/core/common/widgets/text_app.dart';
// ...existing code...
import 'package:graduation/core/extensions/context_extension.dart';
import 'package:graduation/core/language/lang_keys.dart';
import 'package:graduation/core/styles/app_text_styles.dart';
import 'package:graduation/features/generate_choise/presentation/cubit/generate_cubit_exam.dart';
import 'package:graduation/features/generate_choise/presentation/cubit/generate_state_exam.dart';
import 'package:graduation/features/generate_choise/presentation/views/widgets/generate_exam_button.dart';
import 'package:graduation/features/generate_choise/presentation/views/widgets/input_for_generate_exam.dart';
import 'package:graduation/features/generate_choise/presentation/views/widgets/linear_progrees_indecator.dart';
import 'package:graduation/features/generate_choise/presentation/views/widgets/slider_difficalty.dart';

class GenerateExamBody extends StatelessWidget {
  const GenerateExamBody({super.key, required this.cubit, required this.state});
  final GenerateExamCubit cubit;
  final GenerateExamState state;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: cubit.formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppConstantes.defaultPadding.w,
          vertical: AppConstantes.defaultPadding.h,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InputForGenerateExam(cubit: cubit),
              SizedBox(height: 40.h),
              SliderDifficalty(),
              SliderDifficalty(),
              SizedBox(height: 30.h),
              GenerateExamButton(cubit: cubit, state: state),
              SizedBox(height: 40.h),
        if (state.isGenerating) ...[
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
  }
}
