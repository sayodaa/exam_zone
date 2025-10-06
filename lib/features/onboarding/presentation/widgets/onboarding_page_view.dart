import 'package:flutter/material.dart';
import 'package:graduation/core/extensions/context_extension.dart';
import 'package:graduation/core/language/lang_keys.dart';
import 'package:graduation/core/styles/app_images.dart';
import 'package:graduation/features/onboarding/data/models/inboarding_item_model.dart';
import 'package:graduation/features/onboarding/presentation/widgets/page_view_item.dart';

class OnBoardingPageView extends StatelessWidget {
  const OnBoardingPageView({
    super.key,
    required this.pageController,
    required this.onLastPage,
  });

  final PageController pageController;
  final ValueChanged<bool> onLastPage;

  List<OnboardingItemModel> get onboardingDark => [
    OnboardingItemModel(
      image: AppImages.onBoard1,
      title: LangKeys.onboardTitle1,
      description: LangKeys.onboardBody1,
    ),
    OnboardingItemModel(
      image: AppImages.onBoard2,
      title: LangKeys.onboardTitle2,
      description: LangKeys.onboardBody2,
    ),
    OnboardingItemModel(
      image: AppImages.onBoard3,
      title: LangKeys.onboardTitle3,
      description: LangKeys.onboardBody3,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: pageController,
      physics: const BouncingScrollPhysics(),
      itemCount: onboardingDark.length,
      onPageChanged: (index) {
        onLastPage(index == onboardingDark.length - 1);
      },
      itemBuilder: (context, index) {
        final item = onboardingDark[index];
        return PageViewItem(
          image: item.image,
          title: context.translate(item.title),
          subtitle: context.translate(item.description),
        );
      },
    );
  }
}
