import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/core/services/service_locator.dart';
import 'package:graduation/features/essayAI/presentation/cubit/essay_cubit.dart';
import 'package:graduation/features/essayAI/presentation/widgets/essay_ai_body.dart';

class EssayAiView extends StatelessWidget {
  const EssayAiView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<EssayCubit>(),
      child: Builder(
        builder: (context) => const EssayAiBody(),
      ),
    );
  }
}
