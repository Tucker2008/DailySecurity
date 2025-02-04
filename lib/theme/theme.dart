import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4281099147),
      surfaceTint: Color(4281099147),
      onPrimary: Color(4281099147),
      primaryContainer: Color(4291618303),
      onPrimaryContainer: Color(4278197553),
      secondary: Color(4283523183),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4292142326),
      onSecondaryContainer: Color(4279049514),
      tertiary: Color(4284962938),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4293778687),
      onTertiaryContainer: Color(4280423732),
      error: Color(4290386458),
      onError: Color(4294967295),
      errorContainer: Color(4294957782),
      onErrorContainer: Color(4282449922),
      surface: Color(4294441471),
      onSurface: Color(4279770144),
      onSurfaceVariant: Color(4282533710),
      outline: Color(4285692030),
      outlineVariant: Color(4290955214),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281151797),
      inversePrimary: Color(4288269562),
      primaryFixed: Color(4291618303),
      onPrimaryFixed: Color(4278197553),
      primaryFixedDim: Color(4288269562),
      onPrimaryFixedVariant: Color(4278668146),
      secondaryFixed: Color(4292142326),
      onSecondaryFixed: Color(4279049514),
      secondaryFixedDim: Color(4290300122),
      onSecondaryFixedVariant: Color(4281944151),
      tertiaryFixed: Color(4293778687),
      onTertiaryFixed: Color(4280423732),
      tertiaryFixedDim: Color(4291936231),
      onTertiaryFixedVariant: Color(4283318625),
      surfaceDim: Color(4292336351),
      surfaceBright: Color(4294441471),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294046969),
      surfaceContainer: Color(4293652211),
      surfaceContainerHigh: Color(4293322990),
      surfaceContainerHighest: Color(4292928232),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4278208365),
      surfaceTint: Color(4281099147),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4282743203),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4281680979),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4284970630),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4283055453),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4286410386),
      onTertiaryContainer: Color(4294967295),
      error: Color(4287365129),
      onError: Color(4294967295),
      errorContainer: Color(4292490286),
      onErrorContainer: Color(4294967295),
      surface: Color(4294441471),
      onSurface: Color(4279770144),
      onSurfaceVariant: Color(4282270538),
      outline: Color(4284112998),
      outlineVariant: Color(4285954946),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281151797),
      inversePrimary: Color(4288269562),
      primaryFixed: Color(4282743203),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4280901768),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4284970630),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4283326061),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4286410386),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4284765816),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4292336351),
      surfaceBright: Color(4294441471),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294046969),
      surfaceContainer: Color(4293652211),
      surfaceContainerHigh: Color(4293322990),
      surfaceContainerHighest: Color(4292928232),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4278199355),
      surfaceTint: Color(4281099147),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4278208365),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4279510065),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4281680979),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4280884283),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4283055453),
      onTertiaryContainer: Color(4294967295),
      error: Color(4283301890),
      onError: Color(4294967295),
      errorContainer: Color(4287365129),
      onErrorContainer: Color(4294967295),
      surface: Color(4294441471),
      onSurface: Color(4278190080),
      onSurfaceVariant: Color(4280230954),
      outline: Color(4282270538),
      outlineVariant: Color(4282270538),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281151797),
      inversePrimary: Color(4292800255),
      primaryFixed: Color(4278208365),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4278202187),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4281680979),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4280233532),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4283055453),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4281542470),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4292336351),
      surfaceBright: Color(4294441471),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294046969),
      surfaceContainer: Color(4293652211),
      surfaceContainerHigh: Color(4293322990),
      surfaceContainerHighest: Color(4292928232),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4288269562),
      surfaceTint: Color(4288269562),
      onPrimary: Color(4278203217),
      primaryContainer: Color(4278668146),
      onPrimaryContainer: Color(4291618303),
      secondary: Color(4290300122),
      onSecondary: Color(4280496703),
      secondaryContainer: Color(4281944151),
      onSecondaryContainer: Color(4292142326),
      tertiary: Color(4291936231),
      onTertiary: Color(4281805386),
      tertiaryContainer: Color(4283318625),
      onTertiaryContainer: Color(4293778687),
      error: Color(4294948011),
      onError: Color(4285071365),
      errorContainer: Color(4287823882),
      onErrorContainer: Color(4294957782),
      surface: Color(4279243800),
      onSurface: Color(4292928232),
      onSurfaceVariant: Color(4290955214),
      outline: Color(4287402392),
      outlineVariant: Color(4282533710),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4292928232),
      inversePrimary: Color(4281099147),
      primaryFixed: Color(4291618303),
      onPrimaryFixed: Color(4278197553),
      primaryFixedDim: Color(4288269562),
      onPrimaryFixedVariant: Color(4278668146),
      secondaryFixed: Color(4292142326),
      onSecondaryFixed: Color(4279049514),
      secondaryFixedDim: Color(4290300122),
      onSecondaryFixedVariant: Color(4281944151),
      tertiaryFixed: Color(4293778687),
      onTertiaryFixed: Color(4280423732),
      tertiaryFixedDim: Color(4291936231),
      onTertiaryFixedVariant: Color(4283318625),
      surfaceDim: Color(4279243800),
      surfaceBright: Color(4281743678),
      surfaceContainerLowest: Color(4278914834),
      surfaceContainerLow: Color(4279770144),
      surfaceContainer: Color(4280033316),
      surfaceContainerHigh: Color(4280756782),
      surfaceContainerHighest: Color(4281414969),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4288532734),
      surfaceTint: Color(4288269562),
      onPrimary: Color(4278196265),
      primaryContainer: Color(4284716737),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4290563294),
      onSecondary: Color(4278655012),
      secondaryContainer: Color(4286812835),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4292264939),
      onTertiary: Color(4280029230),
      tertiaryContainer: Color(4288318127),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294949553),
      onError: Color(4281794561),
      errorContainer: Color(4294923337),
      onErrorContainer: Color(4278190080),
      surface: Color(4279243800),
      onSurface: Color(4294573055),
      onSurfaceVariant: Color(4291218387),
      outline: Color(4288586667),
      outlineVariant: Color(4286481547),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4292928232),
      inversePrimary: Color(4278865011),
      primaryFixed: Color(4291618303),
      onPrimaryFixed: Color(4278194977),
      primaryFixedDim: Color(4288269562),
      onPrimaryFixedVariant: Color(4278204762),
      secondaryFixed: Color(4292142326),
      onSecondaryFixed: Color(4278391327),
      secondaryFixedDim: Color(4290300122),
      onSecondaryFixedVariant: Color(4280891461),
      tertiaryFixed: Color(4293778687),
      onTertiaryFixed: Color(4279700008),
      tertiaryFixedDim: Color(4291936231),
      onTertiaryFixedVariant: Color(4282200144),
      surfaceDim: Color(4279243800),
      surfaceBright: Color(4281743678),
      surfaceContainerLowest: Color(4278914834),
      surfaceContainerLow: Color(4279770144),
      surfaceContainer: Color(4280033316),
      surfaceContainerHigh: Color(4280756782),
      surfaceContainerHighest: Color(4281414969),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4294573055),
      surfaceTint: Color(4288269562),
      onPrimary: Color(4278190080),
      primaryContainer: Color(4288532734),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4294573055),
      onSecondary: Color(4278190080),
      secondaryContainer: Color(4290563294),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4294965757),
      onTertiary: Color(4278190080),
      tertiaryContainer: Color(4292264939),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294965753),
      onError: Color(4278190080),
      errorContainer: Color(4294949553),
      onErrorContainer: Color(4278190080),
      surface: Color(4279243800),
      onSurface: Color(4294967295),
      onSurfaceVariant: Color(4294573055),
      outline: Color(4291218387),
      outlineVariant: Color(4291218387),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4292928232),
      inversePrimary: Color(4278201671),
      primaryFixed: Color(4292209151),
      onPrimaryFixed: Color(4278190080),
      primaryFixedDim: Color(4288532734),
      onPrimaryFixedVariant: Color(4278196265),
      secondaryFixed: Color(4292405755),
      onSecondaryFixed: Color(4278190080),
      secondaryFixedDim: Color(4290563294),
      onSecondaryFixedVariant: Color(4278655012),
      tertiaryFixed: Color(4293976575),
      onTertiaryFixed: Color(4278190080),
      tertiaryFixedDim: Color(4292264939),
      onTertiaryFixedVariant: Color(4280029230),
      surfaceDim: Color(4279243800),
      surfaceBright: Color(4281743678),
      surfaceContainerLowest: Color(4278914834),
      surfaceContainerLow: Color(4279770144),
      surfaceContainer: Color(4280033316),
      surfaceContainerHigh: Color(4280756782),
      surfaceContainerHighest: Color(4281414969),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        textTheme: textTheme.apply(
          bodyColor: colorScheme.onSurface,
          displayColor: colorScheme.onSurface,
        ),
        //  scaffoldBackgroundColor: colorScheme.background,  // alert
        scaffoldBackgroundColor: colorScheme.surface,
        canvasColor: colorScheme.surface,
      );

  List<ExtendedColor> get extendedColors => [];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
