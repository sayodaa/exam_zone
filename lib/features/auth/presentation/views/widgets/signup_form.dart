import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/constantes.dart';
import 'package:graduation/core/extensions/context_extension.dart';
import 'package:graduation/core/language/lang_keys.dart';
import 'package:graduation/features/auth/presentation/views/widgets/auth_button.dart';
import 'package:graduation/features/auth/presentation/views/widgets/confirm_password_feild.dart';
import 'package:graduation/features/auth/presentation/views/widgets/custom_text_form_feild.dart';
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
          CustomTextFormFeild(
            controller: _nameCtrl,
            labelText: context.translate(LangKeys.name),
            keyboardType: TextInputType.name,
          ),
          SizedBox(height: AppConstantes.defaultPadding.h),
          CustomTextFormFeild(
            controller: _emailCtrl,
            labelText: context.translate(LangKeys.email),
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: AppConstantes.defaultPadding.h),
          PasswordField(controller: _passwordCtrl),
          SizedBox(height: AppConstantes.defaultPadding.h),
          ConfirmPasswordField(
            controller: _confirmCtrl,
            passwordController: _passwordCtrl,
          ),
          SizedBox(height: AppConstantes.defaultPadding.h * 1.25),
          AuthButton(
            text: context.translate(LangKeys.signUp),
            onPressed: _submit,
          ),
        ],
      ),
    );
  }
}
