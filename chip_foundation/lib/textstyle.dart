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
  // 기본 설정
  static const _letterSpacing = -0.06;
  static const _defaultHeight = 1.4;
  static const _compactHeight = 1.0;

  // === Heading Styles ===

  TextStyle h1({FitTextSp type = FitTextSp.MIN}) => _style(
        fontSize: 28,
        type: type,
        fontFamily: FontFamily.pretendardSemiBold,
        color: fitColors.textPrimary,
      );

  TextStyle h2({FitTextSp type = FitTextSp.MIN}) => _style(
        fontSize: 24,
        type: type,
        fontFamily: FontFamily.pretendardSemiBold,
        color: fitColors.textPrimary,
      );

  TextStyle h3({FitTextSp type = FitTextSp.MIN}) => _style(
        fontSize: 20,
        type: type,
        fontFamily: FontFamily.pretendardSemiBold,
        color: fitColors.textPrimary,
      );

  // === Subtitle Styles ===

  TextStyle subtitle1({FitTextSp type = FitTextSp.MIN}) => _style(
        fontSize: 20,
        type: type,
        fontFamily: FontFamily.pretendardSemiBold,
      );

  TextStyle subtitle2({FitTextSp type = FitTextSp.MIN}) => _style(
        fontSize: 20,
        type: type,
        fontFamily: FontFamily.pretendardMedium,
      );

  TextStyle subtitle3({FitTextSp type = FitTextSp.MIN}) => _style(
        fontSize: 18,
        type: type,
        fontFamily: FontFamily.pretendardSemiBold,
      );

  TextStyle subtitle4({FitTextSp type = FitTextSp.MIN}) => _style(
        fontSize: 16,
        type: type,
        fontFamily: FontFamily.pretendardSemiBold,
      );

  TextStyle subtitle5({FitTextSp type = FitTextSp.MIN}) => _style(
        fontSize: 15,
        type: type,
        fontFamily: FontFamily.pretendardSemiBold,
      );

  TextStyle subtitle6({FitTextSp type = FitTextSp.MIN}) => _style(
        fontSize: 14,
        type: type,
        fontFamily: FontFamily.pretendardSemiBold,
      );

  // === Body Styles ===

  TextStyle body1({FitTextSp type = FitTextSp.MIN}) => _style(
        fontSize: 18,
        type: type,
        fontFamily: FontFamily.pretendardRegular,
      );

  TextStyle body2({FitTextSp type = FitTextSp.MIN}) => _style(
        fontSize: 16,
        type: type,
        fontFamily: FontFamily.pretendardRegular,
      );

  TextStyle body3({FitTextSp type = FitTextSp.MIN}) => _style(
        fontSize: 15,
        type: type,
        fontFamily: FontFamily.pretendardRegular,
      );

  TextStyle body4({FitTextSp type = FitTextSp.MIN}) => _style(
        fontSize: 14,
        type: type,
        fontFamily: FontFamily.pretendardRegular,
      );

  // === Button Style ===

  TextStyle button1({FitTextSp type = FitTextSp.MIN}) => _style(
        fontSize: 18,
        type: type,
        fontFamily: FontFamily.pretendardMedium,
        height: _compactHeight,
      );

  // === Caption Styles ===

  TextStyle caption1({FitTextSp type = FitTextSp.MIN}) => _style(
        fontSize: 12,
        type: type,
        fontFamily: FontFamily.pretendardSemiBold,
        height: _compactHeight,
      );

  TextStyle caption2({FitTextSp type = FitTextSp.MIN}) => _style(
        fontSize: 10,
        type: type,
        fontFamily: FontFamily.pretendardSemiBold,
        height: _compactHeight,
      );

  // === Special Fonts ===

  TextStyle neodgm({FitTextSp type = FitTextSp.MIN}) => _style(
        fontSize: 30,
        type: type,
        fontFamily: FontFamily.neodgm,
        height: _compactHeight,
      );

  /// 공통 텍스트 스타일 생성
  TextStyle _style({
    required double fontSize,
    required FitTextSp type,
    required String fontFamily,
    double height = _defaultHeight,
    Color? color,
  }) {
    return TextStyle(
      fontSize: _fontSize(fontSize, type),
      letterSpacing: _letterSpacing,
      height: height,
      color: color,
      fontStyle: FontStyle.normal,
      fontFamily: fontFamily,
      leadingDistribution: TextLeadingDistribution.even,
    );
  }

  /// 폰트 크기 계산
  double _fontSize(double base, FitTextSp type) => switch (type) {
        FitTextSp.MIN => base.spMin,
        FitTextSp.MAX => base.spMax,
        FitTextSp.SP => base.sp,
      };
}
