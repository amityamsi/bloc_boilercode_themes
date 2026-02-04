import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF1976D2);
  static const Color primaryVariant = Color(0xFF1565C0);
  static const Color primaryLight = Color(0xFF42A5F5);
  static const Color primaryDark = Color(0xFF0D47A1);
  
  // Secondary Colors
  static const Color secondary = Color(0xFFFF9800);
  static const Color secondaryVariant = Color(0xFFF57C00);
  static const Color secondaryLight = Color(0xFFFFB74D);
  static const Color secondaryDark = Color(0xFFE65100);
  
  // Background Colors
  static const Color background = Color(0xFFFAFAFA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color scaffoldBackground = Color(0xFFFAFAFA);
  
  // Text Colors
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textHint = Color(0xFFBDBDBD);
  static const Color textDisabled = Color(0xFFE0E0E0);
  
  // Icon Colors
  static const Color iconPrimary = Color(0xFF212121);
  static const Color iconSecondary = Color(0xFF757575);
  static const Color iconDisabled = Color(0xFFE0E0E0);
  
  // Border Colors
  static const Color border = Color(0xFFE0E0E0);
  static const Color borderLight = Color(0xFFF5F5F5);
  static const Color divider = Color(0xFFE0E0E0);
  
  // Status Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFF44336);
  static const Color info = Color(0xFF2196F3);
  
  // Dark Theme Colors
  static const Color darkPrimary = Color(0xFF2979FF);
  static const Color darkPrimaryVariant = Color(0xFF00FFF0);
  static const Color darkPrimaryLight = Color(0xFF82B1FF);
  static const Color darkPrimaryDark = Color(0xFF004BA0);
  
  static const Color darkSecondary = Color(0xFFFF2D95);
  static const Color darkSecondaryVariant = Color(0xFFB388FF);
  static const Color darkSecondaryLight = Color(0xFFFFB1E6);
  static const Color darkSecondaryDark = Color(0xFF8C1AFF);
  
  static const Color darkBackground = Color(0xFF0A0F1C);
  static const Color darkSurface = Color(0xFF18213A);
  static const Color darkCardBackground = Color(0xFF18213A);
  static const Color darkScaffoldBackground = Color(0xFF0A0F1C);
  
  static const Color darkTextPrimary = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFFB0BEC5);
  static const Color darkTextHint = Color(0xFF90A4AE);
  static const Color darkTextDisabled = Color(0xFF546E7A);
  
  static const Color darkIconPrimary = Color(0xFFFFFFFF);
  static const Color darkIconSecondary = Color(0xFFB0BEC5);
  static const Color darkIconDisabled = Color(0xFF546E7A);
  
  static const Color darkBorder = Color(0xFF23395D);
  static const Color darkBorderLight = Color(0xFF1B263B);
  static const Color darkDivider = Color(0xFF23395D);
  
  // Helper method to get colors based on theme mode
  static Color getPrimaryColor(bool isDarkMode) {
    return isDarkMode ? darkPrimary : primary;
  }
  
  static Color getSecondaryColor(bool isDarkMode) {
    return isDarkMode ? darkSecondary : secondary;
  }
  
  static Color getBackgroundColor(bool isDarkMode) {
    return isDarkMode ? darkBackground : background;
  }
  
  static Color getSurfaceColor(bool isDarkMode) {
    return isDarkMode ? darkSurface : surface;
  }
  
  static Color getCardBackgroundColor(bool isDarkMode) {
    return isDarkMode ? darkCardBackground : cardBackground;
  }
  
  static Color getTextPrimaryColor(bool isDarkMode) {
    return isDarkMode ? darkTextPrimary : textPrimary;
  }
  
  static Color getTextSecondaryColor(bool isDarkMode) {
    return isDarkMode ? darkTextSecondary : textSecondary;
  }
  
  static Color getBorderColor(bool isDarkMode) {
    return isDarkMode ? darkBorder : border;
  }
  
  // Getter methods that work like the original but accept isDarkMode parameter
  static Color getPrimary(bool isDarkMode) => getPrimaryColor(isDarkMode);
  static Color getPrimaryVariant(bool isDarkMode) => isDarkMode ? darkPrimaryVariant : primaryVariant;
  static Color getPrimaryLight(bool isDarkMode) => isDarkMode ? darkPrimaryLight : primaryLight;
  static Color getPrimaryDark(bool isDarkMode) => isDarkMode ? darkPrimaryDark : primaryDark;
  
  static Color getSecondary(bool isDarkMode) => getSecondaryColor(isDarkMode);
  static Color getSecondaryVariant(bool isDarkMode) => isDarkMode ? darkSecondaryVariant : secondaryVariant;
  static Color getSecondaryLight(bool isDarkMode) => isDarkMode ? darkSecondaryLight : secondaryLight;
  static Color getSecondaryDark(bool isDarkMode) => isDarkMode ? darkSecondaryDark : secondaryDark;
  
  static Color getBackground(bool isDarkMode) => getBackgroundColor(isDarkMode);
  static Color getSurface(bool isDarkMode) => getSurfaceColor(isDarkMode);
  static Color getCardBackground(bool isDarkMode) => getCardBackgroundColor(isDarkMode);
  static Color getScaffoldBackground(bool isDarkMode) => isDarkMode ? darkScaffoldBackground : scaffoldBackground;
  
  static Color getTextPrimary(bool isDarkMode) => getTextPrimaryColor(isDarkMode);
  static Color getTextSecondary(bool isDarkMode) => getTextSecondaryColor(isDarkMode);
  static Color getTextHint(bool isDarkMode) => isDarkMode ? darkTextHint : textHint;
  static Color getTextDisabled(bool isDarkMode) => isDarkMode ? darkTextDisabled : textDisabled;
  
  static Color getIconPrimary(bool isDarkMode) => isDarkMode ? darkIconPrimary : iconPrimary;
  static Color getIconSecondary(bool isDarkMode) => isDarkMode ? darkIconSecondary : iconSecondary;
  static Color getIconDisabled(bool isDarkMode) => isDarkMode ? darkIconDisabled : iconDisabled;
  
  static Color getBorder(bool isDarkMode) => getBorderColor(isDarkMode);
  static Color getBorderLight(bool isDarkMode) => isDarkMode ? darkBorderLight : borderLight;
  static Color getDivider(bool isDarkMode) => isDarkMode ? darkDivider : divider;
  
  // Status colors remain the same for both themes
  static Color getSuccess(bool isDarkMode) => success;
  static Color getWarning(bool isDarkMode) => warning;
  static Color getError(bool isDarkMode) => error;
  static Color getInfo(bool isDarkMode) => info;
  
  // Additional colors for widgets
  static Color getShadow(bool isDarkMode) => isDarkMode ? Colors.black26 : Colors.black12;
  static Color getButtonPrimary(bool isDarkMode) => getPrimaryColor(isDarkMode);
  static Color getButtonDisabled(bool isDarkMode) => isDarkMode ? darkTextDisabled : textDisabled;
  static Color getInputBackground(bool isDarkMode) => isDarkMode ? darkSurface : surface;
  static Color getInputBorder(bool isDarkMode) => getBorderColor(isDarkMode);
  static Color getInputFocusedBorder(bool isDarkMode) => getPrimaryColor(isDarkMode);
  
  // Additional static colors for backward compatibility
  static Color get shadow => Colors.black12;
  static Color get buttonPrimary => primary;
  static Color get buttonDisabled => textDisabled;
  static Color get inputBackground => surface;
  static Color get inputBorder => border;
  static Color get inputFocusedBorder => primary;
} 