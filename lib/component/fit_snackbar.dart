import 'package:flutter/material.dart';

extension ShowSnackBarBuildContextExtension on BuildContext {
  void showSnackBar(
      String message, [
        Duration duration = const Duration(seconds: 2),
        double bottomOffset = 16.0, // 하단에서 얼마나 떨어질지 조절
      ]) {
    try {
      final messengerState = ScaffoldMessenger.maybeOf(this);
      if (messengerState == null) {
        return;
      }
      messengerState.hideCurrentSnackBar();
      messengerState.showSnackBar(
        SnackBar(
          content: Text(message),
          duration: duration,
          behavior: SnackBarBehavior.floating, // 기본 고정형에서 떠 있는 형태로 변경
          margin: EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: bottomOffset, // 하단에서 떨어지는 거리 조정 가능
          ),
        ),
      );
    } catch (_) {}
  }
}