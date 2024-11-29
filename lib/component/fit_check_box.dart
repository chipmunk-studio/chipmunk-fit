import 'package:chipmunk_fit/foundation/colors.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FitCheckBox extends StatelessWidget {
  final bool state;
  final Function1<bool, void> onCheck;

  const FitCheckBox({
    super.key,
    required this.onCheck,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 0.9,
      child: Container(
        width: 16,
        height: 16,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.r),
          color: context.fitColors.grey800,
        ),
        child: Checkbox(
          value: state,
          onChanged: (value) => value != null ? onCheck(value) : null,
        ),
      ),
    );
  }
}
