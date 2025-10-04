import 'package:chip_assets/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'colors.dart';

enum FitTextSp { MIN, MAX, SP }

extension FitTextStyleExtension on BuildContext {
  TextStyle h1({FitTextSp type = FitTextSp.MIN}) {
    return TextStyle(
      fontSize: _getFontSize(28, type),
      letterSpacing: -0.06,
      height: 1.4,
      color: fitColors(this).grey900,
      fontStyle: FontStyle.normal,
      fontFamily: FontFamily.pretendardSemiBold,
    );
  }

  TextStyle h2({FitTextSp type = FitTextSp.MIN}) {
    return TextStyle(
      fontSize: _getFontSize(24, type),
      letterSpacing: -0.06,
      height: 1.4,
      color: fitColors(this).grey900,
      fontStyle: FontStyle.normal,
      fontFamily: FontFamily.pretendardSemiBold,
    );
  }

  TextStyle subtitle1({FitTextSp type = FitTextSp.MIN}) {
    return TextStyle(
      fontSize: _getFontSize(20, type),
      letterSpacing: -0.06,
      height: 1.4,
      fontStyle: FontStyle.normal,
      fontFamily: FontFamily.pretendardSemiBold,
    );
  }

  TextStyle subtitle2({FitTextSp type = FitTextSp.MIN}) {
    return TextStyle(
      fontSize: _getFontSize(20, type),
      letterSpacing: -0.06,
      height: 1.4,
      fontStyle: FontStyle.normal,
      fontFamily: FontFamily.pretendardMedium,
    );
  }

  TextStyle subtitle3({FitTextSp type = FitTextSp.MIN}) {
    return TextStyle(
      fontSize: _getFontSize(18, type),
      letterSpacing: -0.06,
      height: 1.4,
      fontStyle: FontStyle.normal,
      fontFamily: FontFamily.pretendardSemiBold,
    );
  }

  TextStyle subtitle4({FitTextSp type = FitTextSp.MIN}) {
    return TextStyle(
      fontSize: _getFontSize(16, type),
      letterSpacing: -0.06,
      height: 1.4,
      fontStyle: FontStyle.normal,
      fontFamily: FontFamily.pretendardSemiBold,
    );
  }

  TextStyle subtitle5({FitTextSp type = FitTextSp.MIN}) {
    return TextStyle(
      fontSize: _getFontSize(15, type),
      letterSpacing: -0.06,
      height: 1.4,
      fontStyle: FontStyle.normal,
      fontFamily: FontFamily.pretendardSemiBold,
    );
  }

  TextStyle subtitle6({FitTextSp type = FitTextSp.MIN}) {
    return TextStyle(
      fontSize: _getFontSize(14, type),
      letterSpacing: -0.06,
      height: 1.4,
      fontStyle: FontStyle.normal,
      fontFamily: FontFamily.pretendardSemiBold,
    );
  }

  TextStyle body1({FitTextSp type = FitTextSp.MIN}) {
    return TextStyle(
      fontSize: _getFontSize(18, type),
      letterSpacing: -0.06,
      height: 1.4,
      fontStyle: FontStyle.normal,
      fontFamily: FontFamily.pretendardRegular,
    );
  }

  TextStyle body2({FitTextSp type = FitTextSp.MIN}) {
    return TextStyle(
      fontSize: _getFontSize(16, type),
      letterSpacing: -0.06,
      height: 1.4,
      fontStyle: FontStyle.normal,
      fontFamily: FontFamily.pretendardRegular,
    );
  }

  TextStyle body3({FitTextSp type = FitTextSp.MIN}) {
    return TextStyle(
      fontSize: _getFontSize(15, type),
      letterSpacing: -0.06,
      height: 1.4,
      fontStyle: FontStyle.normal,
      fontFamily: FontFamily.pretendardRegular,
    );
  }

  TextStyle body4({FitTextSp type = FitTextSp.MIN}) {
    return TextStyle(
      fontSize: _getFontSize(14, type),
      letterSpacing: -0.06,
      height: 1.4,
      fontStyle: FontStyle.normal,
      fontFamily: FontFamily.pretendardRegular,
    );
  }

  TextStyle button1({FitTextSp type = FitTextSp.MIN}) {
    return TextStyle(
      fontSize: _getFontSize(18, type),
      letterSpacing: -0.06,
      height: 1.4,
      fontStyle: FontStyle.normal,
      fontFamily: FontFamily.pretendardMedium,
    );
  }

  TextStyle caption1({FitTextSp type = FitTextSp.MIN}) {
    return TextStyle(
      fontSize: _getFontSize(12, type),
      letterSpacing: -0.06,
      height: 1.0,
      fontStyle: FontStyle.normal,
      fontFamily: FontFamily.pretendardSemiBold,
    );
  }

  TextStyle caption2({FitTextSp type = FitTextSp.MIN}) {
    return TextStyle(
      fontSize: _getFontSize(10, type),
      letterSpacing: -0.06,
      height: 1.0,
      fontStyle: FontStyle.normal,
      fontFamily: FontFamily.pretendardSemiBold,
    );
  }

  TextStyle neodgm({FitTextSp type = FitTextSp.MIN}) {
    return TextStyle(
      fontSize: _getFontSize(30, type),
      letterSpacing: -0.06,
      height: 1.0,
      fontStyle: FontStyle.normal,
      fontFamily: FontFamily.neodgm,
    );
  }

  double _getFontSize(double baseSize, FitTextSp type) {
    switch (type) {
      case FitTextSp.MIN:
        return baseSize.spMin;
      case FitTextSp.MAX:
        return baseSize.spMax;
      case FitTextSp.SP:
      default:
        return baseSize.sp;
    }
  }
}
