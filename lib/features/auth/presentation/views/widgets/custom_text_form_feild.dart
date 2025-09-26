import 'package:flutter/material.dart';
import 'package:graduation/core/common/animations/animate_do.dart';
import 'package:graduation/core/common/widgets/app_text_field.dart';

class CustomTextFormFeild extends StatelessWidget {
  const CustomTextFormFeild({
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
        keyboardType: keyboardType,
        textInputAction: TextInputAction.next,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return "Please enter your $labelText";
          }
          return null;
        },
      ),
    );
  }
}
