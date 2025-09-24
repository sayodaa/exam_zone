import 'package:flutter/material.dart';
import 'package:graduation/core/common/animations/animate_do.dart';
import 'package:graduation/core/common/widgets/text_app.dart';
import 'package:graduation/core/styles/app_text_styles.dart';

class ForgotPasswordButton extends StatelessWidget {
  const ForgotPasswordButton({super.key, this.onPressed, required this.label});
  final VoidCallback? onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(
      context,
    ).textTheme.bodyMedium?.color?.withValues(alpha: 0.7);

    return CustomFadeInLeft(
      duration: 600,
      child: TextButton(
        style:
            Theme.of(context).textButtonTheme.style ??
            TextButton.styleFrom(foregroundColor: color),
        onPressed: onPressed,
        child: TextApp(
          text: label,
          style: AppTextStyles.body14(context).copyWith(color: color),
        ),
      ),
    );
  }
}
