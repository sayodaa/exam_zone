import 'package:flutter/material.dart';
import 'package:graduation/core/common/animations/animate_do.dart';
import 'package:graduation/core/common/widgets/app_text_field.dart';
import 'package:graduation/core/extensions/context_extension.dart';
import 'package:graduation/core/language/lang_keys.dart';

class ConfirmPasswordField extends StatefulWidget {
  const ConfirmPasswordField({
    super.key,
    required this.controller,
    required this.passwordController,
  });

  final TextEditingController controller;
  final TextEditingController passwordController;

  @override
  State<ConfirmPasswordField> createState() => _ConfirmPasswordFieldState();
}

class _ConfirmPasswordFieldState extends State<ConfirmPasswordField> {
  bool _obscure = true;

  void _toggle() => setState(() => _obscure = !_obscure);

  @override
  Widget build(BuildContext context) {
    return CustomFadeInRight(
      duration: 700,
      child: AppTextField(
        controller: widget.controller,
        labelText: context.translate(LangKeys.password),
        keyboardType: TextInputType.visiblePassword,
        textInputAction: TextInputAction.done,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please enter your password";
          } else if (value != widget.passwordController.text) {
            return "Password doesn't match";
          }
          return null;
        },
        obscureText: _obscure,
        suffixIcon: _obscure ? Icons.visibility : Icons.visibility_off,
        suffixIconPressed: _toggle,
      ),
    );
  }
}
