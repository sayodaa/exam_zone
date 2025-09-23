import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/core/extensions/context_extension.dart';
import 'package:graduation/core/language/lang_keys.dart';
import 'package:graduation/core/styles/styles.dart';
import 'package:graduation/features/auth/presentation/views/widgets/auth_button.dart';
import 'package:graduation/features/auth/presentation/views/widgets/email_feild.dart';
import 'package:graduation/features/auth/presentation/views/widgets/forget_password.dart';
import 'package:graduation/features/auth/presentation/views/widgets/password_feild.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key, this.onSubmit});
  final void Function({required String email, required String password})?
  onSubmit;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      widget.onSubmit?.call(
        email: _emailCtrl.text.trim(),
        password: _passwordCtrl.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          EmailField(controller: _emailCtrl),
          SizedBox(height: AppColorsStyles.defaultPadding.h),
          PasswordField(controller: _passwordCtrl),
          SizedBox(height: AppColorsStyles.defaultPadding.h * 0.625),
          Align(
            alignment: Alignment.centerRight,
            child: ForgotPasswordButton(
              onPressed: () {},
              label: context.translate(LangKeys.forgotPassword),
            ),
          ),
          SizedBox(height: AppColorsStyles.defaultPadding.h * 0.625),
          AuthButton(
            text: context.translate(LangKeys.login),
            onPressed: _submit,
          ),
        ],
      ),
    );
  }
}
