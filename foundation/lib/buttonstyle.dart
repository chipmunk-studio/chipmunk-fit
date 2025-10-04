import 'package:chip_assets/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'colors.dart';
import 'textstyle.dart';

/// 버튼 타입 정의
enum FitButtonType {
  secondary,
  tertiary,
  ghost,
  primary,
  destructive,
}

/// BuildContext에 버튼 스타일 생성 기능 추가
extension ButtonStyleExtension on BuildContext {
  /// 버튼 타입에 따른 ButtonStyle 반환
  ///
  /// [type] - 버튼 타입
  /// [isEnabled] - 활성화 상태 (ghost 타입에서 사용)
  /// [isRipple] - 리플 효과 활성화 여부
  ButtonStyle getButtonStyle(
    FitButtonType? type, {
    required bool isEnabled,
    bool isRipple = false,
  }) {
    switch (type) {
      case FitButtonType.secondary:
        return btnStyleSecondary(isRipple: isRipple);
      case FitButtonType.tertiary:
        return btnStyleTertiary(isRipple: isRipple);
      case FitButtonType.ghost:
        return btnStyleGhost(isRipple: isRipple, isEnabled: isEnabled);
      case FitButtonType.destructive:
        return btnStyleDestructive(isRipple: isRipple);
      case FitButtonType.primary:
      case null:
        return btnStylePrimary(isRipple: isRipple);
    }
  }

  /// Secondary 버튼 스타일
  ButtonStyle btnStyleSecondary({bool isRipple = false}) {
    return _baseButtonStyle(
      foregroundColor: this.fitColors.inverseText,
      backgroundColor: this.fitColors.grey900,
      disabledForegroundColor: this.fitColors.textSecondary,
      disabledBackgroundColor: this.fitColors.grey300,
      isRipple: isRipple,
    );
  }

  /// Tertiary 버튼 스타일
  ButtonStyle btnStyleTertiary({bool isRipple = false}) {
    return _baseButtonStyle(
      foregroundColor: this.fitColors.textDisabled,
      backgroundColor: this.fitColors.fillStrong,
      disabledForegroundColor: this.fitColors.textTertiary,
      disabledBackgroundColor: this.fitColors.fillAlternative,
      isRipple: isRipple,
    );
  }

  /// Primary 버튼 스타일
  ButtonStyle btnStylePrimary({bool isRipple = false}) {
    return _baseButtonStyle(
      foregroundColor: this.fitColors.staticBlack,
      backgroundColor: this.fitColors.main,
      disabledForegroundColor: ChipColors.grey0Dark,
      disabledBackgroundColor: this.fitColors.green50,
      isRipple: isRipple,
      textStyle: button1().copyWith(color: this.fitColors.staticBlack),
    );
  }

  /// Ghost 버튼 스타일 (외곽선만 있는 버튼)
  ButtonStyle btnStyleGhost({
    bool isRipple = false,
    required bool isEnabled,
  }) {
    return _baseButtonStyle(
      foregroundColor: this.fitColors.grey900,
      backgroundColor: Colors.transparent,
      disabledForegroundColor: this.fitColors.grey300,
      disabledBackgroundColor: Colors.transparent,
      borderSide: BorderSide(
        color: isEnabled ? this.fitColors.grey400 : this.fitColors.grey200,
        width: 1.0,
      ),
      isRipple: isRipple,
    );
  }

  /// Destructive 버튼 스타일 (위험한 작업용)
  ButtonStyle btnStyleDestructive({bool isRipple = false}) {
    return _baseButtonStyle(
      foregroundColor: this.fitColors.staticWhite,
      backgroundColor: this.fitColors.red500,
      disabledForegroundColor: this.fitColors.inverseDisabled,
      disabledBackgroundColor: this.fitColors.red50,
      isRipple: isRipple,
    );
  }

  /// 공통 버튼 스타일 생성 (중복 코드 제거)
  ButtonStyle _baseButtonStyle({
    required Color foregroundColor,
    required Color backgroundColor,
    required Color disabledForegroundColor,
    required Color disabledBackgroundColor,
    BorderSide? borderSide,
    bool isRipple = false,
    TextStyle? textStyle,
  }) {
    return ElevatedButton.styleFrom(
      foregroundColor: foregroundColor,
      backgroundColor: backgroundColor,
      disabledForegroundColor: disabledForegroundColor,
      disabledBackgroundColor: disabledBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100.r),
        side: borderSide ?? const BorderSide(color: Colors.transparent, width: 1.0),
      ),
      elevation: 0,
      padding: EdgeInsets.zero,
      minimumSize: const Size(0, 0),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
      alignment: Alignment.center,
      textStyle: textStyle ?? button1(),
    ).copyWith(
      overlayColor: _getOverlayColor(isRipple),
      shadowColor: _transparentMaterialState,
      surfaceTintColor: _transparentMaterialState,
    );
  }

  /// 리플 효과 색상 반환 (메모리 최적화)
  MaterialStateProperty<Color> _getOverlayColor(bool isRipple) {
    return isRipple
        ? MaterialStateProperty.all(this.fitColors.grey600.withOpacity(0.2))
        : _transparentMaterialState;
  }

  /// 투명 MaterialStateProperty (재사용)
  static final _transparentMaterialState = MaterialStateProperty.all(Colors.transparent);
}
