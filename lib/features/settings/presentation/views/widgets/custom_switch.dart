import 'package:flutter/material.dart';

class CustomSwitch extends StatelessWidget {
  const CustomSwitch({super.key, required this.value, required this.onChanged});

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).sliderTheme;
    return SizedBox(
      height: 32,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Switch.adaptive(
          value: value,
          onChanged: onChanged,
          activeColor: theme.thumbColor,
          inactiveTrackColor: theme.inactiveTrackColor,
        ),
      ),
    );
  }
}
