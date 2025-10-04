import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/core/common/widgets/text_app.dart';
import 'package:graduation/core/extensions/context_extension.dart';
import 'package:graduation/core/language/lang_keys.dart';
import 'package:graduation/core/services/service_locator.dart';
import 'package:graduation/core/styles/app_text_styles.dart';
import 'package:graduation/core/styles/styles.dart';
import 'package:graduation/features/essayAI/presentation/cubit/essay_cubit.dart';
import 'package:graduation/features/essayAI/presentation/cubit/essay_state.dart';
import 'package:graduation/features/overwall/presentation/widgets/custom_app_bar_for_exams.dart';
import 'package:graduation/features/overwall/presentation/widgets/input_field.dart';

class EssayAiView extends StatelessWidget {
  const EssayAiView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<EssayCubit>(),
      child: Builder(
        builder: (context) => const _EssayAiViewBody(),
      ),
    );
  }
}

class _EssayAiViewBody extends StatefulWidget {
  const _EssayAiViewBody();

  @override
  State<_EssayAiViewBody> createState() => _EssayAiViewBodyState();
}

class _EssayAiViewBodyState extends State<_EssayAiViewBody> {
  final _formKey = GlobalKey<FormState>();
  final _topicController = TextEditingController();
  final _questionsController = TextEditingController();
  List<TextEditingController> _answerControllers = [];

  @override
  void dispose() {
    _topicController.dispose();
    _questionsController.dispose();
    for (var controller in _answerControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarForExams(
        text: context.translate(LangKeys.essay),
        icon: Icons.close,
        onPressed: () => Navigator.pop(context),
      ),
  body: BlocConsumer<EssayCubit, EssayState>(
        listener: (context, state) {
          if (state is QuestionsGeneratedSuccess) {
        setState(() {
          _answerControllers = List.generate(
            state.questions.length,
            (_) => TextEditingController(),
          );
        });
          } else if (state is QuestionsGeneratedFailure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.error),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
          } else if (state is AnswersCorrectedFailure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.error),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
          }
        },
        builder: (context, state) {
          return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppColorsStyles.defaultPadding.w,
          vertical: AppColorsStyles.defaultPadding.h,
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // حقل إدخال الموضوع
            _buildCard(
              child: BuildInputField(
            label: context.translate(LangKeys.enterExamTitle),
            controller: _topicController,
            validator: (value) => value!.isEmpty
                ? context.translate(LangKeys.enterExamTitle)
                : null,
            maxLines: 2,
              ),
            ),
            SizedBox(height: 16.h),

            // حقل عدد الأسئلة
            _buildCard(
              child: BuildInputField(
            label: context.translate(LangKeys.numberOfQuestions),
            controller: _questionsController,
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'من فضلك أدخل عدد الأسئلة';
              }
              if (int.tryParse(value) == null ||
              int.parse(value) <= 0) {
                return 'أدخل عددًا صحيحًا أكبر من 0';
              }
              return null;
            },
              ),
            ),
            SizedBox(height: 24.h),

            // زر إنشاء الأسئلة
            Center(
              child: _buildButton(
            onPressed: state is GeneratingQuestions
                ? null
                : () => _generateQuestions(context),
            child: state is GeneratingQuestions
                ? SizedBox(
                width: 24.w,
                height: 24.h,
                child: const CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                Colors.white,
                  ),
                ),
              )
                : TextApp(
                text: context.translate(LangKeys.generateExam),
                style: AppTextStyles.semiBold16(context)
                .copyWith(color: Colors.white),
              ),
              ),
            ),

            // عرض الأسئلة
            if (state is QuestionsGeneratedSuccess ||
            state is CorrectingAnswers ||
            state is AnswersCorrectedSuccess) ...[
              SizedBox(height: 24.h),
              TextApp(
            text: 'الأسئلة المُنشأة:',
            style: AppTextStyles.bold18(context),
              ),
              SizedBox(height: 12.h),

              ...context
              .read<EssayCubit>()
              .currentQuestions
              .asMap()
              .entries
              .map((entry) {
            final index = entry.key;
            final question = entry.value;
            return Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: _buildCard(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: CircleAvatar(
                radius: 16.r,
                backgroundColor:
                    Theme.of(context).colorScheme.primary,
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
                  controller: _answerControllers[index],
                  maxLines: 5,
                  validator: (value) =>
                  value == null || value.isEmpty
                  ? 'أدخل إجابة السؤال ${index + 1}'
                  : null,
                  label: 'إجابة السؤال ${index + 1}',
                ),
              ],
                ),
              ),
            );
              }).toList(),

              SizedBox(height: 24.h),

              // زر تصحيح الإجابات
              Center(
            child: _buildButton(
              onPressed: state is CorrectingAnswers
              ? null
              : () => _correctAnswers(context),
              child: state is CorrectingAnswers
              ? SizedBox(
                  width: 24.w,
                  height: 24.h,
                  child: const CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.white,
                ),
                  ),
                )
              : TextApp(
                  text: 'صحح إجاباتي',
                  style: AppTextStyles.semiBold16(context)
                  .copyWith(color: Colors.white),
                ),
            ),
              ),
            ],

            // عرض نتائج التصحيح
            if (state is AnswersCorrectedSuccess) ...[
              SizedBox(height: 24.h),
              TextApp(
            text: 'نتائج التصحيح:',
            style: AppTextStyles.bold18(context),
              ),
              SizedBox(height: 12.h),

              ...state.corrections
              .asMap()
              .entries
              .where((entry) => entry.value != null)
              .map((entry) {
            final index = entry.key;
            final correction = entry.value!;
            return Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: _buildCard(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextApp(
                  text:
                  'السؤال ${index + 1}: ${context.read<EssayCubit>().currentQuestions[index]}',
                  style: AppTextStyles.semiBold16(context),
                ),
                SizedBox(height: 8.h),
                TextApp(
                  text: 'الدرجة: ${correction.score}/10',
                  style: AppTextStyles.bold18(context).copyWith(
                color:
                    Theme.of(context).colorScheme.primary,
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
              }).toList(),
            ],

            SizedBox(height: 24.h),
          ],
            ),
          ),
        ),
          );
        },
      ),
    );
  }

  // ✅ تصميم بطاقة احترافية
  Widget _buildCard({required Widget child}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: child,
      ),
    );
  }

  // ✅ تصميم زر احترافي
  Widget _buildButton({
    required VoidCallback? onPressed,
    required Widget child,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        disabledBackgroundColor:
            Theme.of(context).colorScheme.primary.withOpacity(0.6),
        padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 12.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        elevation: 2,
      ),
      child: child,
    );
  }

  // ✅ توليد الأسئلة
  void _generateQuestions(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final topic = _topicController.text.trim();
      final numberOfQuestions = int.parse(_questionsController.text.trim());

      context.read<EssayCubit>().generateQuestions(
            topic: topic,
            numberOfQuestions: numberOfQuestions,
          );
    }
  }

  // ✅ تصحيح الإجابات
  void _correctAnswers(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final questions = context.read<EssayCubit>().currentQuestions;
      final answers =
          _answerControllers.map((controller) => controller.text.trim()).toList();

      context.read<EssayCubit>().correctAnswers(
            questions: questions,
            answers: answers,
          );
    }
  }
}
