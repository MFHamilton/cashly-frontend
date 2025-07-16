import 'package:cashly/core/themes/button_theme.dart';
import 'package:flutter/material.dart';
import 'color_scheme.dart';
import 'text_scheme.dart';

class AppTheme{
  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    colorScheme: AppColorScheme.light,
    textTheme: MyTextTheme.lightTextTheme,
    elevatedButtonTheme: AppButtonTheme.primaryElevatedButtonTheme,

  );
}