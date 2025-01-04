import 'package:chipfit/foundation/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'colors.dart';

enum FitButtonType {
  secondary,
  tertiary,
  line,
  primary,
}

extension ButtonStyleExtension on BuildContext {
  ButtonStyle getButtonStyle(FitButtonType? type, {bool isRipple = false}) {
    switch (type) {
      case FitButtonType.secondary:
        return btnStyleSecondary(isRipple: isRipple);
      case FitButtonType.tertiary:
        return btnStyleTertiary(isRipple: isRipple);
      case FitButtonType.primary:
        return btnStylePrimary(isRipple: isRipple);
      case FitButtonType.line:
        return btnStyleLine(isRipple: isRipple);
      default:
        return btnStylePrimary(isRipple: isRipple); // 기본 스타일
    }
  }

  ButtonStyle btnStyleSecondary({bool isRipple = false}) {
    return ElevatedButton.styleFrom(
      foregroundColor: this.fitColors.grey900,
      backgroundColor: this.fitColors.white,
      disabledForegroundColor: this.fitColors.grey400,
      disabledBackgroundColor: this.fitColors.grey600,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.r),
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
          ? WidgetStateProperty.all(this.fitColors.grey600.withOpacity(0.2))
          : WidgetStateProperty.all(Colors.transparent), // 리플 제거
      shadowColor: WidgetStateProperty.all(Colors.transparent),
      surfaceTintColor: WidgetStateProperty.all(Colors.transparent),
    );
  }

  ButtonStyle btnStyleTertiary({bool isRipple = false}) {
    return ElevatedButton.styleFrom(
      foregroundColor: this.fitColors.white,
      backgroundColor: this.fitColors.grey800,
      disabledForegroundColor: this.fitColors.grey800,
      disabledBackgroundColor: this.fitColors.grey500,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.r),
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
          ? WidgetStateProperty.all(this.fitColors.grey600.withOpacity(0.2))
          : WidgetStateProperty.all(Colors.transparent),
      shadowColor: WidgetStateProperty.all(Colors.transparent),
      surfaceTintColor: WidgetStateProperty.all(Colors.transparent),
    );
  }

  ButtonStyle btnStylePrimary({bool isRipple = false}) {
    return ElevatedButton.styleFrom(
      foregroundColor: this.fitColors.grey800,
      backgroundColor: this.fitColors.primary,
      disabledForegroundColor: this.fitColors.grey900,
      disabledBackgroundColor: this.fitColors.primary.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.r),
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
      textStyle: button1(),
    ).copyWith(
      overlayColor: isRipple
          ? WidgetStateProperty.all(this.fitColors.grey600.withOpacity(0.2))
          : WidgetStateProperty.all(Colors.transparent),
      shadowColor: WidgetStateProperty.all(Colors.transparent),
      surfaceTintColor: WidgetStateProperty.all(Colors.transparent),
    );
  }

  ButtonStyle btnStyleLine({bool isRipple = false}) {
    return ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: Colors.transparent,
      disabledForegroundColor: this.fitColors.white.withOpacity(0.5),
      disabledBackgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.r),
        side: BorderSide(
          color: this.fitColors.grey600,
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
          ? WidgetStateProperty.all(this.fitColors.grey600.withOpacity(0.2))
          : WidgetStateProperty.all(Colors.transparent),
      shadowColor: WidgetStateProperty.all(Colors.transparent),
      surfaceTintColor: WidgetStateProperty.all(Colors.transparent),
    );
  }

  ButtonStyle btnStyleNegative({bool isRipple = false}) {
    return ElevatedButton.styleFrom(
      foregroundColor: this.fitColors.negative,
      backgroundColor: this.fitColors.negativeLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.r),
        side: BorderSide(
          color: this.fitColors.negative,
          width: 1.0,
        ),
      ),
      elevation: 0,
      padding: EdgeInsets.zero,
      textStyle: button1(),
    ).copyWith(
      overlayColor: isRipple
          ? WidgetStateProperty.all(this.fitColors.grey600.withOpacity(0.2))
          : WidgetStateProperty.all(Colors.transparent),
      shadowColor: WidgetStateProperty.all(Colors.transparent),
      surfaceTintColor: WidgetStateProperty.all(Colors.transparent),
    );
  }
}
