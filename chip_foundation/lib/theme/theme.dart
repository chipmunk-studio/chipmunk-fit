import 'package:chip_assets/gen/assets.gen.dart';
import 'package:flutter/material.dart';

import '../colors.dart';
import 'button_themes.dart';
import 'container_themes.dart';
import 'feedback_themes.dart';
import 'input_themes.dart';
import 'list_menu_themes.dart';
import 'navigation_themes.dart';
import 'other_themes.dart';
import 'picker_themes.dart';
import 'selection_themes.dart';
import 'theme_mode_extension.dart';

/// 라이트 테마 생성
ThemeData fitLightTheme(
  BuildContext context, {
  Color? mainColor,
  Color? subColor,
  Color? buttonForegroundColor,
  Color? buttonDisabledBackgroundColor,
}) {
  final updatedColors = lightFitColors.copyWith(
    main: mainColor,
    sub: subColor,
  );

  return _buildThemeData(
    context,
    brightness: Brightness.light,
    colors: updatedColors,
    buttonForegroundColor: buttonForegroundColor,
    buttonDisabledBackgroundColor: buttonDisabledBackgroundColor,
  );
}

/// 다크 테마 생성
ThemeData fitDarkTheme(
  BuildContext context, {
  Color? mainColor,
  Color? subColor,
  Color? buttonForegroundColor,
  Color? buttonDisabledBackgroundColor,
}) {
  final updatedColors = darkFitColors.copyWith(
    main: mainColor,
    sub: subColor,
  );

  return _buildThemeData(
    context,
    brightness: Brightness.dark,
    colors: updatedColors,
    buttonForegroundColor: buttonForegroundColor,
    buttonDisabledBackgroundColor: buttonDisabledBackgroundColor,
  );
}

/// 공통 ThemeData 생성
ThemeData _buildThemeData(
  BuildContext context, {
  required Brightness brightness,
  required FitColors colors,
  Color? buttonForegroundColor,
  Color? buttonDisabledBackgroundColor,
}) {
  final isDarkMode = FitThemeModeExtension(brightness: brightness);
  final isDark = brightness == Brightness.dark;

  return ThemeData(
    useMaterial3: true,
    brightness: brightness,
    fontFamily: ChipAssets.fonts.pretendardRegular,

    // 인터랙션
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    hoverColor: Colors.transparent,
    focusColor: colors.main.withValues(alpha: 0.12),

    // 스캐폴드
    scaffoldBackgroundColor: colors.backgroundBase,
    canvasColor: colors.backgroundBase,

    // 컬러 스킴
    colorScheme: ColorScheme(
      brightness: brightness,
      primary: colors.main,
      onPrimary: colors.staticBlack,
      secondary: colors.sub,
      onSecondary: colors.staticWhite,
      tertiary: colors.periwinkle500,
      onTertiary: colors.staticWhite,
      error: colors.red500,
      onError: colors.staticWhite,
      surface: colors.backgroundElevated,
      onSurface: colors.textPrimary,
      surfaceContainerHighest: colors.fillStrong,
      outline: colors.dividerPrimary,
      outlineVariant: colors.dividerSecondary,
      shadow: colors.staticBlack,
    ),

    // 버튼 테마
    filledButtonTheme: filledButtonTheme(
      context,
      colors,
      buttonForegroundColor: buttonForegroundColor,
      buttonDisabledBackgroundColor: buttonDisabledBackgroundColor,
    ),
    elevatedButtonTheme: elevatedButtonTheme(
      context,
      colors,
      buttonForegroundColor: buttonForegroundColor,
      buttonDisabledBackgroundColor: buttonDisabledBackgroundColor,
    ),
    outlinedButtonTheme: outlinedButtonTheme(colors),
    textButtonTheme: textButtonTheme(colors),
    iconButtonTheme: iconButtonTheme(colors),
    floatingActionButtonTheme: fabTheme(colors, buttonForegroundColor: buttonForegroundColor),

    // 선택 테마
    checkboxTheme: checkboxTheme(colors),
    radioTheme: radioTheme(colors),
    switchTheme: switchTheme(colors),
    sliderTheme: sliderTheme(colors),

    // 컨테이너 테마
    chipTheme: chipTheme(colors),
    cardTheme: cardTheme(colors),
    dialogTheme: dialogTheme(colors),
    bottomSheetTheme: bottomSheetTheme(colors),
    snackBarTheme: snackBarTheme(colors),

    // 네비게이션 테마
    bottomNavigationBarTheme: bottomNavigationBarTheme(colors),
    navigationBarTheme: navigationBarTheme(colors),
    navigationRailTheme: navigationRailTheme(colors),
    tabBarTheme: tabBarTheme(colors),
    drawerTheme: drawerTheme(colors),

    // 리스트 & 메뉴 테마
    listTileTheme: listTileTheme(colors),
    dividerTheme: dividerTheme(colors),
    popupMenuTheme: popupMenuTheme(colors),
    dropdownMenuTheme: dropdownMenuTheme(colors),
    menuTheme: menuTheme(colors),

    // 피드백 테마
    tooltipTheme: tooltipTheme(colors),
    progressIndicatorTheme: progressIndicatorTheme(colors),
    badgeTheme: badgeTheme(colors),

    // 입력 테마
    searchBarTheme: searchBarTheme(colors),
    segmentedButtonTheme: segmentedButtonTheme(colors),
    inputDecorationTheme: inputDecorationTheme(colors),

    // 피커 테마
    datePickerTheme: datePickerTheme(colors),
    timePickerTheme: timePickerTheme(colors),

    // 기타 테마
    textSelectionTheme: textSelectionTheme(colors, isDark),
    scrollbarTheme: scrollbarTheme(colors),
    appBarTheme: appBarTheme(context, colors, isDark),

    visualDensity: VisualDensity.adaptivePlatformDensity,
    extensions: [colors, isDarkMode],
  );
}
