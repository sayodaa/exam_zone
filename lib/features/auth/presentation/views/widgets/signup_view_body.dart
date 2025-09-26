import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/constantes.dart';
import 'package:graduation/core/common/widgets/custom_app_bar.dart';
import 'package:graduation/core/extensions/context_extension.dart';
import 'package:graduation/core/language/lang_keys.dart';
import 'package:graduation/features/auth/presentation/views/widgets/have_an_account.dart';
import 'package:graduation/features/auth/presentation/views/widgets/signin_section_title.dart';
import 'package:graduation/features/auth/presentation/views/widgets/signup_form.dart';

class SignupBody extends StatelessWidget {
  const SignupBody({super.key, this.onSubmit});

  final void Function({
    required String name,
    required String email,
    required String password,
  })?
  onSubmit;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppConstantes.defaultPadding.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: AppConstantes.defaultPadding.h * 3.75),
            CustomAppBar(text: context.translate(LangKeys.appName)),
            SizedBox(height: AppConstantes.defaultPadding.h * 2.5),
            SectionTitle(text: context.translate(LangKeys.welcome)),
            SizedBox(height: AppConstantes.defaultPadding.h * 1.875),
            SignupForm(onSubmit: onSubmit),
            SizedBox(height: AppConstantes.defaultPadding.h * 1.25),
            HaveAnAccount(),
            SizedBox(height: AppConstantes.defaultPadding.h * 1.25),
          ],
        ),
      ),
    );
  }
}
