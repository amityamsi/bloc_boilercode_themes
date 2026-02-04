import 'package:flutter/material.dart';

extension ThemeX on BuildContext {
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
}
