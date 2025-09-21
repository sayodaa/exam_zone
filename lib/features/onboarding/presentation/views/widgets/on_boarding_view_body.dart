import 'package:flutter/material.dart';
import 'package:graduation/features/onboarding/presentation/views/widgets/onboarding_page_view.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:graduation/core/extensions/context_extension.dart';
import 'package:graduation/core/language/lang_keys.dart';
import 'package:graduation/core/routes/app_routes.dart';
import 'package:graduation/core/services/shared_pref/pref_keys.dart';
import 'package:graduation/core/services/shared_pref/shared_pref.dart';

class OnBoardingViewsBody extends StatefulWidget {
  const OnBoardingViewsBody({super.key});

  @override
  State<OnBoardingViewsBody> createState() => _OnBoardingViewsBodyState();
}

class _OnBoardingViewsBodyState extends State<OnBoardingViewsBody> {
  late PageController _controller;
  var isLast = false;

  @override
  void initState() {
    _controller = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void submit() async {
    await SharedPref().setBoolean(PrefKeys.onBoarding, true).then((_) {
      if (mounted) {
        context.pushNamedAndRemoveUntil(AppRoutes.login);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: OnBoardingPageView(
            pageController: _controller,
            onLastPage: (last) {
              setState(() => isLast = last);
            },
          ),
        ),
        const SizedBox(height: 15),
        SmoothPageIndicator(
          controller: _controller,
          count: 3,
          onDotClicked: (index) {
            _controller.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.bounceInOut,
            );
          },
          effect: const JumpingDotEffect(
            dotColor: Colors.grey,
            activeDotColor: Colors.blue,
            dotHeight: 10,
            dotWidth: 10,
            spacing: 5,
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: ElevatedButton(
            onPressed: () {
              if (isLast) {
                submit();
              } else {
                _controller.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              minimumSize: const Size.fromHeight(50),
            ),
            child: Text(
              isLast
                  ? context.translate(LangKeys.getStarted)
                  : context.translate(LangKeys.next),
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
