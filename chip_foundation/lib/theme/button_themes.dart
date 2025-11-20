import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../colors.dart';
import '../textstyle.dart';

/// FilledButton 테마
FilledButtonThemeData filledButtonTheme(BuildContext context, FitColors colors) {
  return FilledButtonThemeData(
    style: FilledButton.styleFrom(
      minimumSize: Size.zero,
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.r)),
      backgroundColor: colors.main,
      foregroundColor: colors.staticBlack,
      disabledBackgroundColor: colors.green50,
      disabledForegroundColor: colors.inverseDisabled,
      textStyle: context.button1(),
    ).copyWith(
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      elevation: WidgetStateProperty.all(0),
    ),
  );
}

/// ElevatedButton 테마
ElevatedButtonThemeData elevatedButtonTheme(BuildContext context, FitColors colors) {
  return ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      minimumSize: const Size.fromHeight(56),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.r)),
      backgroundColor: colors.main,
      foregroundColor: colors.staticBlack,
      disabledBackgroundColor: colors.green50,
      disabledForegroundColor: colors.inverseDisabled,
      textStyle: context.button1(),
    ).copyWith(
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      elevation: WidgetStateProperty.all(0),
    ),
  );
}

/// OutlinedButton 테마
OutlinedButtonThemeData outlinedButtonTheme(FitColors colors) {
  return OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: colors.textPrimary,
      side: BorderSide(color: colors.grey400),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.r)),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
    ).copyWith(
      overlayColor: WidgetStateProperty.all(Colors.transparent),
    ),
  );
}

/// TextButton 테마
TextButtonThemeData textButtonTheme(FitColors colors) {
  return TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: colors.textPrimary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
    ).copyWith(
      overlayColor: WidgetStateProperty.all(colors.fillAlternative),
    ),
  );
}

/// IconButton 테마
IconButtonThemeData iconButtonTheme(FitColors colors) {
  return IconButtonThemeData(
    style: IconButton.styleFrom(
      foregroundColor: colors.textPrimary,
      disabledForegroundColor: colors.textDisabled,
    ).copyWith(
      overlayColor: WidgetStateProperty.all(colors.fillAlternative),
    ),
  );
}

/// FloatingActionButton 테마
FloatingActionButtonThemeData fabTheme(FitColors colors) {
  return FloatingActionButtonThemeData(
    backgroundColor: colors.main,
    foregroundColor: colors.staticBlack,
    elevation: 0,
    focusElevation: 0,
    hoverElevation: 0,
    highlightElevation: 0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
  );
}
