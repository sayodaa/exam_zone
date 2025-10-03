import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/core/services/singelton.dart';
import 'package:graduation/features/auth/domain/repos/auth_repos.dart';
import 'package:graduation/features/auth/presentation/managers/signin_cubit/signin_cubit.dart';
import 'package:graduation/features/auth/presentation/views/widgets/signin_view_body_bloc_consumer.dart';

class SigninView extends StatelessWidget {
  const SigninView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (context) => SigninCubit(getIt.get<AuthRepo>()),

          child: const SigninViewBodyBlocConsumer(),
        ),
      ),
    );
  }
}
