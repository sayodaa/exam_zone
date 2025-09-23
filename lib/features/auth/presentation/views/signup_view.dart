import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/core/services/firebase_auth_service.dart';
import 'package:graduation/features/auth/data/repos/auth_repo_impl.dart';
import 'package:graduation/features/auth/presentation/managers/signup_cubit/signup_cubit.dart';
import 'package:graduation/features/auth/presentation/views/widgets/signup_view_body_bloc_consumer.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (context) => SignupCubit(
            AuthRepoImpl(firebaseAuthService: FirebaseAuthService()),
          ),
          child: const SignupViewBodyBlocConsumer(),
        ),
      ),
    );
  }
}
