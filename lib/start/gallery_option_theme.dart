import 'package:flutter/material.dart';
import 'package:lingui_quest/start/color_schemes.g.dart';

class GalleryOptionTheme {
  static const _lightFillColor = Colors.black;
  static const _darkFillColor = Colors.white;

  static ThemeData lightThemeData = themeData(lightColorScheme);
  static ThemeData darkThemeData = themeData(darkColorScheme);

  static ThemeData themeData(ColorScheme colorScheme) {
    return ThemeData(
      useMaterial3: true,
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: colorScheme.background,
      ),
      //TextTheme fonts based on the design. Use textTheme or primaryTextTheme depending on the font size which you need
      //600 - semibold, 300-light, 500-medium, 400-regular
      textTheme: TextTheme(
        displayLarge: TextStyle(fontSize: 64, fontWeight: FontWeight.w600, color: colorScheme.onPrimary),
        displayMedium: TextStyle(fontSize: 40, fontWeight: FontWeight.w600, color: colorScheme.onPrimary),
        displaySmall: TextStyle(fontSize: 40, fontWeight: FontWeight.w300, color: colorScheme.onPrimary),
        //
        headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w300, color: colorScheme.onPrimary),
        headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w600, color: colorScheme.onPrimary),
        headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: colorScheme.onPrimary),
        //
        titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w300, color: colorScheme.onPrimary),
        titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: colorScheme.onPrimary),
        titleSmall: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: colorScheme.onPrimary),
        //
        bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: colorScheme.onPrimary),
        bodyMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w300, color: colorScheme.onPrimary),
        bodySmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: colorScheme.onPrimary),
        //
        labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: colorScheme.onPrimary),
        labelMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w300, color: colorScheme.onPrimary),
        labelSmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: colorScheme.onPrimary),
      ),
      primaryTextTheme: TextTheme(
        bodyLarge: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: colorScheme.onPrimary),
        bodyMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w300, color: colorScheme.onPrimary),
        bodySmall: TextStyle(fontSize: 10, fontWeight: FontWeight.w400, color: colorScheme.onPrimary),
        //
        labelLarge: TextStyle(fontSize: 10, fontWeight: FontWeight.w300, color: colorScheme.onPrimary),
      ),
      focusColor: colorScheme.primary,
      fontFamily: 'Unbounded',
      primaryColor: colorScheme.primary,
      cardColor: colorScheme.surface,
      appBarTheme: AppBarTheme(
        color: colorScheme.background,
        elevation: 0,
        iconTheme: IconThemeData(color: colorScheme.onPrimary),
      ),
      iconTheme: IconThemeData(color: colorScheme.onPrimary),
      canvasColor: colorScheme.background,
      scaffoldBackgroundColor: colorScheme.background,
      highlightColor: colorScheme.primary,
      secondaryHeaderColor: colorScheme.secondary,
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: <TargetPlatform, PageTransitionsBuilder>{
          TargetPlatform.android: ZoomPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Color.alphaBlend(
          _lightFillColor.withOpacity(0.80),
          _darkFillColor,
        ),
      ),
      dialogBackgroundColor: colorScheme.surface,
      hintColor: colorScheme.primary.withOpacity(0.3),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      splashColor: Colors.transparent,
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return null;
          }
          if (states.contains(MaterialState.selected)) {
            return Colors.white;
          }
          return null;
        }),
        checkColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return null;
          }
          if (states.contains(MaterialState.selected)) {
            return colorScheme.onSecondaryContainer;
          }
          return null;
        }),
      ),
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return null;
          }
          if (states.contains(MaterialState.selected)) {
            return Colors.white;
          }
          return null;
        }),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return null;
          }
          if (states.contains(MaterialState.selected)) {
            return Colors.white;
          }
          return null;
        }),
        trackColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return null;
          }
          if (states.contains(MaterialState.selected)) {
            return Colors.white;
          }
          return null;
        }),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme.primary,
              elevation: 2,
              textStyle:
                  TextStyle(fontSize: 10, fontWeight: FontWeight.w300, color: colorScheme.onSecondaryContainer))),
      bottomAppBarTheme: BottomAppBarTheme(color: colorScheme.primary),
      colorScheme: colorScheme,
    );
  }
}
