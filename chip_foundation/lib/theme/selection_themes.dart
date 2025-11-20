import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../colors.dart';

/// Checkbox 테마
CheckboxThemeData checkboxTheme(FitColors colors) {
  return CheckboxThemeData(
    side: BorderSide(width: 1.5, color: colors.grey400),
    splashRadius: 0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r)),
    checkColor: WidgetStateProperty.all(Colors.black),
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) return colors.main;
      return Colors.transparent;
    }),
    overlayColor: WidgetStateProperty.all(Colors.transparent),
  );
}

/// Radio 테마
RadioThemeData radioTheme(FitColors colors) {
  return RadioThemeData(
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) return colors.main;
      return colors.grey400;
    }),
    overlayColor: WidgetStateProperty.all(Colors.transparent),
  );
}

/// Switch 테마
SwitchThemeData switchTheme(FitColors colors) {
  return SwitchThemeData(
    thumbColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) return colors.staticWhite;
      return colors.grey400;
    }),
    trackColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) return colors.main;
      return colors.fillStrong;
    }),
    trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
    overlayColor: WidgetStateProperty.all(Colors.transparent),
  );
}

/// Slider 테마
SliderThemeData sliderTheme(FitColors colors) {
  return SliderThemeData(
    activeTrackColor: colors.main,
    inactiveTrackColor: colors.fillStrong,
    thumbColor: colors.main,
    overlayColor: colors.main.withValues(alpha: 0.12),
  );
}
