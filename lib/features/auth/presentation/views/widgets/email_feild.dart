import 'package:flutter/material.dart';
import 'package:graduation/core/common/animations/animate_do.dart';
import 'package:graduation/core/common/widgets/app_text_field.dart';
import 'package:graduation/core/utils/app_regex.dart';

class TextFormFeild extends StatelessWidget {
  const TextFormFeild({
    super.key,
    required this.controller,
    required this.keyboardType,
    required this.labelText,
  });
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String labelText;
  @override
  Widget build(BuildContext context) {
    return CustomFadeInRight(
      duration: 700,
      child: AppTextField(
        controller: controller,
        labelText: labelText,
        //  context.translate(LangKeys.email),
        keyboardType: keyboardType,
        textInputAction: TextInputAction.next,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please enter your $labelText";
          } else if (!AppRegex.isEmailValid(value)) {
            return "Please enter a valid $labelText";
          }
          return null;
        },
      ),
    );
  }
}
