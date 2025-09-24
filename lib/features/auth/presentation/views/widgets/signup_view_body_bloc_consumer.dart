import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/core/helper_funcations/build_error_bar.dart';
import 'package:graduation/features/auth/presentation/managers/signup_cubit/signup_cubit.dart';
import 'package:graduation/features/auth/presentation/views/widgets/signup_view_body.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignupViewBodyBlocConsumer extends StatelessWidget {
  const SignupViewBodyBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, SignupState>(
      listener: (context, state) {
        if (state is SignupSuccess) {
          Navigator.pop(context);
        } else if (state is SignupFailure) {
          buildErrorBar(context, state.message);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is SignupLoading,
          child: SignupBody(
            onSubmit:
                ({
                  required String name,
                  required String email,
                  required String password,
                }) {
                  context.read<SignupCubit>().createUserWithEmailAndPassword(
                    email,
                    password,
                    name,
                  );
                },
          ),
        );
      },
    );
  }
}
