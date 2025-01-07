import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chipfit/foundation/index.dart';
import 'package:flutter/material.dart';

class FitDialog {
  static AwesomeDialog makeErrorDialog({
    required BuildContext context,
    required String message,
    String? description,
    required VoidCallback onPress,
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
      dialogBackgroundColor: dialogBackgroundColor ?? context.fitColors.grey800,
      buttonsTextStyle: buttonTextStyle ?? context.button1().copyWith(color: context.fitColors.grey0),
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
              style: textStyle ?? context.body1().copyWith(color: context.fitColors.grey200),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      padding: const EdgeInsets.only(bottom: 10),
      dialogBorderRadius: BorderRadius.circular(borderRadius),
      btnOkColor: btnOkColor ?? context.fitColors.main,
      btnOkText: btnOkText ?? '확인',
      btnOkOnPress: onPress,
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
    Color? titleTextColor,
    Color? subTitleTextColor,
    bool dismissOnTouchOutside = false,
    bool dismissOnBackKeyPress = false,
    Widget? topContent,
    Widget? bottomContent,
    double borderRadius = 32.0,
    Color? dialogBackgroundColor,
    TextStyle? buttonsTextStyle,
  }) {
    AwesomeDialog(
      context: context,
      animType: AnimType.scale,
      dialogType: DialogType.noHeader,
      dialogBackgroundColor: dialogBackgroundColor ?? context.fitColors.grey800,
      buttonsTextStyle:
          buttonsTextStyle ?? context.button1().copyWith(color: btnTextColor ?? context.fitColors.grey0),
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
                style: context.h2().copyWith(color: titleTextColor ?? context.fitColors.grey0),
                textAlign: TextAlign.center,
              ),
            if (subTitle != null) ...[
              const SizedBox(height: 12),
              Text(
                subTitle,
                style: context.body1().copyWith(color: subTitleTextColor ?? context.fitColors.grey200),
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
      btnOkColor: btnOkColor ?? context.fitColors.main,
      btnOkText: btnOkText ?? '확인',
      btnOkOnPress: btnOkPressed,
      btnCancelOnPress: btnCancelPressed,
      btnCancelColor: btnCancelColor ?? context.fitColors.grey500,
      btnCancelText: btnCancelText ?? '취소',
      onDismissCallback: onDismissCallback,
    ).show();
  }
}
