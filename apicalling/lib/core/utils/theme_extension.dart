import 'package:flutter/material.dart';

extension ThemeExtension on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;

  // Access color scheme quickly
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
}
