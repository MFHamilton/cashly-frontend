import 'package:cashly/core/themes/text_scheme.dart';
import 'package:flutter/material.dart';
import 'color_scheme.dart';

class AppButtonTheme {
  static final ButtonStyle primaryElevatedButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: AppColorScheme.light.tertiary,
    foregroundColor: AppColorScheme.light.onTertiary,
    textStyle: MyTextTheme.lightTextTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w600
    ),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
    minimumSize: Size(double.infinity, 50),
  );

  static final ElevatedButtonThemeData primaryElevatedButtonTheme = ElevatedButtonThemeData(
    style: primaryElevatedButtonStyle, // Use the ButtonStyle defined above
  );

  static final ButtonStyle secondaryElevatedButtonStyle = ElevatedButton.styleFrom(
    // TODO : check por que no puedo usar theme.of(context).colorScheme.secondary
    backgroundColor: AppColorScheme.light.error,
    foregroundColor: AppColorScheme.light.onTertiary,
    textStyle: MyTextTheme.lightTextTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w600
    ),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
    minimumSize: Size(double.infinity, 50),
  );

  static final ElevatedButtonThemeData secondaryElevatedButtonTheme = ElevatedButtonThemeData(
    style: secondaryElevatedButtonStyle,
  );

}
