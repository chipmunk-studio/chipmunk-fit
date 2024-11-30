import 'package:chipfit/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'colors.dart';
import 'textstyle.dart';

ThemeData fitLightTheme(BuildContext context) {
  return ThemeData(
    brightness: Brightness.light,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    hoverColor: Colors.transparent,
    checkboxTheme: _checkboxThemeData(lightFitColors),
    unselectedWidgetColor: lightFitColors.grey800,
    scaffoldBackgroundColor: lightFitColors.grey900,
    fontFamily: Assets.fonts.pretendardRegular,
    appBarTheme: appBarTheme(context, lightFitColors, false),
    elevatedButtonTheme: elevatedButtonTheme(context, lightFitColors),
    textButtonTheme: textButtonTheme(lightFitColors),
    bottomSheetTheme: bottomSheetTheme(lightFitColors),
    textSelectionTheme: TextSelectionThemeData(cursorColor: lightFitColors.primary),
    inputDecorationTheme: inputDecorationTheme(lightFitColors),
    bottomNavigationBarTheme: bottomNavigationBarTheme(lightFitColors),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    extensions: [lightFitColors],
  );
}

/// 다크 테마
ThemeData fitDarkTheme(BuildContext context) {
  return ThemeData(
    brightness: Brightness.dark,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    hoverColor: Colors.transparent,
    checkboxTheme: _checkboxThemeData(darkFitColors),
    unselectedWidgetColor: darkFitColors.grey800,
    scaffoldBackgroundColor: darkFitColors.grey900,
    fontFamily: Assets.fonts.pretendardRegular,
    appBarTheme: appBarTheme(context, darkFitColors, true),
    elevatedButtonTheme: elevatedButtonTheme(context, darkFitColors),
    textButtonTheme: textButtonTheme(darkFitColors),
    bottomSheetTheme: bottomSheetTheme(darkFitColors),
    textSelectionTheme: TextSelectionThemeData(cursorColor: darkFitColors.primary),
    inputDecorationTheme: inputDecorationTheme(darkFitColors),
    bottomNavigationBarTheme: bottomNavigationBarTheme(darkFitColors),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    extensions: [darkFitColors],
  );
}

_checkboxThemeData(FitColors fitColors) {
  return CheckboxThemeData(
    side: BorderSide(
      width: 1.5,
      color: fitColors.grey700,
    ),
    splashRadius: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4.r),
    ),
    checkColor: WidgetStateProperty.resolveWith<Color>((states) => Colors.black),
    fillColor: WidgetStateProperty.resolveWith<Color>(
      (states) {
        if (!states.contains(WidgetState.selected)) {
          return fitColors.grey700; // 체크박스가 선택된경우.
        }
        return fitColors.primary; // 체크박스가 활성화된 경우
      },
    ),
    overlayColor: WidgetStateProperty.resolveWith<Color>(
      (states) {
        if (states.contains(WidgetState.pressed)) {
          return fitColors.primary; // 체크박스가 눌린 경우
        }
        return Colors.transparent; // 체크박스가 눌리지 않은 경우
      },
    ),
  );
}

bottomSheetTheme(FitColors fitColors) {
  return BottomSheetThemeData(
    backgroundColor: fitColors.grey800,
  );
}

elevatedButtonTheme(BuildContext context, FitColors fitColors) {
  return ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      minimumSize: const Size.fromHeight(56),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100.r),
      ),
      // Enabled button color
      backgroundColor: fitColors.primary,
      // Disabled button color
      disabledBackgroundColor: fitColors.grey600,
      // Enabled text color
      foregroundColor: fitColors.grey900,
      // Disabled text color
      disabledForegroundColor: fitColors.grey400,
      textStyle: context.button1Medium(color: fitColors.white),
    ).copyWith(
      overlayColor: WidgetStateProperty.resolveWith<Color?>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.pressed)) return Colors.transparent;
          return null;
        },
      ),
    ),
  );
}

bottomNavigationBarTheme(FitColors fitColors) {
  return BottomNavigationBarThemeData(
    backgroundColor: Colors.black,
    selectedLabelStyle: TextStyle(
      fontFamily: Assets.fonts.pretendardRegular,
      color: Colors.white,
      fontSize: 13.sp,
    ),
    unselectedLabelStyle: TextStyle(
      fontFamily: Assets.fonts.pretendardRegular,
      color: fitColors.grey700,
      fontSize: 13.sp,
    ),
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.white,
    unselectedItemColor: fitColors.grey700,
    showUnselectedLabels: true,
    showSelectedLabels: true,
  );
}

inputDecorationTheme(FitColors fitColors) {
  return InputDecorationTheme(
    floatingLabelBehavior: FloatingLabelBehavior.auto,
    // contentPadding: const EdgeInsets.fromLTRB(20, 16, 0, 16),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.r),
      borderSide: BorderSide(color: fitColors.grey700),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.r),
      borderSide: BorderSide(color: fitColors.grey700),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.r),
      borderSide: BorderSide(color: fitColors.primary),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.r),
      borderSide: BorderSide(color: fitColors.negative),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.r),
      borderSide: BorderSide(color: fitColors.negative),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.r),
      borderSide: BorderSide(color: fitColors.grey700),
    ),
    counterStyle: TextStyle(color: fitColors.primary),
  );
}

textButtonTheme(FitColors fitColors) {
  return TextButtonThemeData(
    style: TextButton.styleFrom(
      // 버튼의 텍스트 색상을 변경
      foregroundColor: Colors.white,
      // 버튼의 배경색을 변경
      backgroundColor: fitColors.grey800,
      disabledBackgroundColor: fitColors.grey700,
      // 버튼의 최소 크기 설정
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
    ),
  );
}

appBarTheme(BuildContext context, FitColors fitColors, bool isDark) {
  return AppBarTheme(
    color: fitColors.grey900,
    elevation: 0,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: fitColors.white),
    toolbarTextStyle: context.subTitle2Medium(color: fitColors.white),
    titleTextStyle: context.subTitle2Medium(color: fitColors.white),
    titleSpacing: 0,
    toolbarHeight: 60,
    systemOverlayStyle: customSystemUiOverlayStyle(
      isDark: isDark,
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: fitColors.grey900,
    ),
  );
}

SystemUiOverlayStyle customSystemUiOverlayStyle({
  required bool isDark,
  required Color systemNavigationBarColor,
  Color statusBarColor = Colors.transparent,
}) {
  return SystemUiOverlayStyle(
    statusBarColor: statusBarColor,
    statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
    // iOS 상태바 아이콘 밝기
    statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
    // Android 상태바 아이콘 밝기
    systemNavigationBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
    // 내비게이션 바 아이콘 밝기
    systemNavigationBarColor: systemNavigationBarColor, // 내비게이션 바 색상
  );
}

bool isDarkMode(BuildContext context) {
  final brightness = MediaQuery.of(context).platformBrightness;
  final theme = Theme.of(context);

  if (theme.brightness == Brightness.dark) {
    return true; // 다크 모드 강제
  } else if (theme.brightness == Brightness.light) {
    return false; // 라이트 모드 강제
  } else {
    // ThemeMode.system 또는 기본 상태에서는 시스템 설정을 따름
    return brightness == Brightness.dark;
  }
}