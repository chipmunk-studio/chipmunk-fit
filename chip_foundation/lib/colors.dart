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

  // Violet (Purple)
  final Color violet50;
  final Color violet200;
  final Color violet500;
  final Color violet600;
  final Color violet700;

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

  // Leaf Green
  final Color leafGreen50;
  final Color leafGreen200;
  final Color leafGreen500;
  final Color leafGreen600;
  final Color leafGreen700;

  // Alpha Colors - Periwinkle
  final Color periwinkleBase;
  final Color periwinkleAlpha72;
  final Color periwinkleAlpha48;
  final Color periwinkleAlpha24;
  final Color periwinkleAlpha12;

  // Alpha Colors - Violet
  final Color violetBase;
  final Color violetAlpha72;
  final Color violetAlpha48;
  final Color violetAlpha24;
  final Color violetAlpha12;

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
    required this.leafGreen50,
    required this.leafGreen200,
    required this.leafGreen500,
    required this.leafGreen600,
    required this.leafGreen700,
    required this.periwinkle50,
    required this.periwinkle200,
    required this.periwinkle500,
    required this.periwinkle600,
    required this.periwinkle700,
    required this.violet50,
    required this.violet200,
    required this.violet500,
    required this.violet600,
    required this.violet700,
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
    required this.violetBase,
    required this.violetAlpha72,
    required this.violetAlpha48,
    required this.violetAlpha24,
    required this.violetAlpha12,
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
    Color? leafGreen50,
    Color? leafGreen200,
    Color? leafGreen500,
    Color? leafGreen600,
    Color? leafGreen700,
    Color? periwinkle50,
    Color? periwinkle200,
    Color? periwinkle500,
    Color? periwinkle600,
    Color? periwinkle700,
    Color? violet50,
    Color? violet200,
    Color? violet500,
    Color? violet600,
    Color? violet700,
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
    Color? violetBase,
    Color? violetAlpha72,
    Color? violetAlpha48,
    Color? violetAlpha24,
    Color? violetAlpha12,
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
      leafGreen50: leafGreen50 ?? this.leafGreen50,
      leafGreen200: leafGreen200 ?? this.leafGreen200,
      leafGreen500: leafGreen500 ?? this.leafGreen500,
      leafGreen600: leafGreen600 ?? this.leafGreen600,
      leafGreen700: leafGreen700 ?? this.leafGreen700,
      periwinkle50: periwinkle50 ?? this.periwinkle50,
      periwinkle200: periwinkle200 ?? this.periwinkle200,
      periwinkle500: periwinkle500 ?? this.periwinkle500,
      periwinkle600: periwinkle600 ?? this.periwinkle600,
      periwinkle700: periwinkle700 ?? this.periwinkle700,
      violet50: violet50 ?? this.violet50,
      violet200: violet200 ?? this.violet200,
      violet500: violet500 ?? this.violet500,
      violet600: violet600 ?? this.violet600,
      violet700: violet700 ?? this.violet700,
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
      violetBase: violetBase ?? this.violetBase,
      violetAlpha72: violetAlpha72 ?? this.violetAlpha72,
      violetAlpha48: violetAlpha48 ?? this.violetAlpha48,
      violetAlpha24: violetAlpha24 ?? this.violetAlpha24,
      violetAlpha12: violetAlpha12 ?? this.violetAlpha12,
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
    return t < 0.5 ? this : other;
  }
}

/// Alpha 값 생성 헬퍼
Color _withOpacity(Color base, double opacity) {
  return base.withValues(alpha: opacity);
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
  leafGreen50: ChipColors.leafGreen50,
  leafGreen200: ChipColors.leafGreen200,
  leafGreen500: ChipColors.leafGreen500,
  leafGreen600: ChipColors.leafGreen600,
  leafGreen700: ChipColors.leafGreen700,
  periwinkle50: ChipColors.periwinkle50,
  periwinkle200: ChipColors.periwinkle200,
  periwinkle500: ChipColors.periwinkle500,
  periwinkle600: ChipColors.periwinkle600,
  periwinkle700: ChipColors.periwinkle700,
  violet50: ChipColors.violet50,
  violet200: ChipColors.violet200,
  violet500: ChipColors.violet500,
  violet600: ChipColors.violet600,
  violet700: ChipColors.violet700,
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
  redAlpha72: _withOpacity(ChipColors.redAlphaBase, 0.72),
  redAlpha48: _withOpacity(ChipColors.redAlphaBase, 0.48),
  redAlpha24: _withOpacity(ChipColors.redAlphaBase, 0.24),
  redAlpha12: _withOpacity(ChipColors.redAlphaBase, 0.12),
  blueAlphaBase: ChipColors.blueAlphaBase,
  blueAlpha72: _withOpacity(ChipColors.blueAlphaBase, 0.72),
  blueAlpha48: _withOpacity(ChipColors.blueAlphaBase, 0.48),
  blueAlpha24: _withOpacity(ChipColors.blueAlphaBase, 0.24),
  blueAlpha12: _withOpacity(ChipColors.blueAlphaBase, 0.12),
  yellowBase: ChipColors.yellowAlphaBase,
  yellowAlpha72: _withOpacity(ChipColors.yellowAlphaBase, 0.72),
  yellowAlpha48: _withOpacity(ChipColors.yellowAlphaBase, 0.48),
  yellowAlpha24: _withOpacity(ChipColors.yellowAlphaBase, 0.24),
  yellowAlpha12: _withOpacity(ChipColors.yellowAlphaBase, 0.12),
  greenBase: ChipColors.greenAlphaBase,
  greenAlpha72: _withOpacity(ChipColors.greenAlphaBase, 0.72),
  greenAlpha48: _withOpacity(ChipColors.greenAlphaBase, 0.48),
  greenAlpha24: _withOpacity(ChipColors.greenAlphaBase, 0.24),
  greenAlpha12: _withOpacity(ChipColors.greenAlphaBase, 0.12),
  periwinkleBase: ChipColors.periwinkleAlphaBase,
  periwinkleAlpha72: _withOpacity(ChipColors.periwinkleAlphaBase, 0.72),
  periwinkleAlpha48: _withOpacity(ChipColors.periwinkleAlphaBase, 0.48),
  periwinkleAlpha24: _withOpacity(ChipColors.periwinkleAlphaBase, 0.24),
  periwinkleAlpha12: _withOpacity(ChipColors.periwinkleAlphaBase, 0.12),
  violetBase: ChipColors.violetAlphaBase,
  violetAlpha72: _withOpacity(ChipColors.violetAlphaBase, 0.72),
  violetAlpha48: _withOpacity(ChipColors.violetAlphaBase, 0.48),
  violetAlpha24: _withOpacity(ChipColors.violetAlphaBase, 0.24),
  violetAlpha12: _withOpacity(ChipColors.violetAlphaBase, 0.12),
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
  inverseDisabled: _withOpacity(ChipColors.grey400, 0.8),
  dimBackground: _withOpacity(ChipColors.staticBlack, 0.6),
  dimOverlay: _withOpacity(ChipColors.staticWhite, 0.76),
  dimCard: _withOpacity(const Color(0xFFEFEFEF), 0.72),
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
  leafGreen50: ChipColors.leafGreen50Dark,
  leafGreen200: ChipColors.leafGreen200Dark,
  leafGreen500: ChipColors.leafGreen500Dark,
  leafGreen600: ChipColors.leafGreen600Dark,
  leafGreen700: ChipColors.leafGreen700Dark,
  periwinkle50: ChipColors.periwinkle50Dark,
  periwinkle200: ChipColors.periwinkle200Dark,
  periwinkle500: ChipColors.periwinkle500Dark,
  periwinkle600: ChipColors.periwinkle600Dark,
  periwinkle700: ChipColors.periwinkle700Dark,
  violet50: ChipColors.violet50Dark,
  violet200: ChipColors.violet200Dark,
  violet500: ChipColors.violet500Dark,
  violet600: ChipColors.violet600Dark,
  violet700: ChipColors.violet700Dark,
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
  redAlpha72: _withOpacity(ChipColors.redAlphaBaseDark, 0.72),
  redAlpha48: _withOpacity(ChipColors.redAlphaBaseDark, 0.48),
  redAlpha24: _withOpacity(ChipColors.redAlphaBaseDark, 0.24),
  redAlpha12: _withOpacity(ChipColors.redAlphaBaseDark, 0.12),
  blueAlphaBase: ChipColors.blueAlphaBaseDark,
  blueAlpha72: _withOpacity(ChipColors.blueAlphaBaseDark, 0.72),
  blueAlpha48: _withOpacity(ChipColors.blueAlphaBaseDark, 0.48),
  blueAlpha24: _withOpacity(ChipColors.blueAlphaBaseDark, 0.24),
  blueAlpha12: _withOpacity(ChipColors.blueAlphaBaseDark, 0.12),
  yellowBase: ChipColors.yellowAlphaBaseDark,
  yellowAlpha72: _withOpacity(ChipColors.yellowAlphaBaseDark, 0.72),
  yellowAlpha48: _withOpacity(ChipColors.yellowAlphaBaseDark, 0.48),
  yellowAlpha24: _withOpacity(ChipColors.yellowAlphaBaseDark, 0.24),
  yellowAlpha12: _withOpacity(ChipColors.yellowAlphaBaseDark, 0.12),
  greenBase: ChipColors.greenAlphaBaseDark,
  greenAlpha72: _withOpacity(ChipColors.greenAlphaBaseDark, 0.72),
  greenAlpha48: _withOpacity(ChipColors.greenAlphaBaseDark, 0.48),
  greenAlpha24: _withOpacity(ChipColors.greenAlphaBaseDark, 0.24),
  greenAlpha12: _withOpacity(ChipColors.greenAlphaBaseDark, 0.12),
  periwinkleBase: ChipColors.periwinkleAlphaBaseDark,
  periwinkleAlpha72: _withOpacity(ChipColors.periwinkleAlphaBaseDark, 0.72),
  periwinkleAlpha48: _withOpacity(ChipColors.periwinkleAlphaBaseDark, 0.48),
  periwinkleAlpha24: _withOpacity(ChipColors.periwinkleAlphaBaseDark, 0.24),
  periwinkleAlpha12: _withOpacity(ChipColors.periwinkleAlphaBaseDark, 0.12),
  violetBase: ChipColors.violetAlphaBaseDark,
  violetAlpha72: _withOpacity(ChipColors.violetAlphaBaseDark, 0.72),
  violetAlpha48: _withOpacity(ChipColors.violetAlphaBaseDark, 0.48),
  violetAlpha24: _withOpacity(ChipColors.violetAlphaBaseDark, 0.24),
  violetAlpha12: _withOpacity(ChipColors.violetAlphaBaseDark, 0.12),
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
  dimBackground: _withOpacity(ChipColors.staticBlack, 0.6),
  dimOverlay: _withOpacity(ChipColors.staticBlack, 0.76),
  dimCard: _withOpacity(const Color(0xFF0D0D0D), 0.72),
);

/// BuildContext Extension으로 FitColors 쉽게 접근
extension FitColorsExtension on BuildContext {
  FitColors get fitColors {
    return Theme.of(this).extension<FitColors>()!;
  }
}
