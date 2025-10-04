import 'package:chip_assets/gen/colors.gen.dart';
import 'package:flutter/material.dart';

/// 앱 전체 색상 시스템
///
/// 라이트/다크 모드를 지원하며, ThemeExtension을 통해 사용
@immutable
class FitColors extends ThemeExtension<FitColors> {
  // Main & Sub
  final Color main;
  final Color sub;

  // Grey Scale
  final Color grey0;
  final Color grey50;
  final Color grey100;
  final Color grey200;
  final Color grey300;
  final Color grey400;
  final Color grey500;
  final Color grey600;
  final Color grey700;
  final Color grey800;
  final Color grey900;

  // Green
  final Color green50;
  final Color green200;
  final Color green500;
  final Color green600;
  final Color green700;

  // Periwinkle (Blue)
  final Color periwinkle50;
  final Color periwinkle200;
  final Color periwinkle500;
  final Color periwinkle600;
  final Color periwinkle700;

  // Red
  final Color red50;
  final Color red200;
  final Color red500;
  final Color red600;
  final Color red700;

  // Brick
  final Color brick50;
  final Color brick200;
  final Color brick500;
  final Color brick600;
  final Color brick700;

  // Alpha Colors - Red
  final Color redBase;
  final Color redAlpha72;
  final Color redAlpha48;
  final Color redAlpha24;
  final Color redAlpha12;

  // Alpha Colors - Blue
  final Color blueAlphaBase;
  final Color blueAlpha72;
  final Color blueAlpha48;
  final Color blueAlpha24;
  final Color blueAlpha12;

  // Alpha Colors - Yellow
  final Color yellowBase;
  final Color yellowAlpha72;
  final Color yellowAlpha48;
  final Color yellowAlpha24;
  final Color yellowAlpha12;

  // Alpha Colors - Green
  final Color greenBase;
  final Color greenAlpha72;
  final Color greenAlpha48;
  final Color greenAlpha24;
  final Color greenAlpha12;

  // Alpha Colors - Periwinkle
  final Color periwinkleBase;
  final Color periwinkleAlpha72;
  final Color periwinkleAlpha48;
  final Color periwinkleAlpha24;
  final Color periwinkleAlpha12;

  // Static Colors
  final Color staticBlack;
  final Color staticWhite;

  // Background Colors
  final Color backgroundBase;
  final Color backgroundAlternative;
  final Color backgroundElevated;
  final Color backgroundElevatedAlternative;

  // Text Colors
  final Color textPrimary;
  final Color textSecondary;
  final Color textTertiary;
  final Color textDisabled;

  // Fill Colors
  final Color fillBase;
  final Color fillAlternative;
  final Color fillStrong;
  final Color fillEmphasize;

  // Divider Colors
  final Color dividerPrimary;
  final Color dividerSecondary;

  // Inverse Colors
  final Color inverseBackground;
  final Color inverseText;
  final Color inverseDisabled;

  // Dim Colors
  final Color dimBackground;
  final Color dimOverlay;
  final Color dimCard;

  const FitColors({
    required this.main,
    required this.sub,
    required this.grey0,
    required this.grey50,
    required this.grey100,
    required this.grey200,
    required this.grey300,
    required this.grey400,
    required this.grey500,
    required this.grey600,
    required this.grey700,
    required this.grey800,
    required this.grey900,
    required this.green50,
    required this.green200,
    required this.green500,
    required this.green600,
    required this.green700,
    required this.periwinkle50,
    required this.periwinkle200,
    required this.periwinkle500,
    required this.periwinkle600,
    required this.periwinkle700,
    required this.red50,
    required this.red200,
    required this.red500,
    required this.red600,
    required this.red700,
    required this.brick50,
    required this.brick200,
    required this.brick500,
    required this.brick600,
    required this.brick700,
    required this.redBase,
    required this.redAlpha72,
    required this.redAlpha48,
    required this.redAlpha24,
    required this.redAlpha12,
    required this.blueAlphaBase,
    required this.blueAlpha72,
    required this.blueAlpha48,
    required this.blueAlpha24,
    required this.blueAlpha12,
    required this.yellowBase,
    required this.yellowAlpha72,
    required this.yellowAlpha48,
    required this.yellowAlpha24,
    required this.yellowAlpha12,
    required this.greenBase,
    required this.greenAlpha72,
    required this.greenAlpha48,
    required this.greenAlpha24,
    required this.greenAlpha12,
    required this.periwinkleBase,
    required this.periwinkleAlpha72,
    required this.periwinkleAlpha48,
    required this.periwinkleAlpha24,
    required this.periwinkleAlpha12,
    required this.staticBlack,
    required this.staticWhite,
    required this.backgroundBase,
    required this.backgroundAlternative,
    required this.backgroundElevated,
    required this.backgroundElevatedAlternative,
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.textDisabled,
    required this.fillBase,
    required this.fillAlternative,
    required this.fillStrong,
    required this.fillEmphasize,
    required this.dividerPrimary,
    required this.dividerSecondary,
    required this.inverseBackground,
    required this.inverseText,
    required this.inverseDisabled,
    required this.dimBackground,
    required this.dimOverlay,
    required this.dimCard,
  });

  @override
  FitColors copyWith({
    Color? main,
    Color? sub,
    Color? grey0,
    Color? grey50,
    Color? grey100,
    Color? grey200,
    Color? grey300,
    Color? grey400,
    Color? grey500,
    Color? grey600,
    Color? grey700,
    Color? grey800,
    Color? grey900,
    Color? green50,
    Color? green200,
    Color? green500,
    Color? green600,
    Color? green700,
    Color? periwinkle50,
    Color? periwinkle200,
    Color? periwinkle500,
    Color? periwinkle600,
    Color? periwinkle700,
    Color? red50,
    Color? red200,
    Color? red500,
    Color? red600,
    Color? red700,
    Color? brick50,
    Color? brick200,
    Color? brick500,
    Color? brick600,
    Color? brick700,
    Color? redBase,
    Color? redAlpha72,
    Color? redAlpha48,
    Color? redAlpha24,
    Color? redAlpha12,
    Color? blueAlphaBase,
    Color? blueAlpha72,
    Color? blueAlpha48,
    Color? blueAlpha24,
    Color? blueAlpha12,
    Color? yellowBase,
    Color? yellowAlpha72,
    Color? yellowAlpha48,
    Color? yellowAlpha24,
    Color? yellowAlpha12,
    Color? greenBase,
    Color? greenAlpha72,
    Color? greenAlpha48,
    Color? greenAlpha24,
    Color? greenAlpha12,
    Color? periwinkleBase,
    Color? periwinkleAlpha72,
    Color? periwinkleAlpha48,
    Color? periwinkleAlpha24,
    Color? periwinkleAlpha12,
    Color? staticBlack,
    Color? staticWhite,
    Color? backgroundBase,
    Color? backgroundAlternative,
    Color? backgroundElevated,
    Color? backgroundElevatedAlternative,
    Color? textPrimary,
    Color? textSecondary,
    Color? textTertiary,
    Color? textDisabled,
    Color? fillBase,
    Color? fillAlternative,
    Color? fillStrong,
    Color? fillEmphasize,
    Color? dividerPrimary,
    Color? dividerSecondary,
    Color? inverseBackground,
    Color? inverseText,
    Color? inverseDisabled,
    Color? dimBackground,
    Color? dimOverlay,
    Color? dimCard,
  }) {
    return FitColors(
      main: main ?? this.main,
      sub: sub ?? this.sub,
      grey0: grey0 ?? this.grey0,
      grey50: grey50 ?? this.grey50,
      grey100: grey100 ?? this.grey100,
      grey200: grey200 ?? this.grey200,
      grey300: grey300 ?? this.grey300,
      grey400: grey400 ?? this.grey400,
      grey500: grey500 ?? this.grey500,
      grey600: grey600 ?? this.grey600,
      grey700: grey700 ?? this.grey700,
      grey800: grey800 ?? this.grey800,
      grey900: grey900 ?? this.grey900,
      green50: green50 ?? this.green50,
      green200: green200 ?? this.green200,
      green500: green500 ?? this.green500,
      green600: green600 ?? this.green600,
      green700: green700 ?? this.green700,
      periwinkle50: periwinkle50 ?? this.periwinkle50,
      periwinkle200: periwinkle200 ?? this.periwinkle200,
      periwinkle500: periwinkle500 ?? this.periwinkle500,
      periwinkle600: periwinkle600 ?? this.periwinkle600,
      periwinkle700: periwinkle700 ?? this.periwinkle700,
      red50: red50 ?? this.red50,
      red200: red200 ?? this.red200,
      red500: red500 ?? this.red500,
      red600: red600 ?? this.red600,
      red700: red700 ?? this.red700,
      brick50: brick50 ?? this.brick50,
      brick200: brick200 ?? this.brick200,
      brick500: brick500 ?? this.brick500,
      brick600: brick600 ?? this.brick600,
      brick700: brick700 ?? this.brick700,
      redBase: redBase ?? this.redBase,
      redAlpha72: redAlpha72 ?? this.redAlpha72,
      redAlpha48: redAlpha48 ?? this.redAlpha48,
      redAlpha24: redAlpha24 ?? this.redAlpha24,
      redAlpha12: redAlpha12 ?? this.redAlpha12,
      blueAlphaBase: blueAlphaBase ?? this.blueAlphaBase,
      blueAlpha72: blueAlpha72 ?? this.blueAlpha72,
      blueAlpha48: blueAlpha48 ?? this.blueAlpha48,
      blueAlpha24: blueAlpha24 ?? this.blueAlpha24,
      blueAlpha12: blueAlpha12 ?? this.blueAlpha12,
      yellowBase: yellowBase ?? this.yellowBase,
      yellowAlpha72: yellowAlpha72 ?? this.yellowAlpha72,
      yellowAlpha48: yellowAlpha48 ?? this.yellowAlpha48,
      yellowAlpha24: yellowAlpha24 ?? this.yellowAlpha24,
      yellowAlpha12: yellowAlpha12 ?? this.yellowAlpha12,
      greenBase: greenBase ?? this.greenBase,
      greenAlpha72: greenAlpha72 ?? this.greenAlpha72,
      greenAlpha48: greenAlpha48 ?? this.greenAlpha48,
      greenAlpha24: greenAlpha24 ?? this.greenAlpha24,
      greenAlpha12: greenAlpha12 ?? this.greenAlpha12,
      periwinkleBase: periwinkleBase ?? this.periwinkleBase,
      periwinkleAlpha72: periwinkleAlpha72 ?? this.periwinkleAlpha72,
      periwinkleAlpha48: periwinkleAlpha48 ?? this.periwinkleAlpha48,
      periwinkleAlpha24: periwinkleAlpha24 ?? this.periwinkleAlpha24,
      periwinkleAlpha12: periwinkleAlpha12 ?? this.periwinkleAlpha12,
      staticBlack: staticBlack ?? this.staticBlack,
      staticWhite: staticWhite ?? this.staticWhite,
      backgroundBase: backgroundBase ?? this.backgroundBase,
      backgroundAlternative: backgroundAlternative ?? this.backgroundAlternative,
      backgroundElevated: backgroundElevated ?? this.backgroundElevated,
      backgroundElevatedAlternative:
          backgroundElevatedAlternative ?? this.backgroundElevatedAlternative,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textTertiary: textTertiary ?? this.textTertiary,
      textDisabled: textDisabled ?? this.textDisabled,
      fillBase: fillBase ?? this.fillBase,
      fillAlternative: fillAlternative ?? this.fillAlternative,
      fillStrong: fillStrong ?? this.fillStrong,
      fillEmphasize: fillEmphasize ?? this.fillEmphasize,
      dividerPrimary: dividerPrimary ?? this.dividerPrimary,
      dividerSecondary: dividerSecondary ?? this.dividerSecondary,
      inverseBackground: inverseBackground ?? this.inverseBackground,
      inverseText: inverseText ?? this.inverseText,
      inverseDisabled: inverseDisabled ?? this.inverseDisabled,
      dimBackground: dimBackground ?? this.dimBackground,
      dimOverlay: dimOverlay ?? this.dimOverlay,
      dimCard: dimCard ?? this.dimCard,
    );
  }

  @override
  ThemeExtension<FitColors> lerp(covariant ThemeExtension<FitColors>? other, double t) {
    if (other is! FitColors) return this;

    return FitColors(
      main: Color.lerp(main, other.main, t)!,
      sub: Color.lerp(sub, other.sub, t)!,
      grey0: Color.lerp(grey0, other.grey0, t)!,
      grey50: Color.lerp(grey50, other.grey50, t)!,
      grey100: Color.lerp(grey100, other.grey100, t)!,
      grey200: Color.lerp(grey200, other.grey200, t)!,
      grey300: Color.lerp(grey300, other.grey300, t)!,
      grey400: Color.lerp(grey400, other.grey400, t)!,
      grey500: Color.lerp(grey500, other.grey500, t)!,
      grey600: Color.lerp(grey600, other.grey600, t)!,
      grey700: Color.lerp(grey700, other.grey700, t)!,
      grey800: Color.lerp(grey800, other.grey800, t)!,
      grey900: Color.lerp(grey900, other.grey900, t)!,
      green50: Color.lerp(green50, other.green50, t)!,
      green200: Color.lerp(green200, other.green200, t)!,
      green500: Color.lerp(green500, other.green500, t)!,
      green600: Color.lerp(green600, other.green600, t)!,
      green700: Color.lerp(green700, other.green700, t)!,
      periwinkle50: Color.lerp(periwinkle50, other.periwinkle50, t)!,
      periwinkle200: Color.lerp(periwinkle200, other.periwinkle200, t)!,
      periwinkle500: Color.lerp(periwinkle500, other.periwinkle500, t)!,
      periwinkle600: Color.lerp(periwinkle600, other.periwinkle600, t)!,
      periwinkle700: Color.lerp(periwinkle700, other.periwinkle700, t)!,
      red50: Color.lerp(red50, other.red50, t)!,
      red200: Color.lerp(red200, other.red200, t)!,
      red500: Color.lerp(red500, other.red500, t)!,
      red600: Color.lerp(red600, other.red600, t)!,
      red700: Color.lerp(red700, other.red700, t)!,
      brick50: Color.lerp(brick50, other.brick50, t)!,
      brick200: Color.lerp(brick200, other.brick200, t)!,
      brick500: Color.lerp(brick500, other.brick500, t)!,
      brick600: Color.lerp(brick600, other.brick600, t)!,
      brick700: Color.lerp(brick700, other.brick700, t)!,
      redBase: Color.lerp(redBase, other.redBase, t)!,
      redAlpha72: Color.lerp(redAlpha72, other.redAlpha72, t)!,
      redAlpha48: Color.lerp(redAlpha48, other.redAlpha48, t)!,
      redAlpha24: Color.lerp(redAlpha24, other.redAlpha24, t)!,
      redAlpha12: Color.lerp(redAlpha12, other.redAlpha12, t)!,
      blueAlphaBase: Color.lerp(blueAlphaBase, other.blueAlphaBase, t)!,
      blueAlpha72: Color.lerp(blueAlpha72, other.blueAlpha72, t)!,
      blueAlpha48: Color.lerp(blueAlpha48, other.blueAlpha48, t)!,
      blueAlpha24: Color.lerp(blueAlpha24, other.blueAlpha24, t)!,
      blueAlpha12: Color.lerp(blueAlpha12, other.blueAlpha12, t)!,
      yellowBase: Color.lerp(yellowBase, other.yellowBase, t)!,
      yellowAlpha72: Color.lerp(yellowAlpha72, other.yellowAlpha72, t)!,
      yellowAlpha48: Color.lerp(yellowAlpha48, other.yellowAlpha48, t)!,
      yellowAlpha24: Color.lerp(yellowAlpha24, other.yellowAlpha24, t)!,
      yellowAlpha12: Color.lerp(yellowAlpha12, other.yellowAlpha12, t)!,
      greenBase: Color.lerp(greenBase, other.greenBase, t)!,
      greenAlpha72: Color.lerp(greenAlpha72, other.greenAlpha72, t)!,
      greenAlpha48: Color.lerp(greenAlpha48, other.greenAlpha48, t)!,
      greenAlpha24: Color.lerp(greenAlpha24, other.greenAlpha24, t)!,
      greenAlpha12: Color.lerp(greenAlpha12, other.greenAlpha12, t)!,
      periwinkleBase: Color.lerp(periwinkleBase, other.periwinkleBase, t)!,
      periwinkleAlpha72: Color.lerp(periwinkleAlpha72, other.periwinkleAlpha72, t)!,
      periwinkleAlpha48: Color.lerp(periwinkleAlpha48, other.periwinkleAlpha48, t)!,
      periwinkleAlpha24: Color.lerp(periwinkleAlpha24, other.periwinkleAlpha24, t)!,
      periwinkleAlpha12: Color.lerp(periwinkleAlpha12, other.periwinkleAlpha12, t)!,
      staticBlack: Color.lerp(staticBlack, other.staticBlack, t)!,
      staticWhite: Color.lerp(staticWhite, other.staticWhite, t)!,
      backgroundBase: Color.lerp(backgroundBase, other.backgroundBase, t)!,
      backgroundAlternative: Color.lerp(backgroundAlternative, other.backgroundAlternative, t)!,
      backgroundElevated: Color.lerp(backgroundElevated, other.backgroundElevated, t)!,
      backgroundElevatedAlternative:
          Color.lerp(backgroundElevatedAlternative, other.backgroundElevatedAlternative, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textTertiary: Color.lerp(textTertiary, other.textTertiary, t)!,
      textDisabled: Color.lerp(textDisabled, other.textDisabled, t)!,
      fillBase: Color.lerp(fillBase, other.fillBase, t)!,
      fillAlternative: Color.lerp(fillAlternative, other.fillAlternative, t)!,
      fillStrong: Color.lerp(fillStrong, other.fillStrong, t)!,
      fillEmphasize: Color.lerp(fillEmphasize, other.fillEmphasize, t)!,
      dividerPrimary: Color.lerp(dividerPrimary, other.dividerPrimary, t)!,
      dividerSecondary: Color.lerp(dividerSecondary, other.dividerSecondary, t)!,
      inverseBackground: Color.lerp(inverseBackground, other.inverseBackground, t)!,
      inverseText: Color.lerp(inverseText, other.inverseText, t)!,
      inverseDisabled: Color.lerp(inverseDisabled, other.inverseDisabled, t)!,
      dimBackground: Color.lerp(dimBackground, other.dimBackground, t)!,
      dimOverlay: Color.lerp(dimOverlay, other.dimOverlay, t)!,
      dimCard: Color.lerp(dimCard, other.dimCard, t)!,
    );
  }
}

/// Alpha 값 생성 헬퍼
Color _createAlphaColor(Color base, double opacity) {
  return base.withAlpha((255 * opacity).toInt());
}

/// Light Theme Colors
final FitColors lightFitColors = FitColors(
  main: ChipColors.green500,
  sub: ChipColors.periwinkle500,
  grey0: ChipColors.grey0,
  grey50: ChipColors.grey50,
  grey100: ChipColors.grey100,
  grey200: ChipColors.grey200,
  grey300: ChipColors.grey300,
  grey400: ChipColors.grey400,
  grey500: ChipColors.grey500,
  grey600: ChipColors.grey600,
  grey700: ChipColors.grey700,
  grey800: ChipColors.grey800,
  grey900: ChipColors.grey900,
  green50: ChipColors.green50,
  green200: ChipColors.green200,
  green500: ChipColors.green500,
  green600: ChipColors.green600,
  green700: ChipColors.green700,
  periwinkle50: ChipColors.periwinkle50,
  periwinkle200: ChipColors.periwinkle200,
  periwinkle500: ChipColors.periwinkle500,
  periwinkle600: ChipColors.periwinkle600,
  periwinkle700: ChipColors.periwinkle700,
  red50: ChipColors.red50,
  red200: ChipColors.red200,
  red500: ChipColors.red500,
  red600: ChipColors.red600,
  red700: ChipColors.red700,
  brick50: ChipColors.brick50,
  brick200: ChipColors.brick200,
  brick500: ChipColors.brick500,
  brick600: ChipColors.brick600,
  brick700: ChipColors.brick700,
  redBase: ChipColors.redAlphaBase,
  redAlpha72: _createAlphaColor(ChipColors.redAlphaBase, 0.72),
  redAlpha48: _createAlphaColor(ChipColors.redAlphaBase, 0.48),
  redAlpha24: _createAlphaColor(ChipColors.redAlphaBase, 0.24),
  redAlpha12: _createAlphaColor(ChipColors.redAlphaBase, 0.12),
  blueAlphaBase: ChipColors.blueAlphaBase,
  blueAlpha72: _createAlphaColor(ChipColors.blueAlphaBase, 0.72),
  blueAlpha48: _createAlphaColor(ChipColors.blueAlphaBase, 0.48),
  blueAlpha24: _createAlphaColor(ChipColors.blueAlphaBase, 0.24),
  blueAlpha12: _createAlphaColor(ChipColors.blueAlphaBase, 0.12),
  yellowBase: ChipColors.yellowAlphaBase,
  yellowAlpha72: _createAlphaColor(ChipColors.yellowAlphaBase, 0.72),
  yellowAlpha48: _createAlphaColor(ChipColors.yellowAlphaBase, 0.48),
  yellowAlpha24: _createAlphaColor(ChipColors.yellowAlphaBase, 0.24),
  yellowAlpha12: _createAlphaColor(ChipColors.yellowAlphaBase, 0.12),
  greenBase: ChipColors.greenAlphaBase,
  greenAlpha72: _createAlphaColor(ChipColors.greenAlphaBase, 0.72),
  greenAlpha48: _createAlphaColor(ChipColors.greenAlphaBase, 0.48),
  greenAlpha24: _createAlphaColor(ChipColors.greenAlphaBase, 0.24),
  greenAlpha12: _createAlphaColor(ChipColors.greenAlphaBase, 0.12),
  periwinkleBase: ChipColors.periwinkleAlphaBase,
  periwinkleAlpha72: _createAlphaColor(ChipColors.periwinkleAlphaBase, 0.72),
  periwinkleAlpha48: _createAlphaColor(ChipColors.periwinkleAlphaBase, 0.48),
  periwinkleAlpha24: _createAlphaColor(ChipColors.periwinkleAlphaBase, 0.24),
  periwinkleAlpha12: _createAlphaColor(ChipColors.periwinkleAlphaBase, 0.12),
  staticBlack: ChipColors.staticBlack,
  staticWhite: ChipColors.staticWhite,
  backgroundBase: ChipColors.grey50,
  backgroundAlternative: ChipColors.grey0,
  backgroundElevated: ChipColors.grey0,
  backgroundElevatedAlternative: ChipColors.grey50,
  textPrimary: ChipColors.grey900,
  textSecondary: ChipColors.grey700,
  textTertiary: ChipColors.grey600,
  textDisabled: ChipColors.grey500,
  fillBase: ChipColors.grey0,
  fillAlternative: ChipColors.grey50,
  fillStrong: ChipColors.grey200,
  fillEmphasize: ChipColors.grey300,
  dividerPrimary: ChipColors.grey100,
  dividerSecondary: ChipColors.grey200,
  inverseBackground: ChipColors.grey900,
  inverseText: ChipColors.grey0,
  inverseDisabled: _createAlphaColor(ChipColors.grey400, 0.8),
  dimBackground: _createAlphaColor(ChipColors.staticBlack, 0.6),
  dimOverlay: _createAlphaColor(ChipColors.staticWhite, 0.76),
  dimCard: _createAlphaColor(const Color(0xFFEFEFEF), 0.72),
);

/// Dark Theme Colors
final FitColors darkFitColors = FitColors(
  main: ChipColors.green500Dark,
  sub: ChipColors.periwinkle500Dark,
  grey0: ChipColors.grey0Dark,
  grey50: ChipColors.grey50Dark,
  grey100: ChipColors.grey100Dark,
  grey200: ChipColors.grey200Dark,
  grey300: ChipColors.grey300Dark,
  grey400: ChipColors.grey400Dark,
  grey500: ChipColors.grey500Dark,
  grey600: ChipColors.grey600Dark,
  grey700: ChipColors.grey700Dark,
  grey800: ChipColors.grey800Dark,
  grey900: ChipColors.grey900Dark,
  green50: ChipColors.green50Dark,
  green200: ChipColors.green200Dark,
  green500: ChipColors.green500Dark,
  green600: ChipColors.green600Dark,
  green700: ChipColors.green700Dark,
  periwinkle50: ChipColors.periwinkle50Dark,
  periwinkle200: ChipColors.periwinkle200Dark,
  periwinkle500: ChipColors.periwinkle500Dark,
  periwinkle600: ChipColors.periwinkle600Dark,
  periwinkle700: ChipColors.periwinkle700Dark,
  red50: ChipColors.red50Dark,
  red200: ChipColors.red200Dark,
  red500: ChipColors.red500Dark,
  red600: ChipColors.red600Dark,
  red700: ChipColors.red700Dark,
  brick50: ChipColors.brick50Dark,
  brick200: ChipColors.brick200Dark,
  brick500: ChipColors.brick500Dark,
  brick600: ChipColors.brick600Dark,
  brick700: ChipColors.brick700Dark,
  redBase: ChipColors.redAlphaBaseDark,
  redAlpha72: _createAlphaColor(ChipColors.redAlphaBaseDark, 0.72),
  redAlpha48: _createAlphaColor(ChipColors.redAlphaBaseDark, 0.48),
  redAlpha24: _createAlphaColor(ChipColors.redAlphaBaseDark, 0.24),
  redAlpha12: _createAlphaColor(ChipColors.redAlphaBaseDark, 0.12),
  blueAlphaBase: ChipColors.blueAlphaBaseDark,
  blueAlpha72: _createAlphaColor(ChipColors.blueAlphaBaseDark, 0.72),
  blueAlpha48: _createAlphaColor(ChipColors.blueAlphaBaseDark, 0.48),
  blueAlpha24: _createAlphaColor(ChipColors.blueAlphaBaseDark, 0.24),
  blueAlpha12: _createAlphaColor(ChipColors.blueAlphaBaseDark, 0.12),
  yellowBase: ChipColors.yellowAlphaBaseDark,
  yellowAlpha72: _createAlphaColor(ChipColors.yellowAlphaBaseDark, 0.72),
  yellowAlpha48: _createAlphaColor(ChipColors.yellowAlphaBaseDark, 0.48),
  yellowAlpha24: _createAlphaColor(ChipColors.yellowAlphaBaseDark, 0.24),
  yellowAlpha12: _createAlphaColor(ChipColors.yellowAlphaBaseDark, 0.12),
  greenBase: ChipColors.greenAlphaBaseDark,
  greenAlpha72: _createAlphaColor(ChipColors.greenAlphaBaseDark, 0.72),
  greenAlpha48: _createAlphaColor(ChipColors.greenAlphaBaseDark, 0.48),
  greenAlpha24: _createAlphaColor(ChipColors.greenAlphaBaseDark, 0.24),
  greenAlpha12: _createAlphaColor(ChipColors.greenAlphaBaseDark, 0.12),
  periwinkleBase: ChipColors.periwinkleAlphaBaseDark,
  periwinkleAlpha72: _createAlphaColor(ChipColors.periwinkleAlphaBaseDark, 0.72),
  periwinkleAlpha48: _createAlphaColor(ChipColors.periwinkleAlphaBaseDark, 0.48),
  periwinkleAlpha24: _createAlphaColor(ChipColors.periwinkleAlphaBaseDark, 0.24),
  periwinkleAlpha12: _createAlphaColor(ChipColors.periwinkleAlphaBaseDark, 0.12),
  staticBlack: ChipColors.staticBlack,
  staticWhite: ChipColors.staticWhite,
  backgroundBase: ChipColors.grey0Dark,
  backgroundAlternative: ChipColors.grey50Dark,
  backgroundElevated: ChipColors.grey100Dark,
  backgroundElevatedAlternative: ChipColors.grey50Dark,
  textPrimary: ChipColors.grey900Dark,
  textSecondary: ChipColors.grey700Dark,
  textTertiary: ChipColors.grey600Dark,
  textDisabled: ChipColors.grey500Dark,
  fillBase: ChipColors.grey50Dark,
  fillAlternative: ChipColors.grey100Dark,
  fillStrong: ChipColors.grey200Dark,
  fillEmphasize: ChipColors.grey300Dark,
  dividerPrimary: ChipColors.grey100Dark,
  dividerSecondary: ChipColors.grey200Dark,
  inverseBackground: ChipColors.grey900Dark,
  inverseText: ChipColors.grey0Dark,
  inverseDisabled: ChipColors.grey0Dark,
  dimBackground: _createAlphaColor(ChipColors.staticBlack, 0.6),
  dimOverlay: _createAlphaColor(ChipColors.staticBlack, 0.76),
  dimCard: _createAlphaColor(const Color(0xFF0D0D0D), 0.72),
);

/// BuildContext에서 FitColors를 가져오는 헬퍼 함수 (Deprecated)
@Deprecated('Use context.fitColors extension instead')
FitColors fitColors(BuildContext context) {
  return Theme.of(context).extension<FitColors>()!;
}

/// BuildContext Extension으로 FitColors 쉽게 접근
extension FitColorsExtension on BuildContext {
  FitColors get fitColors {
    return Theme.of(this).extension<FitColors>()!;
  }
}
