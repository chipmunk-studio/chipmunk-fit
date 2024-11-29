import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'fit_button.dart';

class LarBottomButton extends StatelessWidget {
  final bool isEnabled;
  final bool isShowLoading;
  final Function0 onPress;
  final String text;
  final bool isKeyboardVisible;
  final _deBouncer = FitButtonDeBouncer(milliseconds: 3000);

  LarBottomButton({
    super.key,
    required this.isEnabled,
    required this.onPress,
    required this.text,
    required this.isKeyboardVisible,
    this.isShowLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return FitButton(
      isExpand: true,
      isEnabled: isEnabled,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: isKeyboardVisible ? BorderRadius.circular(0.r) : BorderRadius.circular(50.r),
        ),
      ),
      onPress: () => _deBouncer.run(onPress),
      child: Text(
        text,
        textAlign: TextAlign.center,
      ),
    );
  }
}

class FitButtonDeBouncer {
  final int milliseconds;
  Timer? _timer;

  FitButtonDeBouncer({required this.milliseconds});

  run(VoidCallback? action) {
    if (_timer != null) return;
    action?.call();
    _timer = Timer(Duration(milliseconds: milliseconds), () {
      _timer = null;
    });
  }
}
