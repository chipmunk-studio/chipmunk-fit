import 'package:chipfit/gen/colors.gen.dart';
import 'package:flutter/material.dart';

@immutable
class FitColors extends ThemeExtension<FitColors> {
  /// Main&Sub
  final Color main;
  final Color sub;

  /// Grey Colors
  final Color grey0;
  final Color grey50;
  final Color grey900;
  final Color grey800;
  final Color grey700;
  final Color grey600;
  final Color grey500;
  final Color grey400;
  final Color grey300;
  final Color grey200;
  final Color grey100;

  /// Green Colors
  final Color green50;
  final Color green200;
  final Color green500;
  final Color green600;
  final Color green700;

  /// Blue Colors
  final Color periwinkle50;
  final Color periwinkle200;
  final Color periwinkle500;
  final Color periwinkle600;
  final Color periwinkle700;

  /// Red Colors
  final Color red50;
  final Color red200;
  final Color red500;
  final Color red600;
  final Color red700;

  /// Brick Colors
  final Color brick50;
  final Color brick200;
  final Color brick500;
  final Color brick600;
  final Color brick700;

  /// Red Colors
  final Color redBase;
  final Color redAlpha72;
  final Color redAlpha48;
  final Color redAlpha24;
  final Color redAlpha12;

  /// Blue Colors
  final Color blueAlphaBase;
  final Color blueAlpha72;
  final Color blueAlpha48;
  final Color blueAlpha24;
  final Color blueAlpha12;

  /// Yellow Colors
  final Color yellowBase;
  final Color yellowAlpha72;
  final Color yellowAlpha48;
  final Color yellowAlpha24;
  final Color yellowAlpha12;

  /// Green Colors
  final Color greenBase;
  final Color greenAlpha72;
  final Color greenAlpha48;
  final Color greenAlpha24;
  final Color greenAlpha12;

  /// Blue Colors
  final Color periwinkleBase;
  final Color periwinkleAlpha72;
  final Color periwinkleAlpha48;
  final Color periwinkleAlpha24;
  final Color periwinkleAlpha12;

  /// Static Colors
  final Color staticBlack;
  final Color staticWhite;

  /// Background Colors
  final Color backgroundBase;
  final Color backgroundAlternative;
  final Color backgroundElevated;
  final Color backgroundElevatedAlternative;

  /// Text Colors
  final Color textPrimary;
  final Color textSecondary;
  final Color textTertiary;
  final Color textDisabled;

  /// Fill Colors
  final Color fillBase;
  final Color fillAlternative;
  final Color fillStrong;
  final Color fillEmphasize;

  /// Divider Colors
  final Color dividerPrimary;
  final Color dividerSecondary;

  /// Inverse Colors
  final Color inverseBackground;
  final Color inverseText;
  final Color inverseDisabled;

  /// Dim Colors
  final Color dimBackground;
  final Color dimOverlay;

  const FitColors({
    required this.main,
    required this.sub,
    required this.grey0,
    required this.grey50,
    required this.grey900,
    required this.grey800,
    required this.grey700,
    required this.grey600,
    required this.grey500,
    required this.grey400,
    required this.grey300,
    required this.grey200,
    required this.grey100,
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
  });

  @override
  FitColors copyWith({
    Color? main,
    Color? sub,
    Color? grey0,
    Color? grey50,
    Color? grey900,
    Color? grey800,
    Color? grey700,
    Color? grey600,
    Color? grey500,
    Color? grey400,
    Color? grey300,
    Color? grey200,
    Color? grey100,
    Color? white,
    Color? black,
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
    Color? blueAlphaBase,
    Color? blueAlpha72,
    Color? blueAlpha48,
    Color? blueAlpha24,
    Color? blueAlpha12,
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
  }) {
    return FitColors(
      main: main ?? this.main,
      sub: sub ?? this.sub,
      grey0: grey0 ?? this.grey0,
      grey50: grey50 ?? this.grey50,
      grey900: grey900 ?? this.grey900,
      grey800: grey800 ?? this.grey800,
      grey700: grey700 ?? this.grey700,
      grey600: grey600 ?? this.grey600,
      grey500: grey500 ?? this.grey500,
      grey400: grey400 ?? this.grey400,
      grey300: grey300 ?? this.grey300,
      grey200: grey200 ?? this.grey200,
      grey100: grey100 ?? this.grey100,
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
      blueAlphaBase: blueAlphaBase ?? this.blueAlphaBase,
      blueAlpha72: blueAlpha72 ?? this.blueAlpha72,
      blueAlpha48: blueAlpha48 ?? this.blueAlpha48,
      blueAlpha24: blueAlpha24 ?? this.blueAlpha24,
      blueAlpha12: blueAlpha12 ?? this.blueAlpha12,
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
      backgroundElevatedAlternative: backgroundElevatedAlternative ?? this.backgroundElevatedAlternative,
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
    );
  }

  @override
  ThemeExtension<FitColors> lerp(covariant ThemeExtension<FitColors>? other, double t) {
    if (other is! FitColors) return this;
    return FitColors(
      main: Color.lerp(main, other.main, t) ?? main,
      sub: Color.lerp(sub, other.sub, t) ?? sub,
      grey0: Color.lerp(grey0, other.grey0, t) ?? grey0,
      grey50: Color.lerp(grey50, other.grey50, t) ?? grey50,
      grey900: Color.lerp(grey900, other.grey900, t) ?? grey900,
      grey800: Color.lerp(grey800, other.grey800, t) ?? grey800,
      grey700: Color.lerp(grey700, other.grey700, t) ?? grey700,
      grey600: Color.lerp(grey600, other.grey600, t) ?? grey600,
      grey500: Color.lerp(grey500, other.grey500, t) ?? grey500,
      grey400: Color.lerp(grey400, other.grey400, t) ?? grey400,
      grey300: Color.lerp(grey300, other.grey300, t) ?? grey300,
      grey200: Color.lerp(grey200, other.grey200, t) ?? grey200,
      grey100: Color.lerp(grey100, other.grey100, t) ?? grey100,
      green50: Color.lerp(green50, other.green50, t) ?? green50,
      green200: Color.lerp(green200, other.green200, t) ?? green200,
      green500: Color.lerp(green500, other.green500, t) ?? green500,
      green600: Color.lerp(green600, other.green600, t) ?? green600,
      green700: Color.lerp(green700, other.green700, t) ?? green700,
      periwinkle50: Color.lerp(periwinkle50, other.periwinkle50, t) ?? periwinkle50,
      periwinkle200: Color.lerp(periwinkle200, other.periwinkle200, t) ?? periwinkle200,
      periwinkle500: Color.lerp(periwinkle500, other.periwinkle500, t) ?? periwinkle500,
      periwinkle600: Color.lerp(periwinkle600, other.periwinkle600, t) ?? periwinkle600,
      periwinkle700: Color.lerp(periwinkle700, other.periwinkle700, t) ?? periwinkle700,
      red50: Color.lerp(red50, other.red50, t) ?? red50,
      red200: Color.lerp(red200, other.red200, t) ?? red200,
      red500: Color.lerp(red500, other.red500, t) ?? red500,
      red600: Color.lerp(red600, other.red600, t) ?? red600,
      red700: Color.lerp(red700, other.red700, t) ?? red700,
      brick50: Color.lerp(brick50, other.brick50, t) ?? brick50,
      brick200: Color.lerp(brick200, other.brick200, t) ?? brick200,
      brick500: Color.lerp(brick500, other.brick500, t) ?? brick500,
      brick600: Color.lerp(brick600, other.brick600, t) ?? brick600,
      brick700: Color.lerp(brick700, other.brick700, t) ?? brick700,
      redBase: Color.lerp(redBase, other.redBase, t) ?? redBase,
      redAlpha72: Color.lerp(redAlpha72, other.redAlpha72, t) ?? redAlpha72,
      redAlpha48: Color.lerp(redAlpha48, other.redAlpha48, t) ?? redAlpha48,
      redAlpha24: Color.lerp(redAlpha24, other.redAlpha24, t) ?? redAlpha24,
      redAlpha12: Color.lerp(redAlpha12, other.redAlpha12, t) ?? redAlpha12,
      blueAlphaBase: Color.lerp(blueAlphaBase, other.blueAlphaBase, t) ?? blueAlphaBase,
      blueAlpha72: Color.lerp(blueAlpha72, other.blueAlpha72, t) ?? blueAlpha72,
      blueAlpha48: Color.lerp(blueAlpha48, other.blueAlpha48, t) ?? blueAlpha48,
      blueAlpha24: Color.lerp(blueAlpha24, other.blueAlpha24, t) ?? blueAlpha24,
      blueAlpha12: Color.lerp(blueAlpha12, other.blueAlpha12, t) ?? blueAlpha12,
      yellowBase: Color.lerp(yellowBase, other.yellowBase, t) ?? yellowBase,
      yellowAlpha72: Color.lerp(yellowAlpha72, other.yellowAlpha72, t) ?? yellowAlpha72,
      yellowAlpha48: Color.lerp(yellowAlpha48, other.yellowAlpha48, t) ?? yellowAlpha48,
      yellowAlpha24: Color.lerp(yellowAlpha24, other.yellowAlpha24, t) ?? yellowAlpha24,
      yellowAlpha12: Color.lerp(yellowAlpha12, other.yellowAlpha12, t) ?? yellowAlpha12,
      greenBase: Color.lerp(greenBase, other.greenBase, t) ?? greenBase,
      greenAlpha72: Color.lerp(greenAlpha72, other.greenAlpha72, t) ?? greenAlpha72,
      greenAlpha48: Color.lerp(greenAlpha48, other.greenAlpha48, t) ?? greenAlpha48,
      greenAlpha24: Color.lerp(greenAlpha24, other.greenAlpha24, t) ?? greenAlpha24,
      greenAlpha12: Color.lerp(greenAlpha12, other.greenAlpha12, t) ?? greenAlpha12,
      periwinkleBase: Color.lerp(periwinkleBase, other.periwinkleBase, t) ?? periwinkleBase,
      periwinkleAlpha72: Color.lerp(periwinkleAlpha72, other.periwinkleAlpha72, t) ?? periwinkleAlpha72,
      periwinkleAlpha48: Color.lerp(periwinkleAlpha48, other.periwinkleAlpha48, t) ?? periwinkleAlpha48,
      periwinkleAlpha24: Color.lerp(periwinkleAlpha24, other.periwinkleAlpha24, t) ?? periwinkleAlpha24,
      periwinkleAlpha12: Color.lerp(periwinkleAlpha12, other.periwinkleAlpha12, t) ?? periwinkleAlpha12,
      staticBlack: Color.lerp(staticBlack, other.staticBlack, t) ?? staticBlack,
      staticWhite: Color.lerp(staticWhite, other.staticWhite, t) ?? staticWhite,
      backgroundBase: Color.lerp(backgroundBase, other.backgroundBase, t) ?? backgroundBase,
      backgroundAlternative: Color.lerp(backgroundAlternative, other.backgroundAlternative, t) ?? backgroundAlternative,
      backgroundElevated: Color.lerp(backgroundElevated, other.backgroundElevated, t) ?? backgroundElevated,
      backgroundElevatedAlternative:
          Color.lerp(backgroundElevatedAlternative, other.backgroundElevatedAlternative, t) ??
              backgroundElevatedAlternative,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t) ?? textPrimary,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t) ?? textSecondary,
      textTertiary: Color.lerp(textTertiary, other.textTertiary, t) ?? textTertiary,
      textDisabled: Color.lerp(textDisabled, other.textDisabled, t) ?? textDisabled,
      fillBase: Color.lerp(fillBase, other.fillBase, t) ?? fillBase,
      fillAlternative: Color.lerp(fillAlternative, other.fillAlternative, t) ?? fillAlternative,
      fillStrong: Color.lerp(fillStrong, other.fillStrong, t) ?? fillStrong,
      fillEmphasize: Color.lerp(fillEmphasize, other.fillEmphasize, t) ?? fillEmphasize,
      dividerPrimary: Color.lerp(dividerPrimary, other.dividerPrimary, t) ?? dividerPrimary,
      dividerSecondary: Color.lerp(dividerSecondary, other.dividerSecondary, t) ?? dividerSecondary,
      inverseBackground: Color.lerp(inverseBackground, other.inverseBackground, t) ?? inverseBackground,
      inverseText: Color.lerp(inverseText, other.inverseText, t) ?? inverseText,
      inverseDisabled: Color.lerp(inverseDisabled, other.inverseDisabled, t) ?? inverseDisabled,
      dimBackground: Color.lerp(dimBackground, other.dimBackground, t) ?? dimBackground,
      dimOverlay: Color.lerp(dimOverlay, other.dimOverlay, t) ?? dimOverlay,
    );
  }
}

/// Light Theme Colors
FitColors lightFitColors = FitColors(
  main: ColorName.green500,
  sub: ColorName.periwinkle500,
  grey0: ColorName.grey0,
  grey50: ColorName.grey50,
  grey900: ColorName.grey900,
  grey800: ColorName.grey800,
  grey700: ColorName.grey700,
  grey600: ColorName.grey600,
  grey500: ColorName.grey500,
  grey400: ColorName.grey400,
  grey300: ColorName.grey300,
  grey200: ColorName.grey200,
  grey100: ColorName.grey100,
  green50: ColorName.green50,
  green200: ColorName.green200,
  green500: ColorName.green500,
  green600: ColorName.green600,
  green700: ColorName.green700,
  periwinkle50: ColorName.periwinkle50,
  periwinkle200: ColorName.periwinkle200,
  periwinkle500: ColorName.periwinkle500,
  periwinkle600: ColorName.periwinkle600,
  periwinkle700: ColorName.periwinkle700,
  red50: ColorName.red50,
  red200: ColorName.red200,
  red500: ColorName.red500,
  red600: ColorName.red600,
  red700: ColorName.red700,
  redBase: ColorName.redAlphaBase,
  redAlpha72: ColorName.redAlphaBase.withAlpha((255 * 0.72).toInt()),
  redAlpha48: ColorName.redAlphaBase.withAlpha((255 * 0.48).toInt()),
  redAlpha24: ColorName.redAlphaBase.withAlpha((255 * 0.24).toInt()),
  redAlpha12: ColorName.redAlphaBase.withAlpha((255 * 0.12).toInt()),
  blueAlphaBase: ColorName.blueAlphaBase,
  blueAlpha72: ColorName.blueAlphaBase.withAlpha((255 * 0.72).toInt()),
  blueAlpha48: ColorName.blueAlphaBase.withAlpha((255 * 0.48).toInt()),
  blueAlpha24: ColorName.blueAlphaBase.withAlpha((255 * 0.24).toInt()),
  blueAlpha12: ColorName.blueAlphaBase.withAlpha((255 * 0.12).toInt()),
  yellowBase: ColorName.yellowAlphaBase,
  yellowAlpha72: ColorName.yellowAlphaBase.withAlpha((255 * 0.72).toInt()),
  yellowAlpha48: ColorName.yellowAlphaBase.withAlpha((255 * 0.48).toInt()),
  yellowAlpha24: ColorName.yellowAlphaBase.withAlpha((255 * 0.24).toInt()),
  yellowAlpha12: ColorName.yellowAlphaBase.withAlpha((255 * 0.12).toInt()),
  greenBase: ColorName.greenAlphaBase,
  greenAlpha72: ColorName.greenAlphaBase.withAlpha((255 * 0.72).toInt()),
  greenAlpha48: ColorName.greenAlphaBase.withAlpha((255 * 0.48).toInt()),
  greenAlpha24: ColorName.greenAlphaBase.withAlpha((255 * 0.24).toInt()),
  greenAlpha12: ColorName.greenAlphaBase.withAlpha((255 * 0.12).toInt()),
  periwinkleBase: ColorName.periwinkleAlphaBase,
  periwinkleAlpha72: ColorName.periwinkleAlphaBase.withAlpha((255 * 0.72).toInt()),
  periwinkleAlpha48: ColorName.periwinkleAlphaBase.withAlpha((255 * 0.48).toInt()),
  periwinkleAlpha24: ColorName.periwinkleAlphaBase.withAlpha((255 * 0.24).toInt()),
  periwinkleAlpha12: ColorName.periwinkleAlphaBase.withAlpha((255 * 0.12).toInt()),
  brick50: ColorName.brick50,
  brick200: ColorName.brick200,
  brick500: ColorName.brick500,
  brick600: ColorName.brick600,
  brick700: ColorName.brick700,
  staticBlack: ColorName.staticBlack,
  staticWhite: ColorName.staticWhite,
  backgroundBase: ColorName.grey50,
  backgroundAlternative: ColorName.grey0,
  backgroundElevated: ColorName.grey0,
  backgroundElevatedAlternative: ColorName.grey50,
  textPrimary: ColorName.grey900,
  textSecondary: ColorName.grey700,
  textTertiary: ColorName.grey600,
  textDisabled: ColorName.grey500,
  fillBase: ColorName.grey0,
  fillAlternative: ColorName.grey50,
  fillStrong: ColorName.grey200,
  fillEmphasize: ColorName.grey300,
  dividerPrimary: ColorName.grey100,
  dividerSecondary: ColorName.grey200,
  inverseBackground: ColorName.grey900,
  inverseText: ColorName.grey0,
  inverseDisabled: ColorName.grey400.withValues(alpha: 0.8),
  dimBackground: ColorName.staticBlack.withValues(alpha: 0.6),
  dimOverlay: ColorName.staticWhite.withValues(alpha: 0.76),
);

/// Dark Theme Colors
FitColors darkFitColors = FitColors(
  main: ColorName.green500Dark,
  sub: ColorName.periwinkle500Dark,
  grey0: ColorName.grey0Dark,
  grey50: ColorName.grey50Dark,
  grey900: ColorName.grey900Dark,
  grey800: ColorName.grey800Dark,
  grey700: ColorName.grey700Dark,
  grey600: ColorName.grey600Dark,
  grey500: ColorName.grey500Dark,
  grey400: ColorName.grey400Dark,
  grey300: ColorName.grey300Dark,
  grey200: ColorName.grey200Dark,
  grey100: ColorName.grey100Dark,
  green50: ColorName.green50Dark,
  green200: ColorName.green200Dark,
  green500: ColorName.green500Dark,
  green600: ColorName.green600Dark,
  green700: ColorName.green700Dark,
  periwinkle50: ColorName.periwinkle50Dark,
  periwinkle200: ColorName.periwinkle200Dark,
  periwinkle500: ColorName.periwinkle500Dark,
  periwinkle600: ColorName.periwinkle600Dark,
  periwinkle700: ColorName.periwinkle700Dark,
  red50: ColorName.red50Dark,
  red200: ColorName.red200Dark,
  red500: ColorName.red500Dark,
  red600: ColorName.red600Dark,
  red700: ColorName.red700Dark,
  redBase: ColorName.redAlphaBaseDark,
  redAlpha72: ColorName.redAlphaBaseDark.withAlpha((255 * 0.72).toInt()),
  redAlpha48: ColorName.redAlphaBaseDark.withAlpha((255 * 0.48).toInt()),
  redAlpha24: ColorName.redAlphaBaseDark.withAlpha((255 * 0.24).toInt()),
  redAlpha12: ColorName.redAlphaBaseDark.withAlpha((255 * 0.12).toInt()),
  yellowBase: ColorName.yellowAlphaBaseDark,
  blueAlphaBase: ColorName.blueAlphaBaseDark,
  blueAlpha72: ColorName.blueAlphaBaseDark.withAlpha((255 * 0.72).toInt()),
  blueAlpha48: ColorName.blueAlphaBaseDark.withAlpha((255 * 0.48).toInt()),
  blueAlpha24: ColorName.blueAlphaBaseDark.withAlpha((255 * 0.24).toInt()),
  blueAlpha12: ColorName.blueAlphaBaseDark.withAlpha((255 * 0.12).toInt()),
  yellowAlpha72: ColorName.yellowAlphaBaseDark.withAlpha((255 * 0.72).toInt()),
  yellowAlpha48: ColorName.yellowAlphaBaseDark.withAlpha((255 * 0.48).toInt()),
  yellowAlpha24: ColorName.yellowAlphaBaseDark.withAlpha((255 * 0.24).toInt()),
  yellowAlpha12: ColorName.yellowAlphaBaseDark.withAlpha((255 * 0.12).toInt()),
  greenBase: ColorName.greenAlphaBaseDark,
  greenAlpha72: ColorName.greenAlphaBaseDark.withAlpha((255 * 0.72).toInt()),
  greenAlpha48: ColorName.greenAlphaBaseDark.withAlpha((255 * 0.48).toInt()),
  greenAlpha24: ColorName.greenAlphaBaseDark.withAlpha((255 * 0.24).toInt()),
  greenAlpha12: ColorName.greenAlphaBaseDark.withAlpha((255 * 0.12).toInt()),
  periwinkleBase: ColorName.periwinkleAlphaBaseDark,
  periwinkleAlpha72: ColorName.periwinkleAlphaBaseDark.withAlpha((255 * 0.72).toInt()),
  periwinkleAlpha48: ColorName.periwinkleAlphaBaseDark.withAlpha((255 * 0.48).toInt()),
  periwinkleAlpha24: ColorName.periwinkleAlphaBaseDark.withAlpha((255 * 0.24).toInt()),
  periwinkleAlpha12: ColorName.periwinkleAlphaBaseDark.withAlpha((255 * 0.12).toInt()),
  brick50: ColorName.brick50Dark,
  brick200: ColorName.brick200Dark,
  brick500: ColorName.brick500Dark,
  brick600: ColorName.brick600Dark,
  brick700: ColorName.brick700Dark,
  staticBlack: ColorName.staticBlack,
  staticWhite: ColorName.staticWhite,
  backgroundBase: ColorName.grey0Dark,
  backgroundAlternative: ColorName.grey50Dark,
  backgroundElevated: ColorName.grey100Dark,
  backgroundElevatedAlternative: ColorName.grey50Dark,
  textPrimary: ColorName.grey900Dark,
  textSecondary: ColorName.grey700Dark,
  textTertiary: ColorName.grey600Dark,
  textDisabled: ColorName.grey500Dark,
  fillBase: ColorName.grey50Dark,
  fillAlternative: ColorName.grey100Dark,
  fillStrong: ColorName.grey200Dark,
  fillEmphasize: ColorName.grey300Dark,
  dividerPrimary: ColorName.grey100Dark,
  dividerSecondary: ColorName.grey200Dark,
  inverseBackground: ColorName.grey900Dark,
  inverseText: ColorName.grey0Dark,
  inverseDisabled: ColorName.grey0Dark,
  dimBackground: ColorName.staticBlack.withValues(alpha: 0.6),
  dimOverlay: ColorName.staticBlack.withValues(alpha: 0.76),
);

FitColors fitColors(BuildContext context) {
  return Theme.of(context).extension<FitColors>()!;
}

extension FitColorsExtension on BuildContext {
  FitColors get fitColors {
    return Theme.of(this).extension<FitColors>()!;
  }
}
