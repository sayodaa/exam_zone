import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/core/common/widgets/custom_app_bar.dart';
import 'package:graduation/core/extensions/context_extension.dart';
import 'package:graduation/core/language/lang_keys.dart';
import 'package:graduation/core/styles/styles.dart';
import 'package:graduation/features/auth/presentation/views/widgets/dont_have_an_account.dart';
import 'package:graduation/features/auth/presentation/views/widgets/signin_form.dart';
import 'package:graduation/features/auth/presentation/views/widgets/signin_section_title.dart';
import 'package:graduation/features/auth/presentation/views/widgets/social%20auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/features/auth/presentation/managers/signin_cubit/signin_cubit.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppColorsStyles.defaultPadding.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: AppColorsStyles.defaultPadding.h * 3.75),
            CustomAppBar(text: context.translate(LangKeys.appName)),
            SizedBox(height: AppColorsStyles.defaultPadding.h * 2.5),
            SectionTitle(text: context.translate(LangKeys.welcomeBack)),
            SizedBox(height: AppColorsStyles.defaultPadding.h * 1.875),
            LoginForm(
              onSubmit: ({required String email, required String password}) {
                context.read<SigninCubit>().signin(email, password);
              },
            ),
            SizedBox(height: AppColorsStyles.defaultPadding.h * 1.25),
            SocialAuthSection(
              onGoogle: () {
                context.read<SigninCubit>().signinWithGoogle();
              },
            ),
            SizedBox(height: AppColorsStyles.defaultPadding.h),
            const DontHaveAnAccount(),
            SizedBox(height: AppColorsStyles.defaultPadding.h * 1.25),
          ],
        ),
      ),
    );
  }
}
