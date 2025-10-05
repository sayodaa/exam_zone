import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/core/common/widgets/text_app.dart';
import 'package:graduation/core/styles/app_text_styles.dart';
import 'package:graduation/features/essayAI/presentation/widgets/essay_card.dart';

class CorrectionItem extends StatelessWidget {
  final int index;
  final String question;
  final dynamic correction;

  const CorrectionItem({
    super.key,
    required this.index,
    required this.question,
    required this.correction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: EssayCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextApp(
              text: 'السؤال ${index + 1}: $question',
              style: AppTextStyles.semiBold16(context),
            ),
            SizedBox(height: 8.h),
            TextApp(
              text: 'الدرجة: ${correction.score}/10',
              style: AppTextStyles.bold18(context).copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            SizedBox(height: 12.h),
            TextApp(
              text: 'الأخطاء:',
              style: AppTextStyles.semiBold16(context),
            ),
            SizedBox(height: 8.h),
            TextApp(
              text: correction.mistakes,
              style: AppTextStyles.body14(context),
            ),
            SizedBox(height: 12.h),
            TextApp(
              text: 'الملاحظات:',
              style: AppTextStyles.semiBold16(context),
            ),
            SizedBox(height: 8.h),
            TextApp(
              text: correction.feedback,
              style: AppTextStyles.body14(context),
            ),
          ],
        ),
      ),
    );
  }
}
