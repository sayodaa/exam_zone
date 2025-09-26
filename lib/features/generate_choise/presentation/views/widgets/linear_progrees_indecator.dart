import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LinearProgressIndicatorForGenerateExam extends StatefulWidget {
  const LinearProgressIndicatorForGenerateExam({super.key});

  @override
  State<LinearProgressIndicatorForGenerateExam> createState() =>
      _LinearProgressIndicatorForGenerateExamState();
}

class _LinearProgressIndicatorForGenerateExamState
    extends State<LinearProgressIndicatorForGenerateExam> {
  double progress = 0.0;
  Timer? timer;
  

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (progress >= 1) {
        t.cancel();
      } else {
        setState(() {
          progress += 0.05; // زود 5% كل 200ms
        });
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: progress,
      backgroundColor:
          Theme.of(context).progressIndicatorTheme.linearTrackColor,
      valueColor: AlwaysStoppedAnimation<Color>(
        Theme.of(context).progressIndicatorTheme.color!,
      ),
      minHeight: 6.h,
    );
  }
}
