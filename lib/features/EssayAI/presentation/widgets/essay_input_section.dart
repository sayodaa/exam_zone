import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/core/common/widgets/text_app.dart';
import 'package:graduation/core/extensions/context_extension.dart';
import 'package:graduation/core/language/lang_keys.dart';
import 'package:graduation/core/styles/app_text_styles.dart';
import 'package:graduation/features/overwall/presentation/widgets/input_field.dart';
import 'package:graduation/features/essayAI/presentation/widgets/essay_card.dart';

class EssayInputSection extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController topicController;
  final TextEditingController questionsController;
  final bool isGenerating;
  final VoidCallback onGeneratePressed;

  const EssayInputSection({
    super.key,
    required this.formKey,
    required this.topicController,
    required this.questionsController,
    required this.isGenerating,
    required this.onGeneratePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // حقل إدخال الموضوع
        EssayCard(
          child: BuildInputField(
            label: context.translate(LangKeys.enterExamTitle),
            controller: topicController,
            validator: (value) => value!.isEmpty
                ? context.translate(LangKeys.enterExamTitle)
                : null,
            maxLines: 2,
          ),
        ),
        SizedBox(height: 16.h),

        // حقل عدد الأسئلة
        EssayCard(
          child: BuildInputField(
            label: context.translate(LangKeys.numberOfQuestions),
            controller: questionsController,
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'من فضلك أدخل عدد الأسئلة';
              }
              if (int.tryParse(value) == null || int.parse(value) <= 0) {
                return 'أدخل عددًا صحيحًا أكبر من 0';
              }
              return null;
            },
          ),
        ),
        SizedBox(height: 24.h),

        // زر إنشاء الأسئلة
        Center(
          child: ElevatedButton(
            onPressed: isGenerating ? null : onGeneratePressed,
            style: Theme.of(context).elevatedButtonTheme.style,
            child: isGenerating
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
                    text: context.translate(LangKeys.generateExam),
                    style: AppTextStyles.body16(context)
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
          ),
        ),
      ],
    );
  }
}
