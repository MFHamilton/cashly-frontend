import 'package:flutter/material.dart';
import 'package:cashly/core/constants/app_color.dart';

class AppColorScheme {
  static const light = ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primary,
      onPrimary: AppColors.background,
      primaryContainer: AppColors.primaryContainer,
      onPrimaryContainer: AppColors.onPrimaryContainer,
      secondary: AppColors.secondary,
      onSecondary: AppColors.background,
      tertiary: AppColors.accent,
      onTertiary: AppColors.background,
      error: AppColors.danger,
      onError: AppColors.background,
      surface: AppColors.background,
      onSurface: AppColors.textPrimary);
}