import 'package:flutter/material.dart';
import 'package:graduation/core/common/widgets/text_app.dart';
import 'package:graduation/core/styles/app_images.dart';
import 'package:graduation/core/styles/app_text_styles.dart';
import 'package:lottie/lottie.dart';

class PageViewItem extends StatelessWidget {
  const PageViewItem({
    super.key,
    required this.video,
    required this.title,
    required this.subtitle,
  });

  final String video;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height,
      width: size.width,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 60),
            SizedBox(
              height: 250,
              width: 250,
              child:
                  (video.toLowerCase().endsWith('.json') ||
                      video.toLowerCase().endsWith('.lottie'))
                  ? Lottie.asset(
                      video,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          AppImages.examZone,
                          fit: BoxFit.contain,
                        );
                      },
                    )
                  : Image.asset(video, fit: BoxFit.contain),
            ),
            const SizedBox(height: 30),
            TextApp(
              text: title,
              textAlign: TextAlign.center,
              style: AppTextStyles.bold24(context),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: TextApp(
                text: subtitle,
                textAlign: TextAlign.center,
                style: AppTextStyles.body16(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
