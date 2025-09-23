import 'package:flutter/material.dart';
import 'package:graduation/core/common/animations/animate_do.dart';
import 'package:graduation/core/common/widgets/app_text_field.dart';
import 'package:graduation/core/extensions/context_extension.dart';
import 'package:graduation/core/language/lang_keys.dart';
import 'package:graduation/core/utils/app_regex.dart';

class EmailField extends StatelessWidget {
  const EmailField({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return CustomFadeInRight(
      duration: 700,
      child: AppTextField(
        controller: controller,
        labelText: context.translate(LangKeys.email),
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please enter your email";
          } else if (!AppRegex.isEmailValid(value)) {
            return "Please enter a valid email";
          }
          return null;
        },
      ),
    );
  }
}
