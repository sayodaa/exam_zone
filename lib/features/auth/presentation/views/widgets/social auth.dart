import 'package:flutter/material.dart';
import 'package:graduation/core/common/animations/animate_do.dart';
import 'package:graduation/core/common/widgets/text_app.dart';
import 'package:graduation/core/extensions/context_extension.dart';
import 'package:graduation/core/language/lang_keys.dart';
import 'package:graduation/core/styles/app_text_styles.dart';
import 'package:graduation/features/auth/presentation/views/widgets/social_auth_button.dart';

class SocialAuthSection extends StatelessWidget {
  const SocialAuthSection({super.key, this.onGoogle});
  final VoidCallback? onGoogle;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(
      context,
    ).textTheme.bodyMedium?.color?.withValues(alpha: 0.7);

    return Column(
      children: [
        CustomFadeInUp(
          duration: 700,
          child: Center(
            child: TextApp(
              text: context.translate(LangKeys.orContinueWith),
              style: AppTextStyles.body14(context).copyWith(color: color),
            ),
          ),
        ),
        const SizedBox(height: 16),
        CustomFadeInUp(
          duration: 700,
          child: SocialAuthButton(
            icon: Icons.g_mobiledata,
            onPressed: onGoogle ?? () {},
          ),
        ),
      ],
    );
  }
}
