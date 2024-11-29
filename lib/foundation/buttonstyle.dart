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
  ButtonStyle getButtonStyle(FitButtonType? type) {
    switch (type) {
      case FitButtonType.secondary:
        return btnStyleSecondary();
      case FitButtonType.tertiary:
        return btnStyleTertiary();
      case FitButtonType.primary:
        return btnStylePrimary();
      case FitButtonType.line:
        return btnStyleLine();
      default:
        return btnStylePrimary(); // 기본 스타일
    }
  }

  ButtonStyle btnStyleSecondary() {
    return ElevatedButton.styleFrom(
      foregroundColor: this.fitColors.grey900,
      backgroundColor: this.fitColors.white,
      disabledForegroundColor: this.fitColors.grey400,
      disabledBackgroundColor: this.fitColors.grey600,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.r), // 둥근 모서리
        side: const BorderSide(
          color: Colors.transparent, // 테두리 색상
          width: 1.0,
        ),
      ),
      elevation: 0,
      padding: EdgeInsets.zero,
      minimumSize: const Size(0, 0),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
      alignment: Alignment.center,
      textStyle: button1Medium(),
    );
  }

  ButtonStyle btnStyleTertiary() {
    return ElevatedButton.styleFrom(
      foregroundColor: this.fitColors.white,
      backgroundColor: this.fitColors.grey900,
      disabledForegroundColor: this.fitColors.grey800,
      disabledBackgroundColor: this.fitColors.grey500,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.r), // 둥근 모서리
        side: const BorderSide(
          color: Colors.transparent, // 테두리 색상
          width: 1.0,
        ),
      ),
      elevation: 0,
      padding: EdgeInsets.zero,
      minimumSize: const Size(0, 0),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
      alignment: Alignment.center,
      textStyle: button1Medium(),
    );
  }

  ButtonStyle btnStylePrimary() {
    return ElevatedButton.styleFrom(
      foregroundColor: this.fitColors.grey800,
      backgroundColor: this.fitColors.primary,
      disabledForegroundColor: this.fitColors.grey900,
      disabledBackgroundColor: this.fitColors.primary.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.r), // 둥근 모서리
        side: const BorderSide(
          color: Colors.transparent, // 테두리 색상
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
      textStyle: button1Medium(),
    );
  }

  ButtonStyle btnStyleLine() {
    return ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: Colors.transparent,
      disabledForegroundColor: this.fitColors.white.withOpacity(0.5),
      disabledBackgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.r), // 둥근 모서리
        side: BorderSide(
          color: this.fitColors.grey600, // 테두리 색상
          width: 1.0,
        ),
      ),
      elevation: 0,
      padding: EdgeInsets.zero,
      minimumSize: const Size(0, 0),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
      alignment: Alignment.center,
      textStyle: button1Medium(),
    );
  }

  ButtonStyle btnStyleNegative() {
    return ElevatedButton.styleFrom(
      foregroundColor: this.fitColors.negative,
      backgroundColor: this.fitColors.negativeLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.r), // 둥근 모서리
        side: BorderSide(
          color: this.fitColors.negative, // 테두리 색상
          width: 1.0,
        ),
      ),
      elevation: 0,
      padding: EdgeInsets.zero,
      textStyle: button1Medium(),
    );
  }
}
