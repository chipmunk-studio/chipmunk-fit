import 'package:chip_component/button/fit_button.dart';
import 'package:flutter/material.dart';
import 'package:chip_foundation/buttonstyle.dart';
import 'package:chip_foundation/colors.dart';
import 'package:chip_foundation/textstyle.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 공통 다이얼로그 생성 유틸리티
class FitDialog {
  /// 에러 메시지를 표시하는 다이얼로그 생성
  static Future<T?> showErrorDialog<T>({
    required BuildContext context,
    required String message,
    String? description,
    required VoidCallback onPress,
    VoidCallback? onDismiss,
    Color? dialogBackgroundColor,
    TextStyle? textStyle,
    Color? btnOkColor,
    Color? btnOkTextColor,
    String? btnOkText,
    double borderRadius = 32.0,
    bool dismissOnTouchOutside = false,
    bool dismissOnBackKeyPress = false,
  }) {
    return showGeneralDialog<T>(
      context: context,
      barrierDismissible: dismissOnTouchOutside,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 300),
      transitionBuilder: _slideTransition,
      pageBuilder: (context, animation, secondaryAnimation) => PopScope(
        canPop: dismissOnBackKeyPress,
        child: Dialog(
          backgroundColor: dialogBackgroundColor ?? context.fitColors.backgroundElevated,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius.r),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 8),
                Text(
                  description?.isNotEmpty == true ? description! : message,
                  style: textStyle ?? context.body1().copyWith(color: context.fitColors.textSecondary),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 28),
                FitButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    onPress();
                  },
                  isExpanded: true,
                  type: FitButtonType.primary,
                  style: btnOkColor != null
                      ? FitButtonStyle.styleFrom(backgroundColor: btnOkColor)
                      : null,
                  child: Text(
                    btnOkText ?? '확인',
                    style: context.button1().copyWith(
                          color: btnOkTextColor ?? context.fitColors.staticBlack,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ).then((value) {
      onDismiss?.call();
      return value;
    });
  }

  /// 커스터마이징 가능한 범용 다이얼로그 생성
  static Future<T?> showFitDialog<T>({
    required BuildContext context,
    String? title,
    String? subTitle,
    String? btnOkText,
    VoidCallback? btnOkPressed,
    VoidCallback? btnCancelPressed,
    VoidCallback? onDismiss,
    String? btnCancelText,
    Color? titleTextColor,
    Color? subTitleTextColor,
    bool dismissOnTouchOutside = false,
    bool dismissOnBackKeyPress = false,
    Widget? topContent,
    Widget? bottomContent,
    double borderRadius = 32.0,
    Color? dialogBackgroundColor,
    FitButtonType? okButtonType,
    FitButtonType? cancelButtonType,
    Color? btnOkColor,
    Color? btnCancelColor,
    Color? btnOkTextColor,
    Color? btnCancelTextColor,
  }) {
    return showGeneralDialog<T>(
      context: context,
      barrierDismissible: dismissOnTouchOutside,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 300),
      transitionBuilder: _slideTransition,
      pageBuilder: (context, animation, secondaryAnimation) => PopScope(
        canPop: dismissOnBackKeyPress,
        child: Dialog(
          backgroundColor: dialogBackgroundColor ?? context.fitColors.backgroundElevated,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius.r),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (topContent != null) topContent,
                if (title != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    title,
                    style: context.h2().copyWith(
                          color: titleTextColor ?? context.fitColors.textPrimary,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ],
                if (subTitle != null) ...[
                  const SizedBox(height: 12),
                  Text(
                    subTitle,
                    style: context.body1().copyWith(
                          color: subTitleTextColor ?? context.fitColors.textSecondary,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ],
                if (bottomContent != null) bottomContent,
                const SizedBox(height: 28),
                _buildButtons(
                  context,
                  btnOkPressed: btnOkPressed,
                  btnCancelPressed: btnCancelPressed,
                  btnOkText: btnOkText,
                  btnCancelText: btnCancelText,
                  okButtonType: okButtonType,
                  cancelButtonType: cancelButtonType,
                  btnOkColor: btnOkColor,
                  btnCancelColor: btnCancelColor,
                  btnOkTextColor: btnOkTextColor,
                  btnCancelTextColor: btnCancelTextColor,
                ),
              ],
            ),
          ),
        ),
      ),
    ).then((value) {
      onDismiss?.call();
      return value;
    });
  }

  /// 슬라이드 트랜지션 (위에서 아래로 나타나고, 아래로 사라지는 애니메이션)
  static Widget _slideTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final isDismissing = animation.status == AnimationStatus.reverse ||
            animation.status == AnimationStatus.dismissed;

        late final Offset offset;
        late final double opacity;

        if (isDismissing) {
          // 사라질 때: 중앙(0) → 아래(0.5)
          // animation.value: 1 → 0
          final curvedValue = Curves.easeInCubic.transform(1.0 - animation.value);
          offset = Offset(0, curvedValue * 0.5);
          opacity = animation.value;
        } else {
          // 나타날 때: 위(-0.3) → 중앙(0)
          // animation.value: 0 → 1
          final curvedValue = Curves.easeOutCubic.transform(animation.value);
          offset = Offset(0, -0.3 + (curvedValue * 0.3));
          opacity = animation.value;
        }

        return Transform.translate(
          offset: Offset(
            offset.dx * MediaQuery.of(context).size.width,
            offset.dy * MediaQuery.of(context).size.height,
          ),
          child: Opacity(
            opacity: opacity.clamp(0.0, 1.0),
            child: child,
          ),
        );
      },
      child: child,
    );
  }

  /// 버튼 영역 빌드
  static Widget _buildButtons(
    BuildContext context, {
    VoidCallback? btnOkPressed,
    VoidCallback? btnCancelPressed,
    String? btnOkText,
    String? btnCancelText,
    FitButtonType? okButtonType,
    FitButtonType? cancelButtonType,
    Color? btnOkColor,
    Color? btnCancelColor,
    Color? btnOkTextColor,
    Color? btnCancelTextColor,
  }) {
    final hasCancel = btnCancelPressed != null || btnCancelText != null;

    if (!hasCancel) {
      // 확인 버튼만
      return FitButton(
        onPressed: () {
          Navigator.of(context).pop();
          btnOkPressed?.call();
        },
        isExpanded: true,
        type: okButtonType ?? FitButtonType.primary,
        style: btnOkColor != null
            ? FitButtonStyle.styleFrom(backgroundColor: btnOkColor)
            : null,
        child: Text(
          btnOkText ?? '확인',
          style: context.button1().copyWith(
                color: btnOkTextColor ??
                    FitButtonStyle.textColorOf(
                      context,
                      okButtonType ?? FitButtonType.primary,
                      isEnabled: true,
                    ),
              ),
        ),
      );
    }

    // 확인 + 취소 버튼
    return Row(
      children: [
        Expanded(
          child: FitButton(
            onPressed: () {
              Navigator.of(context).pop();
              btnCancelPressed?.call();
            },
            isExpanded: true,
            type: cancelButtonType ?? FitButtonType.tertiary,
            style: btnCancelColor != null
                ? FitButtonStyle.styleFrom(backgroundColor: btnCancelColor)
                : null,
            child: Text(
              btnCancelText ?? '취소',
              style: context.button1().copyWith(
                    color: btnCancelTextColor ??
                        FitButtonStyle.textColorOf(
                          context,
                          cancelButtonType ?? FitButtonType.tertiary,
                          isEnabled: true,
                        ),
                  ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: FitButton(
            onPressed: () {
              Navigator.of(context).pop();
              btnOkPressed?.call();
            },
            isExpanded: true,
            type: okButtonType ?? FitButtonType.primary,
            style: btnOkColor != null
                ? FitButtonStyle.styleFrom(backgroundColor: btnOkColor)
                : null,
            child: Text(
              btnOkText ?? '확인',
              style: context.button1().copyWith(
                    color: btnOkTextColor ??
                        FitButtonStyle.textColorOf(
                          context,
                          okButtonType ?? FitButtonType.primary,
                          isEnabled: true,
                        ),
                  ),
            ),
          ),
        ),
      ],
    );
  }
}
