import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  // Display Styles
  static TextStyle get displayLarge => TextStyle(
        fontSize: 57,
        fontWeight: FontWeight.w400,
        letterSpacing: -0.25,
        height: 1.12,
      );

  static TextStyle get displayMedium => TextStyle(
        fontSize: 45,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        height: 1.16,
      );

  static TextStyle get displaySmall => TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        height: 1.22,
      );

  // Headline Styles
  static TextStyle get headlineLarge => TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        height: 1.25,
      );

  static TextStyle get headlineMedium => TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        height: 1.29,
      );

  static TextStyle get headlineSmall => TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        height: 1.33,
      );

  // Title Styles
  static TextStyle get titleLarge => TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        height: 1.27,
      );

  static TextStyle get titleMedium => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
        height: 1.5,
      );

  static TextStyle get titleSmall => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        height: 1.43,
      );

  // Body Styles
  static TextStyle get bodyLarge => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
        height: 1.5,
      );

  static TextStyle get bodyMedium => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        height: 1.43,
      );

  static TextStyle get bodySmall => TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
        color: AppColors.textSecondary,
        height: 1.33,
      );

  // Label Styles
  static TextStyle get labelLarge => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        height: 1.43,
      );

  static TextStyle get labelMedium => TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        height: 1.33,
      );

  static TextStyle get labelSmall => TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        color: AppColors.textSecondary,
        height: 1.45,
      );

  // Custom Styles
  static TextStyle get button => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        height: 1.43,
      );

  static TextStyle get caption => TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
        color: AppColors.textSecondary,
        height: 1.33,
      );

  static TextStyle get overline => TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w400,
        letterSpacing: 1.5,
        color: AppColors.textSecondary,
        height: 1.6,
      );

  // Specialized Styles
  static TextStyle get primaryText => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.primary,
        height: 1.5,
      );

  static TextStyle get secondaryText => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.secondary,
        height: 1.5,
      );

  static TextStyle get errorText => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.error,
        height: 1.43,
      );

  static TextStyle get successText => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.success,
        height: 1.43,
      );

  static TextStyle get warningText => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.warning,
        height: 1.43,
      );

  static TextStyle get infoText => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.info,
        height: 1.43,
      );

  static TextStyle get hintText => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.textHint,
        height: 1.43,
      );

  static TextStyle get disabledText => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.textDisabled,
        height: 1.43,
      );

  // Input Styles
  static TextStyle get inputText => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.5,
      );

  static TextStyle get inputLabel => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.textSecondary,
        height: 1.43,
      );

  static TextStyle get inputHint => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.textHint,
        height: 1.5,
      );

  // Card Styles
  static TextStyle get cardTitle => TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        height: 1.33,
      );

  static TextStyle get cardSubtitle => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
        height: 1.43,
      );

  static TextStyle get cardBody => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.43,
      );

  // Navigation Styles
  static TextStyle get navTitle => TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        height: 1.2,
      );

  static TextStyle get navSubtitle => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
        height: 1.43,
      );

  // Utility method to create custom text style
  static TextStyle custom({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? height,
    double? letterSpacing,
    TextDecoration? decoration,
    Paint? foreground,
  }) {
    return TextStyle(
      fontSize: fontSize ?? 14,
      fontWeight: fontWeight ?? FontWeight.w400,
      color: color ?? AppColors.textPrimary,
      height: height ?? 1.43,
      letterSpacing: letterSpacing,
      decoration: decoration,
      foreground: foreground,
    );
  }

  // Utility method to create text style with specific color
  static TextStyle withColor(TextStyle baseStyle, Color color) {
    return baseStyle.copyWith(color: color);
  }

  // Utility method to create text style with specific size
  static TextStyle withSize(TextStyle baseStyle, double size) {
    return baseStyle.copyWith(fontSize: size);
  }

  // Utility method to create text style with specific weight
  static TextStyle withWeight(TextStyle baseStyle, FontWeight weight) {
    return baseStyle.copyWith(fontWeight: weight);
  }
}
