import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/core/common/widgets/custom_app_bar.dart';
import 'package:graduation/core/extensions/context_extension.dart';
import 'package:graduation/core/language/lang_keys.dart';
import 'package:graduation/core/styles/styles.dart';
import 'package:graduation/features/auth/presentation/views/widgets/have_an_account.dart';
import 'package:graduation/features/auth/presentation/views/widgets/signin_section_title.dart';
import 'package:graduation/features/auth/presentation/views/widgets/signup_form.dart';

class SignupBody extends StatelessWidget {
  const SignupBody({super.key});

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
            SectionTitle(text: context.translate(LangKeys.welcome)),
            SizedBox(height: AppColorsStyles.defaultPadding.h * 1.875),
            const SignupForm(),
            SizedBox(height: AppColorsStyles.defaultPadding.h * 1.25),
            SizedBox(height: AppColorsStyles.defaultPadding.h),
            HaveAnAccount(),
            SizedBox(height: AppColorsStyles.defaultPadding.h * 1.25),
          ],
        ),
      ),
    );
  }
}
