import 'package:flutter/material.dart';
import 'package:graduation/core/language/app_localizations.dart';
import 'package:graduation/core/language/lang_keys.dart';

class SliderDifficalty extends StatefulWidget {
  const SliderDifficalty({super.key});

  @override
  State<SliderDifficalty> createState() => _SliderDifficaltyState();
}

double difficultyValue = 0.5;
double updateDifficulty(double value) {
  difficultyValue = value;
  return difficultyValue;
}

class _SliderDifficaltyState extends State<SliderDifficalty> {
  @override
  Widget build(BuildContext context) {
    return Slider(
      value: difficultyValue,
      onChanged: (value) {
        setState(() {
          updateDifficulty(value);
        });
      },
      min: 0,
      max: 1,
      divisions: 2,
      activeColor: Theme.of(context).sliderTheme.activeTrackColor,
      label: difficultyLabel(context),
    );
  }
}

String? difficultyLabel(BuildContext context) {
  if (difficultyValue < 0.34) {
    return AppLocalizations.of(context)?.translate(LangKeys.easy);
  }
  if (difficultyValue < 0.67) {
    return AppLocalizations.of(context)?.translate(LangKeys.medium);
  }
  return AppLocalizations.of(context)?.translate(LangKeys.hard);
}
