import 'package:flutter/material.dart';
import 'color_scheme.dart';

class AppButtonTheme {
  static final btn = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColorScheme.light.tertiary,
      foregroundColor: AppColorScheme.light.onTertiary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );
}
