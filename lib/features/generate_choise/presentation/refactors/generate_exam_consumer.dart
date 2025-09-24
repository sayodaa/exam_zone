import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/core/common/toast/show_toast.dart';
import 'package:graduation/core/enums/generate_choise_state_enum.dart';
import 'package:graduation/core/routes/app_routes.dart';
import 'package:graduation/features/generate_choise/presentation/cubit/generate_cubit_exam.dart';
import 'package:graduation/features/generate_choise/presentation/cubit/generate_state_exam.dart';
import 'package:graduation/features/generate_choise/presentation/refactors/generate_exam_body.dart';

class GenerateExamConsumer extends StatelessWidget {
  const GenerateExamConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    final GenerateExamCubit cubit = context.watch<GenerateExamCubit>();
    return BlocConsumer<GenerateExamCubit, GenerateExamState>(
      listener: (context, state) {
        if (state.stateEnum == GenerateChoiseStateEnum.success) {
          _successState(cubit, context, state);
        } else if (state.stateEnum == GenerateChoiseStateEnum.failure) {
          ShowToast.showToastErrorTop(message: state.error!);
        }
      },
      builder: (BuildContext context, state) {
        return GenerateExamBody(cubit: cubit, state: state,);
      },
    );
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
