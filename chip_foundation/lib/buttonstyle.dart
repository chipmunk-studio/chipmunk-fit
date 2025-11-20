import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'colors.dart';

/// 버튼 타입 정의
enum FitButtonType {
  primary,
  secondary,
  tertiary,
  ghost,
  destructive,
}

/// FitButton 스타일 유틸리티
class FitButtonStyle {
  FitButtonStyle._();

  /// 버튼 타입에 따른 로딩 색상 반환
  static Color loadingColorOf(BuildContext context, FitButtonType type) {
    final colors = context.fitColors;
    return switch (type) {
      FitButtonType.primary => colors.staticBlack,
      FitButtonType.secondary => colors.inverseText,
      FitButtonType.tertiary || FitButtonType.ghost => colors.grey900,
      FitButtonType.destructive => colors.staticWhite,
    };
  }

  /// 버튼 타입에 따른 텍스트 색상 반환
  static Color textColorOf(
    BuildContext context,
    FitButtonType type, {
    required bool isEnabled,
  }) {
    final colors = context.fitColors;

    if (isEnabled) {
      return switch (type) {
        FitButtonType.primary => colors.staticBlack,
        FitButtonType.secondary => colors.inverseText,
        FitButtonType.tertiary || FitButtonType.ghost => colors.grey900,
        FitButtonType.destructive => colors.staticWhite,
      };
    }

    return switch (type) {
      FitButtonType.primary || FitButtonType.destructive => colors.inverseDisabled,
      FitButtonType.secondary => colors.textSecondary,
      FitButtonType.tertiary => colors.textDisabled,
      FitButtonType.ghost => colors.grey300,
    };
  }

  /// 커스텀 ButtonStyle 생성
  static ButtonStyle styleFrom({
    Color? backgroundColor,
    Color? foregroundColor,
    Color? disabledBackgroundColor,
    Color? disabledForegroundColor,
    Color? overlayColor,
    double? borderRadius,
    EdgeInsets? padding,
    TextStyle? textStyle,
    BorderSide? side,
    Size? minimumSize,
    double? elevation,
  }) {
    return ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
        if (states.contains(WidgetState.disabled)) {
          return disabledBackgroundColor;
        }
        return backgroundColor;
      }),
      foregroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
        if (states.contains(WidgetState.disabled)) {
          return disabledForegroundColor;
        }
        return foregroundColor;
      }),
      overlayColor: WidgetStateProperty.all(overlayColor ?? Colors.transparent),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 100.r),
          side: side ?? BorderSide.none,
        ),
      ),
      padding: padding != null ? WidgetStateProperty.all(padding) : null,
      textStyle: textStyle != null ? WidgetStateProperty.all(textStyle) : null,
      elevation: elevation != null ? WidgetStateProperty.all(elevation) : null,
      minimumSize: minimumSize != null ? WidgetStateProperty.all(minimumSize) : null,
      shadowColor: WidgetStateProperty.all(Colors.transparent),
      surfaceTintColor: WidgetStateProperty.all(Colors.transparent),
    );
  }

  /// FitButtonType에 따른 기본 스타일 반환
  static ButtonStyle of(
    BuildContext context,
    FitButtonType type, {
    bool isRipple = false,
  }) {
    final colors = context.fitColors;
    final overlayColor = isRipple ? colors.grey600.withValues(alpha: 0.2) : Colors.transparent;

    return switch (type) {
      FitButtonType.primary => styleFrom(
          backgroundColor: colors.main,
          foregroundColor: colors.staticBlack,
          disabledBackgroundColor: colors.green50,
          disabledForegroundColor: colors.inverseDisabled,
          overlayColor: overlayColor,
        ),
      FitButtonType.secondary => styleFrom(
          backgroundColor: colors.grey900,
          foregroundColor: colors.inverseText,
          disabledBackgroundColor: colors.grey300,
          disabledForegroundColor: colors.textSecondary,
          overlayColor: overlayColor,
        ),
      FitButtonType.tertiary => styleFrom(
          backgroundColor: colors.fillStrong,
          foregroundColor: colors.textDisabled,
          disabledBackgroundColor: colors.fillAlternative,
          disabledForegroundColor: colors.textTertiary,
          overlayColor: overlayColor,
        ),
      FitButtonType.ghost => styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: colors.grey900,
          disabledBackgroundColor: Colors.transparent,
          disabledForegroundColor: colors.grey300,
          overlayColor: overlayColor,
          side: BorderSide(color: colors.grey400, width: 1.0),
        ),
      FitButtonType.destructive => styleFrom(
          backgroundColor: colors.red500,
          foregroundColor: colors.staticWhite,
          disabledBackgroundColor: colors.red50,
          disabledForegroundColor: colors.inverseDisabled,
          overlayColor: overlayColor,
        ),
    };
  }
}

/// ButtonStyle 병합을 위한 extension
extension ButtonStyleMerge on ButtonStyle {
  /// 다른 ButtonStyle과 병합 (other가 우선)
  ButtonStyle merge(ButtonStyle? other) {
    if (other == null) return this;
    return copyWith(
      backgroundColor: other.backgroundColor ?? backgroundColor,
      foregroundColor: other.foregroundColor ?? foregroundColor,
      overlayColor: other.overlayColor ?? overlayColor,
      shape: other.shape ?? shape,
      padding: other.padding ?? padding,
      textStyle: other.textStyle ?? textStyle,
      elevation: other.elevation ?? elevation,
      minimumSize: other.minimumSize ?? minimumSize,
      shadowColor: other.shadowColor ?? shadowColor,
      surfaceTintColor: other.surfaceTintColor ?? surfaceTintColor,
      side: other.side ?? side,
    );
  }
}
