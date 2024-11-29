import 'package:chipmunk_fit/foundation/textstyle.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import 'fit_bottom_button.dart';

class FitTextButton extends StatelessWidget {
  final Function0? onPress;
  final String text;
  final _deBouncer = FitButtonDeBouncer(milliseconds: 3000);
  final TextStyle? textStyle;

  FitTextButton({
    super.key,
    required this.onPress,
    required this.text,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPress != null ? () => _deBouncer.run(onPress) : null,
      child: Text(
        text,
        style: textStyle ?? context.caption2Regular(),
      ),
    );
  }
}
