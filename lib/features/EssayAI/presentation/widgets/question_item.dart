import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/core/common/widgets/text_app.dart';
import 'package:graduation/core/styles/app_text_styles.dart';
import 'package:graduation/features/overwall/presentation/widgets/input_field.dart';
import 'package:graduation/features/essayAI/presentation/widgets/essay_card.dart';

class QuestionItem extends StatelessWidget {
  final int index;
  final String question;
  final TextEditingController answerController;

  const QuestionItem({
    super.key,
    required this.index,
    required this.question,
    required this.answerController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: EssayCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: CircleAvatar(
                radius: 16.r,
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: TextApp(
                  text: '${index + 1}',
                  style: AppTextStyles.body14(context)
                      .copyWith(color: Colors.white),
                ),
              ),
              title: TextApp(
                text: question,
                style: AppTextStyles.body14(context),
              ),
            ),
            SizedBox(height: 8.h),
            BuildInputField(
              controller: answerController,
              maxLines: 5,
              validator: (value) => value == null || value.isEmpty
                  ? 'أدخل إجابة السؤال ${index + 1}'
                  : null,
              label: 'إجابة السؤال ${index + 1}',
            ),
          ],
        ),
      ),
    );
  }
}
