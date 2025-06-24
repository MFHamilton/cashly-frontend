import 'package:cashly/core/themes/text_scheme.dart';
import 'package:flutter/material.dart';
import 'color_scheme.dart';

class AppButtonTheme {
  static final btn = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColorScheme.light.tertiary,
      foregroundColor: AppColorScheme.light.onTertiary,
      textStyle: MyTextTheme.lightTextTheme.bodyLarge,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
      minimumSize: Size(double.infinity, 50),
    ),
  );
}
