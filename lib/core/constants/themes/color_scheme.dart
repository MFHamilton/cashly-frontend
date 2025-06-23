import 'package:flutter/material.dart';
import '../app_color.dart';

class AppColorScheme {
  static const light = ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primary,
      onPrimary: AppColors.background,
      secondary: AppColors.secondary,
      onSecondary: AppColors.background,
      error: AppColors.danger,
      onError: AppColors.background,
      surface: AppColors.background,
      onSurface: AppColors.textPrimary);
}