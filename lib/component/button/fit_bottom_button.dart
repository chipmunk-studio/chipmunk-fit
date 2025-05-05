import 'dart:async';

import 'package:chipfit/component/fit_dot_loading.dart';
import 'package:dartz/dartz.dart'; // Function0을 사용하기 위해 필요
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'fit_button.dart'; // FitButton 위젯 import 필요

class FitBottomButton extends StatelessWidget {
  final bool isEnabled;
  final bool isShowLoading;
  final Function0 onPress; // dartz의 Function0 사용
  final String text;
  final TextStyle? textStyle;
  final Color? backgroundColor; // 배경색 파라미터 추가 (옵셔널)
  final bool isKeyboardVisible;
  final _deBouncer = FitButtonDeBouncer(milliseconds: 3000);

  FitBottomButton({
    super.key,
    required this.isEnabled,
    required this.onPress,
    required this.text,
    required this.isKeyboardVisible,
    this.textStyle,
    this.backgroundColor, // 생성자에 backgroundColor 추가
    this.isShowLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    Widget buttonChild = Text(
      text,
      textAlign: TextAlign.center,
      style: textStyle,
    );

    if (isShowLoading) {
      buttonChild = SizedBox(
        height: 20,
        width: 20,
        child: FitDotLoading(),
      );
    }

    return FitButton(
      isExpand: true,
      isEnabled: isEnabled && !isShowLoading,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: isKeyboardVisible ? BorderRadius.circular(0.r) : BorderRadius.circular(50.r),
        ),
        disabledBackgroundColor: backgroundColor?.withOpacity(0.5) ?? Theme.of(context).disabledColor,
      ),
      onPress: isShowLoading ? null : () => _deBouncer.run(onPress),
      child: buttonChild,
    );
  }
}

class FitButtonDeBouncer {
  final int milliseconds;
  Timer? _timer;

  FitButtonDeBouncer({required this.milliseconds});

  run(VoidCallback? action) {
    if (_timer?.isActive ?? false) return;
    action?.call();
    _timer = Timer(Duration(milliseconds: milliseconds), () {});
  }

  void dispose() {
    _timer?.cancel();
  }
}
