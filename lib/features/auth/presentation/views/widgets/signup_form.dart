import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/core/extensions/context_extension.dart';
import 'package:graduation/core/language/lang_keys.dart';
import 'package:graduation/core/styles/styles.dart';
import 'package:graduation/features/auth/presentation/views/widgets/auth_button.dart';
import 'package:graduation/features/auth/presentation/views/widgets/confirm_password_feild.dart';
import 'package:graduation/features/auth/presentation/views/widgets/email_feild.dart';
import 'package:graduation/features/auth/presentation/views/widgets/name_feild.dart';
import 'package:graduation/features/auth/presentation/views/widgets/password_feild.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key, this.onSubmit});

  final void Function({
    required String name,
    required String email,
    required String password,
  })?
  onSubmit;

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      widget.onSubmit?.call(
        name: _nameCtrl.text.trim(),
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
          NameField(controller: _nameCtrl),
          SizedBox(height: AppColorsStyles.defaultPadding.h),
          EmailField(controller: _emailCtrl),
          SizedBox(height: AppColorsStyles.defaultPadding.h),
          PasswordField(controller: _passwordCtrl),
          SizedBox(height: AppColorsStyles.defaultPadding.h),
          ConfirmPasswordField(
            controller: _confirmCtrl,
            passwordController: _passwordCtrl,
          ),
          SizedBox(height: AppColorsStyles.defaultPadding.h * 1.25),
          AuthButton(
            text: context.translate(LangKeys.signUp),
            onPressed: _submit,
          ),
        ],
      ),
    );
  }
}
