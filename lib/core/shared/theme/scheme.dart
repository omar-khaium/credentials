import 'package:credentials/core/shared/shared.dart';
import 'package:flutter/material.dart';

class ThemeScheme {
  final Color background;
  final Color text;
  final Color primary;
  final Color secondary;
  final Color tertiary;

  ThemeScheme({
    required this.background,
    required this.text,
    required this.primary,
    required this.secondary,
    required this.tertiary,
  });

  factory ThemeScheme.find({
    required ThemeType type,
  }) {
    final theme = ThemeScheme(
      background: Color(0xff303a52),
      text: Color(0xfffdfdfd),
      primary: Color(0xff43dde6),
      secondary: Color(0xfff7f7f8),
      tertiary: Color(0xff364f6b),
    );

    return theme;
  }
}
