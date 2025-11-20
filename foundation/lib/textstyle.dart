import 'package:chip_assets/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'colors.dart';

/// 폰트 크기 타입
enum FitTextSp {
  /// 최소 크기 (화면 비율 무시)
  MIN,

  /// 최대 크기 (화면 비율 무시)
  MAX,

  /// 화면 비율 적용
  SP
}

/// BuildContext에 텍스트 스타일 생성 기능 추가
extension FitTextStyleExtension on BuildContext {
  /// 기본 텍스트 스타일 설정
  static const double _defaultLetterSpacing = -0.06;
  static const double _defaultLineHeight = 1.4;
  static const double _captionLineHeight = 1.0;

  // Heading Styles
  TextStyle h1({FitTextSp type = FitTextSp.MIN}) {
    return _createTextStyle(
      fontSize: 28,
      type: type,
      fontFamily: FontFamily.pretendardSemiBold,
      color: this.fitColors.grey900,
    );
  }

  TextStyle h2({FitTextSp type = FitTextSp.MIN}) {
    return _createTextStyle(
      fontSize: 24,
      type: type,
      fontFamily: FontFamily.pretendardSemiBold,
      color: this.fitColors.grey900,
    );
  }

  TextStyle h3({FitTextSp type = FitTextSp.MIN}) {
    return _createTextStyle(
      fontSize: 20,
      type: type,
      fontFamily: FontFamily.pretendardSemiBold,
      color: this.fitColors.grey900,
    );
  }

  // Subtitle Styles
  TextStyle subtitle1({FitTextSp type = FitTextSp.MIN}) {
    return _createTextStyle(
      fontSize: 20,
      type: type,
      fontFamily: FontFamily.pretendardSemiBold,
    );
  }

  TextStyle subtitle2({FitTextSp type = FitTextSp.MIN}) {
    return _createTextStyle(
      fontSize: 20,
      type: type,
      fontFamily: FontFamily.pretendardMedium,
    );
  }

  TextStyle subtitle3({FitTextSp type = FitTextSp.MIN}) {
    return _createTextStyle(
      fontSize: 18,
      type: type,
      fontFamily: FontFamily.pretendardSemiBold,
    );
  }

  TextStyle subtitle4({FitTextSp type = FitTextSp.MIN}) {
    return _createTextStyle(
      fontSize: 16,
      type: type,
      fontFamily: FontFamily.pretendardSemiBold,
    );
  }

  TextStyle subtitle5({FitTextSp type = FitTextSp.MIN}) {
    return _createTextStyle(
      fontSize: 15,
      type: type,
      fontFamily: FontFamily.pretendardSemiBold,
    );
  }

  TextStyle subtitle6({FitTextSp type = FitTextSp.MIN}) {
    return _createTextStyle(
      fontSize: 14,
      type: type,
      fontFamily: FontFamily.pretendardSemiBold,
    );
  }

  // Body Styles
  TextStyle body1({FitTextSp type = FitTextSp.MIN}) {
    return _createTextStyle(
      fontSize: 18,
      type: type,
      fontFamily: FontFamily.pretendardRegular,
    );
  }

  TextStyle body2({FitTextSp type = FitTextSp.MIN}) {
    return _createTextStyle(
      fontSize: 16,
      type: type,
      fontFamily: FontFamily.pretendardRegular,
    );
  }

  TextStyle body3({FitTextSp type = FitTextSp.MIN}) {
    return _createTextStyle(
      fontSize: 15,
      type: type,
      fontFamily: FontFamily.pretendardRegular,
    );
  }

  TextStyle body4({FitTextSp type = FitTextSp.MIN}) {
    return _createTextStyle(
      fontSize: 14,
      type: type,
      fontFamily: FontFamily.pretendardRegular,
    );
  }

  // Button Style
  TextStyle button1({FitTextSp type = FitTextSp.MIN}) {
    return _createTextStyle(
      fontSize: 18,
      type: type,
      fontFamily: FontFamily.pretendardMedium,
      lineHeight: 1.0,
    );
  }

  // Caption Styles
  TextStyle caption1({FitTextSp type = FitTextSp.MIN}) {
    return _createTextStyle(
      fontSize: 12,
      type: type,
      fontFamily: FontFamily.pretendardSemiBold,
      lineHeight: _captionLineHeight,
    );
  }

  TextStyle caption2({FitTextSp type = FitTextSp.MIN}) {
    return _createTextStyle(
      fontSize: 10,
      type: type,
      fontFamily: FontFamily.pretendardSemiBold,
      lineHeight: _captionLineHeight,
    );
  }

  // Special Font
  TextStyle neodgm({FitTextSp type = FitTextSp.MIN}) {
    return _createTextStyle(
      fontSize: 30,
      type: type,
      fontFamily: FontFamily.neodgm,
      lineHeight: _captionLineHeight,
    );
  }

  /// 공통 텍스트 스타일 생성 (중복 코드 제거)
  TextStyle _createTextStyle({
    required double fontSize,
    required FitTextSp type,
    required String fontFamily,
    double lineHeight = _defaultLineHeight,
    Color? color,
  }) {
    return TextStyle(
      fontSize: _getFontSize(fontSize, type),
      letterSpacing: _defaultLetterSpacing,
      height: lineHeight,
      color: color,
      fontStyle: FontStyle.normal,
      fontFamily: fontFamily,
      leadingDistribution: TextLeadingDistribution.even,
    );
  }

  /// 폰트 크기 계산 (타입별 처리)
  double _getFontSize(double baseSize, FitTextSp type) {
    switch (type) {
      case FitTextSp.MIN:
        return baseSize.spMin;
      case FitTextSp.MAX:
        return baseSize.spMax;
      case FitTextSp.SP:
        return baseSize.sp;
    }
  }
}
