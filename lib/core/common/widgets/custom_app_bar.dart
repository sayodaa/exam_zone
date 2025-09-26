import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/core/common/animations/animate_do.dart';
import 'package:graduation/core/common/widgets/text_app.dart';
import 'package:graduation/core/styles/app_text_styles.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.text,
    this.icon = Icons.help_outline,
    this.isVisable = false,
    this.onTap,
  });
  final bool isVisable;
  final String text;
  final IconData icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return CustomFadeInDown(
      duration: 800,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Visibility(
            visible: isVisable,
            child: GestureDetector(
              onTap: onTap,
              child: Icon(Icons.list, size: 32.sp),
            ),
          ),
          TextApp(text: text, style: AppTextStyles.bold24(context)),

          Icon(
            icon,
            color:
                Theme.of(context).iconTheme.color ??
                Theme.of(context).textTheme.bodyLarge?.color,
            size: 24.sp,
          ),
        ],
      ),
    );
  }
}
