import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class FitDialog {
  static AwesomeDialog showErrorDialog({
    required BuildContext context,
    required String message,
    String? description,
    required VoidCallback onOkPress,
    Color? dialogBackgroundColor,
    TextStyle? textStyle,
    TextStyle? buttonTextStyle,
    Color? btnOkColor,
    String? btnOkText,
    double borderRadius = 32.0,
  }) {
    return AwesomeDialog(
      context: context,
      animType: AnimType.scale,
      dialogType: DialogType.noHeader,
      dialogBackgroundColor: dialogBackgroundColor ?? Colors.grey[800],
      buttonsTextStyle: buttonTextStyle ?? const TextStyle(color: Colors.white),
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Text(
              description?.isNotEmpty == true ? description! : message,
              style: textStyle ??
                  const TextStyle(
                    color: Colors.white,
                    height: 1.4,
                    fontSize: 14,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      padding: const EdgeInsets.only(bottom: 10),
      dialogBorderRadius: BorderRadius.circular(borderRadius),
      btnOkColor: btnOkColor ?? Colors.blue,
      btnOkText: btnOkText ?? '확인',
      btnOkOnPress: onOkPress,
    );
  }

  static void showFitDialog({
    required BuildContext context,
    String? title,
    String? subTitle,
    String? btnOkText,
    VoidCallback? btnOkPressed,
    VoidCallback? btnCancelPressed,
    Function(DismissType)? onDismissCallback,
    String? btnCancelText,
    Color? btnOkColor,
    Color? btnCancelColor,
    Color? btnTextColor,
    bool dismissOnTouchOutside = false,
    bool dismissOnBackKeyPress = false,
    Widget? topContent,
    Widget? bottomContent,
    double borderRadius = 32.0,
  }) {
    AwesomeDialog(
      context: context,
      animType: AnimType.scale,
      dialogType: DialogType.noHeader,
      dialogBackgroundColor: Colors.grey[800],
      buttonsTextStyle: TextStyle(color: btnTextColor ?? Colors.black),
      dismissOnTouchOutside: dismissOnTouchOutside,
      dismissOnBackKeyPress: dismissOnBackKeyPress,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (topContent != null) topContent,
            if (title != null) const SizedBox(height: 20),
            if (title != null)
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
            if (subTitle != null) ...[
              const SizedBox(height: 12),
              Text(
                subTitle,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            if (bottomContent != null) bottomContent,
            const SizedBox(height: 20),
          ],
        ),
      ),
      padding: const EdgeInsets.only(bottom: 10),
      dialogBorderRadius: BorderRadius.circular(borderRadius),
      btnOkColor: btnOkColor ?? Colors.blue,
      btnOkText: btnOkText ?? 'Confirm',
      btnOkOnPress: btnOkPressed,
      btnCancelOnPress: btnCancelPressed,
      btnCancelColor: btnCancelColor ?? Colors.grey,
      btnCancelText: btnCancelText ?? 'Cancel',
      onDismissCallback: onDismissCallback,
    ).show();
  }
}
