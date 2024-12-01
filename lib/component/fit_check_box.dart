import 'package:chipfit/foundation/colors.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FitCheckBox extends StatelessWidget {
  final bool state;
  final Function1<bool, void> onCheck;
  final Color? color;

  const FitCheckBox({
    super.key,
    required this.onCheck,
    required this.state,
    this.color,
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
          color: color ?? context.fitColors.grey800, // 외부 컬러 사용, 없으면 기본값
        ),
        child: Checkbox(
          value: state,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          onChanged: (value) => value != null ? onCheck?.call(value) : null,
        ),
      ),
    );
  }
}
