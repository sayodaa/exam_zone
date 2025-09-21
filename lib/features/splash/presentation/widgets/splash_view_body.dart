import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/core/common/widgets/text_app.dart';
import 'package:graduation/core/extensions/context_extension.dart';
import 'package:graduation/core/language/lang_keys.dart';
import 'package:graduation/core/routes/app_routes.dart';
import 'package:graduation/core/styles/app_images.dart';
import 'package:graduation/core/styles/app_text_styles.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  @override
  void initState() {
    super.initState();
    navigator();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AppImages.logo, height: 200.h, width: 200.w),
              SizedBox(height: 24.h),
              TextApp(
                text: context.translate(LangKeys.appName),
                style: AppTextStyles.bold32(context),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12.h),
              TextApp(
                text: context.translate(LangKeys.splashBody),
                style: AppTextStyles.body16(context),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void navigator() {
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      context.pushNamedAndRemoveUntil(AppRoutes.onBoarding);
    });
  }
}
