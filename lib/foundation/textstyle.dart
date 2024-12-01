import 'package:chipfit/foundation/colors.dart';
import 'package:chipfit/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:chipfit/foundation/colors.dart';
import 'package:chipfit/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum FitTextSp { MIN, MAX, SP }

extension FitTextStyleExtension on BuildContext {
  TextStyle headLine1({
    Color? color,
    FitTextSp type = FitTextSp.MIN,
    double height = 1.4,
    bool isUnderlined = false,
    Color? decorationColor,
  }) {
    return TextStyle(
      fontSize: _resolveFontSize(28, type),
      letterSpacing: -0.06,
      height: height,
      fontStyle: FontStyle.normal,
      fontFamily: FontFamily.pretendardSemiBold,
      color: color ?? this.fitColors.white,
      decoration: isUnderlined ? TextDecoration.underline : TextDecoration.none,
      decorationColor: decorationColor,
    );
  }

  TextStyle headLine2({
    Color? color,
    FitTextSp type = FitTextSp.MIN,
    double height = 1.4,
    bool isUnderlined = false,
    Color? decorationColor,
  }) {
    return TextStyle(
      fontSize: _resolveFontSize(24, type),
      letterSpacing: -0.06,
      height: height,
      fontStyle: FontStyle.normal,
      fontFamily: FontFamily.pretendardSemiBold,
      color: color ?? this.fitColors.white,
      decoration: isUnderlined ? TextDecoration.underline : TextDecoration.none,
      decorationColor: decorationColor,
    );
  }

  TextStyle headLine3({
    Color? color,
    FitTextSp type = FitTextSp.MIN,
    double height = 1.4,
    bool isUnderlined = false,
    Color? decorationColor,
  }) {
    return TextStyle(
      fontSize: _resolveFontSize(20, type),
      letterSpacing: -0.06,
      height: height,
      fontStyle: FontStyle.normal,
      fontFamily: FontFamily.pretendardSemiBold,
      color: color ?? this.fitColors.white,
      decoration: isUnderlined ? TextDecoration.underline : TextDecoration.none,
      decorationColor: decorationColor,
    );
  }

  TextStyle subTitle1Bold({
    Color? color,
    FitTextSp type = FitTextSp.MIN,
    double height = 1.4,
    bool isUnderlined = false,
    Color? decorationColor,
  }) {
    return TextStyle(
      fontSize: _resolveFontSize(22, type),
      letterSpacing: -0.06,
      fontStyle: FontStyle.normal,
      fontFamily: FontFamily.pretendardBold,
      color: color ?? this.fitColors.white,
      decoration: isUnderlined ? TextDecoration.underline : TextDecoration.none,
      decorationColor: decorationColor,
    );
  }

  TextStyle subTitle1Medium({
    Color? color,
    FitTextSp type = FitTextSp.MIN,
    double height = 1.4,
    bool isUnderlined = false,
    Color? decorationColor,
  }) {
    return TextStyle(
      fontSize: _resolveFontSize(22, type),
      letterSpacing: -0.06,
      fontStyle: FontStyle.normal,
      fontFamily: FontFamily.pretendardMedium,
      color: color ?? this.fitColors.white,
      decoration: isUnderlined ? TextDecoration.underline : TextDecoration.none,
      decorationColor: decorationColor,
    );
  }

  TextStyle subTitle2SemiBold({
    Color? color,
    FitTextSp type = FitTextSp.MIN,
    double height = 1.0,
    bool isUnderlined = false,
    Color? decorationColor,
  }) {
    return TextStyle(
      fontSize: _resolveFontSize(20, type),
      letterSpacing: -0.06,
      height: height,
      fontStyle: FontStyle.normal,
      fontFamily: FontFamily.pretendardSemiBold,
      color: color ?? this.fitColors.white,
      decoration: isUnderlined ? TextDecoration.underline : TextDecoration.none,
      decorationColor: decorationColor,
    );
  }

  TextStyle subTitle2Medium({
    Color? color,
    FitTextSp type = FitTextSp.MIN,
    double height = 1.4,
    bool isUnderlined = false,
    Color? decorationColor,
  }) {
    return TextStyle(
      fontSize: _resolveFontSize(20, type),
      letterSpacing: -0.06,
      fontStyle: FontStyle.normal,
      fontFamily: FontFamily.pretendardMedium,
      color: color ?? this.fitColors.white,
      decoration: isUnderlined ? TextDecoration.underline : TextDecoration.none,
      decorationColor: decorationColor,
    );
  }

  TextStyle body1Semibold({
    Color? color,
    FitTextSp type = FitTextSp.MIN,
    double height = 1.4,
    bool isUnderlined = false,
    Color? decorationColor,
  }) {
    return TextStyle(
      fontSize: _resolveFontSize(18, type),
      height: height,
      letterSpacing: -0.06,
      fontStyle: FontStyle.normal,
      fontFamily: FontFamily.pretendardSemiBold,
      color: color ?? this.fitColors.white,
      decoration: isUnderlined ? TextDecoration.underline : TextDecoration.none,
      decorationColor: decorationColor,
    );
  }

  TextStyle body1Regular({
    Color? color,
    FitTextSp type = FitTextSp.MIN,
    double height = 1.4,
    bool isUnderlined = false,
    Color? decorationColor,
  }) {
    return TextStyle(
      fontSize: _resolveFontSize(18, type),
      height: height,
      letterSpacing: -0.06,
      fontStyle: FontStyle.normal,
      fontFamily: FontFamily.pretendardRegular,
      color: color ?? this.fitColors.white,
      decoration: isUnderlined ? TextDecoration.underline : TextDecoration.none,
      decorationColor: decorationColor,
    );
  }

  TextStyle body2Semibold({
    Color? color,
    FitTextSp type = FitTextSp.MIN,
    double height = 1.0,
    bool isUnderlined = false,
    Color? decorationColor,
  }) {
    return TextStyle(
      fontSize: _resolveFontSize(16, type),
      height: height,
      letterSpacing: -0.06,
      fontStyle: FontStyle.normal,
      fontFamily: FontFamily.pretendardSemiBold,
      color: color ?? this.fitColors.white,
      decoration: isUnderlined ? TextDecoration.underline : TextDecoration.none,
      decorationColor: decorationColor,
    );
  }

  TextStyle body2Regular({
    Color? color,
    FitTextSp type = FitTextSp.MIN,
    double height = 1.4,
    bool isUnderlined = false,
    Color? decorationColor,
  }) {
    return TextStyle(
      fontSize: _resolveFontSize(16, type),
      letterSpacing: -0.06,
      height: height,
      fontStyle: FontStyle.normal,
      fontFamily: FontFamily.pretendardRegular,
      color: color ?? this.fitColors.white,
      decoration: isUnderlined ? TextDecoration.underline : TextDecoration.none,
      decorationColor: decorationColor,
    );
  }

  TextStyle body3Semibold({
    Color? color,
    FitTextSp type = FitTextSp.MIN,
    double height = 1.0,
    bool isUnderlined = false,
    Color? decorationColor,
  }) {
    return TextStyle(
      fontSize: _resolveFontSize(15, type),
      letterSpacing: -0.06,
      height: height,
      fontStyle: FontStyle.normal,
      fontFamily: FontFamily.pretendardSemiBold,
      color: color ?? this.fitColors.white,
      decoration: isUnderlined ? TextDecoration.underline : TextDecoration.none,
      decorationColor: decorationColor,
    );
  }

  TextStyle body3Regular({
    Color? color,
    FitTextSp type = FitTextSp.MIN,
    double height = 1.4,
    bool isUnderlined = false,
    Color? decorationColor,
  }) {
    return TextStyle(
      fontSize: _resolveFontSize(15, type),
      height: height,
      letterSpacing: -0.06,
      fontStyle: FontStyle.normal,
      fontFamily: FontFamily.pretendardRegular,
      color: color ?? this.fitColors.white,
      decoration: isUnderlined ? TextDecoration.underline : TextDecoration.none,
      decorationColor: decorationColor,
    );
  }

  TextStyle button1Medium({
    Color? color,
    FitTextSp type = FitTextSp.MIN,
    double height = 1.0,
    bool isUnderlined = false,
    Color? decorationColor,
  }) {
    return TextStyle(
      fontSize: _resolveFontSize(18, type),
      letterSpacing: -0.06,
      fontStyle: FontStyle.normal,
      fontFamily: FontFamily.pretendardMedium,
      color: color ?? this.fitColors.white,
      decoration: isUnderlined ? TextDecoration.underline : TextDecoration.none,
      decorationColor: decorationColor,
    );
  }

  TextStyle caption1SemiBold({
    Color? color,
    FitTextSp type = FitTextSp.MIN,
    double height = 1.4,
    bool isUnderlined = false,
    Color? decorationColor,
  }) {
    return TextStyle(
      fontSize: _resolveFontSize(14, type),
      height: height,
      letterSpacing: -0.06,
      fontStyle: FontStyle.normal,
      fontFamily: FontFamily.pretendardSemiBold,
      color: color ?? this.fitColors.white,
      decoration: isUnderlined ? TextDecoration.underline : TextDecoration.none,
      decorationColor: decorationColor,
    );
  }

  TextStyle caption2Regular({
    Color? color,
    FitTextSp type = FitTextSp.MIN,
    double height = 1.4,
    bool isUnderlined = false,
    Color? decorationColor,
  }) {
    return TextStyle(
      fontSize: _resolveFontSize(14, type),
      height: height,
      letterSpacing: -0.06,
      fontStyle: FontStyle.normal,
      fontFamily: FontFamily.pretendardRegular,
      color: color ?? this.fitColors.white,
      decoration: isUnderlined ? TextDecoration.underline : TextDecoration.none,
      decorationColor: decorationColor,
    );
  }

  TextStyle caption3Semibold({
    Color? color,
    FitTextSp type = FitTextSp.MIN,
    double height = 1.3,
    bool isUnderlined = false,
    Color? decorationColor,
  }) {
    return TextStyle(
      fontSize: _resolveFontSize(12, type),
      height: height,
      letterSpacing: -0.06,
      fontStyle: FontStyle.normal,
      fontFamily: FontFamily.pretendardSemiBold,
      color: color ?? this.fitColors.white,
      decoration: isUnderlined ? TextDecoration.underline : TextDecoration.none,
      decorationColor: decorationColor,
    );
  }

  TextStyle neodgm({
    Color? color,
    FitTextSp type = FitTextSp.MIN,
    double height = 1.3,
    double fontSize = 30,
    bool isUnderlined = false,
    Color? decorationColor,
  }) {
    return TextStyle(
      fontSize: _resolveFontSize(fontSize, type),
      height: height,
      letterSpacing: -0.06,
      fontStyle: FontStyle.normal,
      fontFamily: FontFamily.neodgm,
      color: color ?? this.fitColors.white,
      decoration: isUnderlined ? TextDecoration.underline : TextDecoration.none,
      decorationColor: decorationColor,
    );
  }

  double _resolveFontSize(double baseSize, FitTextSp type) {
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

