import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/core/common/widgets/text_app.dart';
import 'package:graduation/core/styles/app_text_styles.dart';
import 'package:graduation/features/essayAI/presentation/widgets/question_item.dart';

class QuestionsListSection extends StatelessWidget {
  final List<String> questions;
  final List<TextEditingController> answerControllers;
  final bool isCorrecting;
  final VoidCallback onCorrectPressed;

  const QuestionsListSection({
    super.key,
    required this.questions,
    required this.answerControllers,
    required this.isCorrecting,
    required this.onCorrectPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 24.h),
        TextApp(
          text: 'الأسئلة المُنشأة:',
          style: AppTextStyles.bold18(context),
        ),
        SizedBox(height: 12.h),

        ...questions.asMap().entries.map((entry) {
          final index = entry.key;
          final question = entry.value;
          return QuestionItem(
            index: index,
            question: question,
            answerController: answerControllers[index],
          );
        }).toList(),

        SizedBox(height: 24.h),

        // زر تصحيح الإجابات
        Center(
          child: ElevatedButton(
            onPressed: isCorrecting ? null : onCorrectPressed,
            style: Theme.of(context).elevatedButtonTheme.style,
            child: isCorrecting
                ? SizedBox(
                    width: 24.w,
                    height: 24.h,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color?>(
                        Theme.of(context).textTheme.bodyLarge!.color,
                      ),
                    ),
                  )
                : TextApp(
                    text: 'صحح إجاباتي',
                    style: AppTextStyles.body16(context)
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
          ),
        ),
      ],
    );
  }
}
