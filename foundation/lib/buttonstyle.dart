import 'package:assets/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'colors.dart';
import 'textstyle.dart';

enum FitButtonType {
  secondary,
  tertiary,
  ghost,
  primary,
  destructive,
}

extension ButtonStyleExtension on BuildContext {
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
      case FitButtonType.primary:
        return btnStylePrimary(isRipple: isRipple);
      case FitButtonType.ghost:
        return btnStyleGhost(isRipple: isRipple, isEnabled: isEnabled);
      case FitButtonType.destructive:
        return btnStyleDestructive(isRipple: isRipple);
      default:
        return btnStylePrimary(isRipple: isRipple); // 기본 스타일
    }
  }

  ButtonStyle btnStyleSecondary({bool isRipple = false}) {
    return ElevatedButton.styleFrom(
      foregroundColor: this.fitColors.inverseText,
      backgroundColor: this.fitColors.grey900,
      disabledForegroundColor: this.fitColors.textSecondary,
      disabledBackgroundColor: this.fitColors.grey300,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100.r),
        side: const BorderSide(
          color: Colors.transparent,
          width: 1.0,
        ),
      ),
      elevation: 0,
      padding: EdgeInsets.zero,
      minimumSize: const Size(0, 0),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
      alignment: Alignment.center,
      textStyle: button1(),
    ).copyWith(
      overlayColor: isRipple
          ? MaterialStateProperty.all(this.fitColors.grey600.withOpacity(0.2))
          : MaterialStateProperty.all(Colors.transparent), // 리플 제거
      shadowColor: MaterialStateProperty.all(Colors.transparent),
      surfaceTintColor: MaterialStateProperty.all(Colors.transparent),
    );
  }

  ButtonStyle btnStyleTertiary({bool isRipple = false}) {
    return ElevatedButton.styleFrom(
      foregroundColor: this.fitColors.textDisabled,
      backgroundColor: this.fitColors.fillStrong,
      disabledForegroundColor: this.fitColors.textTertiary,
      disabledBackgroundColor: this.fitColors.fillAlternative,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100.r),
        side: const BorderSide(
          color: Colors.transparent,
          width: 1.0,
        ),
      ),
      elevation: 0,
      padding: EdgeInsets.zero,
      minimumSize: const Size(0, 0),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
      alignment: Alignment.center,
      textStyle: button1(),
    ).copyWith(
      overlayColor: isRipple
          ? MaterialStateProperty.all(this.fitColors.grey600.withOpacity(0.2))
          : MaterialStateProperty.all(Colors.transparent),
      shadowColor: MaterialStateProperty.all(Colors.transparent),
      surfaceTintColor: MaterialStateProperty.all(Colors.transparent),
    );
  }

  ButtonStyle btnStylePrimary({bool isRipple = false}) {
    return ElevatedButton.styleFrom(
      foregroundColor: this.fitColors.staticBlack,
      backgroundColor: this.fitColors.main,
      disabledForegroundColor: ColorName.grey0Dark,
      disabledBackgroundColor: this.fitColors.green50,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100.r),
        side: const BorderSide(
          color: Colors.transparent,
          width: 1.0,
        ),
      ),
      elevation: 0,
      shadowColor: Colors.transparent,
      padding: EdgeInsets.zero,
      minimumSize: const Size(0, 0),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
      alignment: Alignment.center,
      textStyle: button1().copyWith(color: this.fitColors.staticBlack),
    ).copyWith(
      overlayColor: isRipple
          ? MaterialStateProperty.all(this.fitColors.grey600.withOpacity(0.2))
          : MaterialStateProperty.all(Colors.transparent),
      shadowColor: MaterialStateProperty.all(Colors.transparent),
      surfaceTintColor: MaterialStateProperty.all(Colors.transparent),
    );
  }

  ButtonStyle btnStyleGhost({
    bool isRipple = false,
    required bool isEnabled,
  }) {
    return ElevatedButton.styleFrom(
      foregroundColor: this.fitColors.grey900,
      backgroundColor: Colors.transparent,
      disabledForegroundColor: this.fitColors.grey300,
      disabledBackgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100.r),
        side: BorderSide(
          color: isEnabled ? this.fitColors.grey400 : this.fitColors.grey200,
          width: 1.0,
        ),
      ),
      elevation: 0,
      padding: EdgeInsets.zero,
      minimumSize: const Size(0, 0),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
      alignment: Alignment.center,
      textStyle: button1(),
    ).copyWith(
      overlayColor: isRipple
          ? MaterialStateProperty.all(this.fitColors.grey600.withOpacity(0.2))
          : MaterialStateProperty.all(Colors.transparent),
      shadowColor: MaterialStateProperty.all(Colors.transparent),
      surfaceTintColor: MaterialStateProperty.all(Colors.transparent),
    );
  }

  ButtonStyle btnStyleDestructive({bool isRipple = false}) {
    return ElevatedButton.styleFrom(
      foregroundColor: this.fitColors.staticWhite,
      backgroundColor: this.fitColors.red500,
      disabledForegroundColor: this.fitColors.inverseDisabled,
      disabledBackgroundColor: this.fitColors.red50,
      elevation: 0,
      padding: EdgeInsets.zero,
      minimumSize: const Size(0, 0),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
      alignment: Alignment.center,
      textStyle: button1(),
    ).copyWith(
      overlayColor: isRipple
          ? MaterialStateProperty.all(this.fitColors.grey600.withOpacity(0.2))
          : MaterialStateProperty.all(Colors.transparent),
      shadowColor: MaterialStateProperty.all(Colors.transparent),
      surfaceTintColor: MaterialStateProperty.all(Colors.transparent),
    );
  }
}
