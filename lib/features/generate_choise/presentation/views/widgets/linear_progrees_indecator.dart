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

    timer = Timer.periodic(const Duration(milliseconds: 800), (t) {
      if (progress >= 1) {
        t.cancel();
      } else {
        setState(() {
          progress += 0.05; // زود 5% كل 800ms
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
      minHeight: 6.h,
    );
  }
}
