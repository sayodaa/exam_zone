import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/core/services/service_locator.dart';
import 'package:graduation/features/auth/domain/repos/auth_repos.dart';
import 'package:graduation/features/auth/presentation/managers/signup_cubit/signup_cubit.dart';
import 'package:graduation/features/auth/presentation/views/widgets/signup_view_body_bloc_consumer.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (context) => SignupCubit(sl<AuthRepo>()),

          child: const SignupViewBodyBlocConsumer(),
        ),
      ),
    );
  }
}
