import 'package:flutter/material.dart';
import 'package:graduation/core/common/animations/animate_do.dart';
import 'package:graduation/core/routes/app_routes.dart';
import 'package:graduation/features/auth/presentation/views/widgets/have_auth.dart';
import 'package:graduation/core/language/lang_keys.dart';
import 'package:graduation/core/extensions/context_extension.dart';

class DontHaveAnAccount extends StatelessWidget {
  const DontHaveAnAccount({super.key, this.onPressed});
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return CustomFadeInUp(
      duration: 800,
      child: HaveAuth(
        text: context.translate(LangKeys.dontHaveAccount),
        onPressed: () {
          context.pushName(AppRoutes.signUp);
        },
      ),
    );
  }
}
