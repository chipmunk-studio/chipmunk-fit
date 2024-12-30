import 'package:chipfit/gen/colors.gen.dart';
import 'package:flutter/material.dart';

@immutable
class FitColors extends ThemeExtension<FitColors> {
  /// Grey Colors
  final Color grey900;
  final Color grey800;
  final Color grey700;
  final Color grey600;
  final Color grey500;
  final Color grey400;
  final Color grey300;
  final Color grey200;
  final Color grey100;

  /// Basic Colors
  final Color white;
  final Color black;

  /// Primary and Secondary
  final Color primary;
  final Color secondary;

  /// Positive and Negative
  final Color positive;
  final Color positiveLight;
  final Color negative;
  final Color negativeLight;
  final Color negativeDark;

  /// Warning
  final Color warning;
  final Color warningLight;

  /// Background
  final Color backgroundGrey;

  /// Brick Colors
  final Color brickBlight;
  final Color brickLight;
  final Color brickBase;
  final Color brickDark;

  const FitColors({
    required this.grey900,
    required this.grey800,
    required this.grey700,
    required this.grey600,
    required this.grey500,
    required this.grey400,
    required this.grey300,
    required this.grey200,
    required this.grey100,
    required this.white,
    required this.black,
    required this.primary,
    required this.secondary,
    required this.positive,
    required this.positiveLight,
    required this.negative,
    required this.negativeLight,
    required this.negativeDark,
    required this.warning,
    required this.warningLight,
    required this.backgroundGrey,
    required this.brickBlight,
    required this.brickLight,
    required this.brickBase,
    required this.brickDark,
  });

  @override
  FitColors copyWith({
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
    Color? primary,
    Color? secondary,
    Color? positive,
    Color? positiveLight,
    Color? negative,
    Color? negativeLight,
    Color? negativeDark,
    Color? warning,
    Color? warningLight,
    Color? backgroundGrey,
    Color? brickBlight,
    Color? brickLight,
    Color? brickBase,
    Color? brickDark,
  }) {
    return FitColors(
      grey900: grey900 ?? this.grey900,
      grey800: grey800 ?? this.grey800,
      grey700: grey700 ?? this.grey700,
      grey600: grey600 ?? this.grey600,
      grey500: grey500 ?? this.grey500,
      grey400: grey400 ?? this.grey400,
      grey300: grey300 ?? this.grey300,
      grey200: grey200 ?? this.grey200,
      grey100: grey100 ?? this.grey100,
      white: white ?? this.white,
      black: black ?? this.black,
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      positive: positive ?? this.positive,
      positiveLight: positiveLight ?? this.positiveLight,
      negative: negative ?? this.negative,
      negativeLight: negativeLight ?? this.negativeLight,
      negativeDark: negativeDark ?? this.negativeDark,
      warning: warning ?? this.warning,
      warningLight: warningLight ?? this.warningLight,
      backgroundGrey: backgroundGrey ?? this.backgroundGrey,
      brickBlight: brickBlight ?? this.brickBlight,
      brickLight: brickLight ?? this.brickLight,
      brickBase: brickBase ?? this.brickBase,
      brickDark: brickDark ?? this.brickDark,
    );
  }

  @override
  FitColors lerp(ThemeExtension<FitColors>? other, double t) {
    if (other is! FitColors) return this;
    return FitColors(
      grey900: Color.lerp(grey900, other.grey900, t) ?? grey900,
      grey800: Color.lerp(grey800, other.grey800, t) ?? grey800,
      grey700: Color.lerp(grey700, other.grey700, t) ?? grey700,
      grey600: Color.lerp(grey600, other.grey600, t) ?? grey600,
      grey500: Color.lerp(grey500, other.grey500, t) ?? grey500,
      grey400: Color.lerp(grey400, other.grey400, t) ?? grey400,
      grey300: Color.lerp(grey300, other.grey300, t) ?? grey300,
      grey200: Color.lerp(grey200, other.grey200, t) ?? grey200,
      grey100: Color.lerp(grey100, other.grey100, t) ?? grey100,
      white: Color.lerp(white, other.white, t) ?? white,
      black: Color.lerp(black, other.black, t) ?? black,
      primary: Color.lerp(primary, other.primary, t) ?? primary,
      secondary: Color.lerp(secondary, other.secondary, t) ?? secondary,
      positive: Color.lerp(positive, other.positive, t) ?? positive,
      positiveLight: Color.lerp(positiveLight, other.positiveLight, t) ?? positiveLight,
      negative: Color.lerp(negative, other.negative, t) ?? negative,
      negativeLight: Color.lerp(negativeLight, other.negativeLight, t) ?? negativeLight,
      negativeDark: Color.lerp(negativeDark, other.negativeDark, t) ?? negativeDark,
      warning: Color.lerp(warning, other.warning, t) ?? warning,
      warningLight: Color.lerp(warningLight, other.warningLight, t) ?? warningLight,
      backgroundGrey: Color.lerp(backgroundGrey, other.backgroundGrey, t) ?? backgroundGrey,
      brickBlight: Color.lerp(brickBlight, other.brickBlight, t) ?? brickBlight,
      brickLight: Color.lerp(brickLight, other.brickLight, t) ?? brickLight,
      brickBase: Color.lerp(brickBase, other.brickBase, t) ?? brickBase,
      brickDark: Color.lerp(brickDark, other.brickDark, t) ?? brickDark,
    );
  }
}

/// Light Theme Colors
const FitColors lightFitColors = FitColors(
  grey900: ColorName.black,
  grey800: ColorName.grey800,
  grey700: ColorName.grey700,
  grey600: ColorName.grey600,
  grey500: ColorName.grey500,
  grey400: ColorName.grey400,
  grey300: ColorName.grey300,
  grey200: ColorName.grey200,
  grey100: ColorName.grey100,
  white: Color(0xFFFFFFFF),
  black: Color(0xFF000000),
  primary: Color(0xFF13EF79),
  secondary: Color(0xFF471AFF),
  positive: Color(0xFF28AF58),
  positiveLight: Color(0xFFE6FAED),
  negative: Color(0xFFEF5248),
  negativeLight: Color(0xFFFAE1E1),
  negativeDark: Color(0xFF331D1D),
  warning: Color(0xFFEDBE13),
  warningLight: Color(0xFFF9F4E4),
  backgroundGrey: Color(0xFFF3F4F5),
  brickBlight: Color(0xFFFCEDEA),
  brickLight: Color(0xFFCD4E2E),
  brickBase: Color(0xFFB74326),
  brickDark: Color(0xFFA93A1E),
);

/// Dark Theme Colors
const FitColors darkFitColors = FitColors(
  grey900: ColorName.white,
  grey800: ColorName.grey800Alt,
  grey700: ColorName.grey700Alt,
  grey600: ColorName.grey600Alt,
  grey500: ColorName.grey500Alt,
  grey400: ColorName.grey400Alt,
  grey300: ColorName.grey300Alt,
  grey200: ColorName.grey200Alt,
  grey100: ColorName.grey100Alt,
  white: Color(0xFFFFFFFF),
  black: Color(0xFF000000),
  primary: Color(0xFF13EF79),
  secondary: Color(0xFF471AFF),
  positive: Color(0xFF28AF58),
  positiveLight: Color(0xFFE6FAED),
  negative: Color(0xFFEF5248),
  negativeLight: Color(0xFFFAE1E1),
  negativeDark: Color(0xFF331D1D),
  warning: Color(0xFFEDBE13),
  warningLight: Color(0xFFF9F4E4),
  backgroundGrey: Color(0xFFF3F4F5),
  brickBlight: Color(0xFFFCEDEA),
  brickLight: Color(0xFFCD4E2E),
  brickBase: Color(0xFFB74326),
  brickDark: Color(0xFFA93A1E),
);

FitColors fitColors(BuildContext context) {
  return Theme.of(context).extension<FitColors>()!;
}

extension FitColorsExtension on BuildContext {
  FitColors get fitColors {
    return Theme.of(this).extension<FitColors>()!;
  }
}
