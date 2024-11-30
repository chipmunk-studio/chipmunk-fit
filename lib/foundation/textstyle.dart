import 'package:chipfit/foundation/colors.dart';
import 'package:chipfit/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension FitTextStyleExtension on BuildContext {
  TextStyle headLine1({
    Color? color,
    bool isSpMax = false,
    double height = 1.4,
    bool isUnderlined = false,
    Color? decorationColor,
  }) {
    return TextStyle(
      fontSize: 28.spMin,
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
    bool isSpMax = false,
    double height = 1.4,
    bool isUnderlined = false,
    Color? decorationColor,
  }) {
    return TextStyle(
      fontSize: isSpMax ? 24.spMax : 24.spMin,
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
    bool isSpMax = false,
    double height = 1.4,
    bool isUnderlined = false,
    Color? decorationColor,
  }) {
    return TextStyle(
      fontSize: isSpMax ? 20.spMax : 20.spMin,
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
    bool isSpMax = false,
    double height = 1.4,
    bool isUnderlined = false,
    Color? decorationColor,
  }) {
    return TextStyle(
      fontSize: 22.spMin,
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
    bool isSpMax = false,
    double height = 1.4,
    bool isUnderlined = false,
    Color? decorationColor,
  }) {
    return TextStyle(
      fontSize: 22.spMin,
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
    bool isSpMax = false,
    double height = 1.0,
    bool isUnderlined = false,
    Color? decorationColor,
  }) {
    return TextStyle(
      fontSize: 20.spMin,
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
    bool isSpMax = false,
    double height = 1.4,
    bool isUnderlined = false,
    Color? decorationColor,
  }) {
    return TextStyle(
      fontSize: 20.spMin,
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
    bool isSpMax = false,
    double height = 1.4,
    bool isUnderlined = false,
    Color? decorationColor,
  }) {
    return TextStyle(
      fontSize: 18.spMin,
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
    bool isSpMax = false,
    double height = 1.4,
    bool isUnderlined = false,
    Color? decorationColor,
  }) {
    return TextStyle(
      fontSize: 18.spMin,
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
    bool isSpMax = false,
    double height = 1.0,
    bool isUnderlined = false,
    Color? decorationColor,
  }) {
    return TextStyle(
      fontSize: 16.spMin,
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
    bool isSpMax = false,
    double height = 1.4,
    bool isUnderlined = false,
    Color? decorationColor,
  }) {
    return TextStyle(
      fontSize: 16.spMin,
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
    bool isSpMax = false,
    double height = 1.0,
    bool isUnderlined = false,
    Color? decorationColor,
  }) {
    return TextStyle(
      fontSize: 15.spMin,
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
    bool isSpMax = false,
    double height = 1.4,
    bool isUnderlined = false,
    Color? decorationColor,
  }) {
    return TextStyle(
      fontSize: 15.spMin,
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
    bool isSpMax = false,
    double height = 1.0,
    bool isUnderlined = false,
    Color? decorationColor,
  }) {
    return TextStyle(
      fontSize: 18.spMin,
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
    bool isSpMax = false,
    double height = 1.4,
    bool isUnderlined = false,
    Color? decorationColor,
  }) {
    return TextStyle(
      fontSize: isSpMax ? 14.spMax : 14.spMin,
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
    bool isSpMax = false,
    double height = 1.4,
    bool isUnderlined = false,
    Color? decorationColor,
  }) {
    return TextStyle(
      fontSize: 14.spMin,
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
    bool isSpMax = false,
    double height = 1.3,
    bool isUnderlined = false,
    Color? decorationColor,
  }) {
    return TextStyle(
      fontSize: 12.spMin,
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
    bool isSpMax = false,
    double height = 1.3,
    double fontSize = 30,
    bool isUnderlined = false,
    Color? decorationColor,
  }) {
    return TextStyle(
      fontSize: isSpMax ? fontSize.spMax : fontSize.spMin,
      height: height,
      letterSpacing: -0.06,
      fontStyle: FontStyle.normal,
      fontFamily: FontFamily.neodgm,
      color: color ?? this.fitColors.white,
      decoration: isUnderlined ? TextDecoration.underline : TextDecoration.none,
      decorationColor: decorationColor,
    );
  }
}
