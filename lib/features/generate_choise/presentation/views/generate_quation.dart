import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/core/extensions/context_extension.dart';
import 'package:graduation/core/language/lang_keys.dart';
import 'package:graduation/features/generate_choise/presentation/cubit/generate_cubit_exam.dart';
import 'package:graduation/features/generate_choise/presentation/widgets/generate_exam_body.dart';
import 'package:graduation/features/overwall/presentation/widgets/custom_app_bar_for_exams.dart';

class GenerateExamScreen extends StatelessWidget {
  const GenerateExamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GenerateExamCubit(),
      child: Scaffold(
        appBar: CustomAppBarForExams(
          text: (context).translate(LangKeys.generateExam),
          icon: Icons.close,
        ),
        body: GenerateExamBody(),
      ),
    );
  }
}
