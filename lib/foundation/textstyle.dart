import 'package:chipfit/gen/fonts.gen.dart';
import 'package:chipfit/foundation/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension FitTextStyleExtension on BuildContext {
  TextStyle headLine1({
    Color? color,
    double height = 1.4,
  }) {
    return TextStyle(
      fontSize: 28.spMin,
      letterSpacing: -0.06,
      height: height,
      fontStyle: FontStyle.normal,
      fontFamily: FontFamily.pretendardSemiBold,
      color: color ?? this.fitColors.grey900,
    );
  }

  TextStyle headLine2({
    Color? color,
    bool isSpMax = false,
    double height = 1.4,
  }) {
    return TextStyle(
      fontSize: isSpMax ? 24.spMax : 24.spMin,
      letterSpacing: -0.06,
      height: height,
      fontStyle: FontStyle.normal,
      fontFamily: FontFamily.pretendardSemiBold,
      color: color ?? this.fitColors.grey900,
    );
  }

  TextStyle headLine3({
    Color? color,
    bool isSpMax = false,
    double height = 1.4,
  }) {
    return TextStyle(
      fontSize: isSpMax ? 20.spMax : 20.spMin,
      letterSpacing: -0.06,
      fontStyle: FontStyle.normal,
      height: height,
      fontFamily: FontFamily.pretendardSemiBold,
      color: color ?? this.fitColors.grey900,
    );
  }

  TextStyle subTitle1Bold({Color? color}) {
    return TextStyle(
      fontSize: 22.spMin,
      letterSpacing: -0.06,
      fontStyle: FontStyle.normal,
      fontFamily: FontFamily.pretendardBold,
      color: color ?? this.fitColors.grey900,
    );
  }

  TextStyle subTitle1Medium({Color? color}) {
    return TextStyle(
      fontSize: 22.spMin,
      letterSpacing: -0.06,
      fontStyle: FontStyle.normal,
      fontFamily: FontFamily.pretendardMedium,
      color: color ?? this.fitColors.grey900,
    );
  }

  TextStyle subTitle2SemiBold({
    Color? color,
    double height = 1.0,
  }) {
    return TextStyle(
      fontSize: 20.spMin,
      letterSpacing: -0.06,
      height: height,
      fontStyle: FontStyle.normal,
      fontFamily: FontFamily.pretendardSemiBold,
      color: color ?? this.fitColors.grey900,
    );
  }

  TextStyle subTitle2Medium({Color? color}) {
    return TextStyle(
      fontSize: 20.spMin,
      letterSpacing: -0.06,
      fontStyle: FontStyle.normal,
      fontFamily: FontFamily.pretendardMedium,
      color: color ?? this.fitColors.grey900,
    );
  }

  TextStyle body1Semibold({
    Color? color,
    double height = 1.0,
  }) {
    return TextStyle(
      fontSize: 18.spMin,
      height: height,
      letterSpacing: -0.06,
      fontStyle: FontStyle.normal,
      fontFamily: FontFamily.pretendardSemiBold,
      color: color ?? this.fitColors.grey900,
    );
  }

  TextStyle body1Regular({
    Color? color,
    double height = 1.4,
  }) {
    return TextStyle(
      fontSize: 18.spMin,
      height: height,
      letterSpacing: -0.06,
      fontStyle: FontStyle.normal,
      fontFamily: FontFamily.pretendardRegular,
      color: color ?? this.fitColors.grey900,
    );
  }

  TextStyle body2Semibold({
    Color? color,
    double height = 1.0,
  }) {
    return TextStyle(
      fontSize: 16.spMin,
      height: height,
      letterSpacing: -0.06,
      fontStyle: FontStyle.normal,
      fontFamily: FontFamily.pretendardSemiBold,
      color: color ?? this.fitColors.grey900,
    );
  }

  TextStyle body2Regular({
    Color? color,
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
      color: color ?? this.fitColors.grey900,
      decoration: isUnderlined ? TextDecoration.underline : TextDecoration.none,
      decorationColor: decorationColor,
    );
  }

  TextStyle body3Semibold({
    Color? color,
    double height = 1.0,
  }) {
    return TextStyle(
      fontSize: 15.spMin,
      letterSpacing: -0.06,
      height: height,
      fontStyle: FontStyle.normal,
      fontFamily: FontFamily.pretendardSemiBold,
      color: color ?? this.fitColors.grey900,
    );
  }

  TextStyle body3Regular({
    Color? color,
    double height = 1.4,
  }) {
    return TextStyle(
      fontSize: 15.spMin,
      height: height,
      letterSpacing: -0.06,
      fontStyle: FontStyle.normal,
      fontFamily: FontFamily.pretendardRegular,
      color: color ?? this.fitColors.grey900,
    );
  }

  TextStyle button1Medium({Color? color}) {
    return TextStyle(
      fontSize: 18.spMin,
      letterSpacing: -0.06,
      fontStyle: FontStyle.normal,
      fontFamily: FontFamily.pretendardMedium,
      color: color ?? this.fitColors.grey900,
    );
  }

  TextStyle caption1SemiBold({
    Color? color,
    double height = 1.4,
    bool isSpMax = false,
  }) {
    return TextStyle(
      fontSize: isSpMax ? 14.spMax : 14.spMin,
      height: height,
      letterSpacing: -0.06,
      fontStyle: FontStyle.normal,
      fontFamily: FontFamily.pretendardSemiBold,
      color: color ?? this.fitColors.grey900,
    );
  }

  TextStyle caption2Regular({
    Color? color,
    double height = 1.4,
  }) {
    return TextStyle(
      fontSize: 14.spMin,
      height: height,
      letterSpacing: -0.06,
      fontStyle: FontStyle.normal,
      fontFamily: FontFamily.pretendardRegular,
      color: color ?? this.fitColors.grey900,
    );
  }

  TextStyle caption3Semibold({
    Color? color,
    double height = 1.3,
  }) {
    return TextStyle(
      fontSize: 12.spMin,
      height: height,
      letterSpacing: -0.06,
      fontStyle: FontStyle.normal,
      fontFamily: FontFamily.pretendardSemiBold,
      color: color ?? this.fitColors.grey900,
    );
  }

  TextStyle neodgm({
    Color? color,
    double height = 1.3,
    double fontSize = 30,
  }) {
    return TextStyle(
      fontSize: fontSize.spMin,
      height: height,
      letterSpacing: -0.06,
      fontStyle: FontStyle.normal,
      fontFamily: FontFamily.neodgm,
      color: color ?? this.fitColors.grey900,
    );
  }
}
