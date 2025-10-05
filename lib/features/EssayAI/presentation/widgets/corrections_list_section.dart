import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/core/common/widgets/text_app.dart';
import 'package:graduation/core/styles/app_text_styles.dart';
import 'package:graduation/features/essayAI/presentation/widgets/correction_item.dart';

class CorrectionsListSection extends StatelessWidget {
  final List<dynamic> corrections;
  final List<String> questions;

  const CorrectionsListSection({
    super.key,
    required this.corrections,
    required this.questions,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 24.h),
        TextApp(
          text: 'نتائج التصحيح:',
          style: AppTextStyles.bold18(context),
        ),
        SizedBox(height: 12.h),

        ...corrections.asMap().entries.where((entry) => entry.value != null).map((entry) {
          final index = entry.key;
          final correction = entry.value!;
          return CorrectionItem(
            index: index,
            question: questions[index],
            correction: correction,
          );
        }).toList(),
      ],
    );
  }
}
