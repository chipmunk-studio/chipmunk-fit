import 'package:chipfit/foundation/colors.dart';
import 'package:chipfit/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      fontSize: _getFontSize(14, type),
      letterSpacing: -0.06,
      height: 1.4,
      fontStyle: FontStyle.normal,
      fontFamily: FontFamily.pretendardSemiBold,
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
      fontSize: _getFontSize(fontSize, type),
      height: height,
      letterSpacing: -0.06,
      fontStyle: FontStyle.normal,
      fontFamily: FontFamily.neodgm,
      decoration: isUnderlined ? TextDecoration.underline : TextDecoration.none,
      decorationColor: decorationColor,
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

  /// Figma의 Letter Spacing(% 값)을 Flutter의 `letterSpacing` 값으로 변환하는 함수
  ///
  /// [fontSize]: 텍스트의 폰트 크기 (Figma의 "Size" 값)
  /// [letterPercentage]: Figma의 "Letter Spacing" 값 (-2%는 -2로 전달)
  ///
  /// 예: `convertLetterSpacing(20, -2)`는 `-0.4`를 반환
  double _convertLetterSpacing(double fontSize, double letterPercentage) {
    return fontSize * (letterPercentage / 100);
  }
}
