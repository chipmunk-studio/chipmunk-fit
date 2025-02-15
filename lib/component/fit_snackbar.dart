import 'package:flutter/material.dart';

extension ShowSnackBarBuildContextExtension on BuildContext {
  void showSnackBar(
    String message, {
    Duration duration = const Duration(seconds: 2),
    Color? backgroundColor,
    double? elevation,
    EdgeInsetsGeometry margin = const EdgeInsets.only(left: 16, right: 16, bottom: 16),
    EdgeInsetsGeometry? padding,
    double? width,
    ShapeBorder? shape,
    SnackBarBehavior behavior = SnackBarBehavior.floating,
    DismissDirection dismissDirection = DismissDirection.down,
    SnackBarAction? action,
    bool? showCloseIcon,
    Color? closeIconColor,
    void Function()? onVisible,
    Clip clipBehavior = Clip.hardEdge,
  }) {
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
          backgroundColor: backgroundColor,
          elevation: elevation,
          margin: margin,
          padding: padding,
          width: width,
          shape: shape,
          behavior: behavior,
          dismissDirection: dismissDirection,
          action: action,
          showCloseIcon: showCloseIcon,
          closeIconColor: closeIconColor,
          onVisible: onVisible,
          clipBehavior: clipBehavior,
        ),
      );
    } catch (_) {}
  }
}
