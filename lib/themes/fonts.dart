import 'package:flutter/material.dart';

class DLTextTheme extends TextTheme {
  const DLTextTheme();

  @override
  TextStyle? get displayLarge => const TextStyle(
        fontFamily: 'Poppins',
        fontSize: 57,
        fontWeight: FontWeight.bold,
        letterSpacing: -0.25,
      );

  @override
  TextStyle? get displayMedium => const TextStyle(
        fontFamily: 'Poppins',
        fontSize: 20,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.0,
      );

  @override
  TextStyle? get displaySmall => const TextStyle(
        fontFamily: 'Poppins',
        fontSize: 18,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.0,
      );

  @override
  TextStyle? get headlineLarge => const TextStyle(
        fontFamily: 'Poppins',
        fontSize: 32,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.15,
      );

  @override
  TextStyle? get headlineMedium => const TextStyle(
        fontFamily: 'Poppins',
        fontSize: 26,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.0,
      );

  @override
  TextStyle? get headlineSmall => const TextStyle(
        fontFamily: 'Poppins',
        fontSize: 24,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.0,
      );

  @override
  TextStyle? get titleLarge => const TextStyle(
        fontFamily: 'Poppins',
        fontSize: 24,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.0,
      );

  @override
  TextStyle? get titleMedium => const TextStyle(
        fontFamily: 'Poppins',
        fontSize: 16,
        fontWeight: FontWeight.w400,
      );

  @override
  TextStyle? get titleSmall => const TextStyle(
        fontFamily: 'Poppins',
        fontSize: 13,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.0,
      );

  @override
  TextStyle? get bodyLarge => const TextStyle(
        fontFamily: 'Poppins',
        fontSize: 16,
        fontWeight: FontWeight.normal,
        letterSpacing: -0.5,
      );

  @override
  TextStyle? get bodyMedium => const TextStyle(
        fontFamily: 'Poppins',
        fontSize: 14,
        fontWeight: FontWeight.normal,
        letterSpacing: 0.25,
      );

  @override
  TextStyle? get bodySmall => const TextStyle(
        fontFamily: 'Poppins',
        fontSize: 12,
        fontWeight: FontWeight.normal,
        letterSpacing: 0.4,
      );

  @override
  TextStyle? get labelLarge => const TextStyle(
        fontFamily: 'Poppins',
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0,
      );

  @override
  TextStyle? get labelMedium => const TextStyle(
        fontFamily: 'Poppins',
        fontSize: 12,
        fontWeight: FontWeight.w300,
        letterSpacing: 0,
      );

  @override
  TextStyle? get labelSmall => const TextStyle(
        fontFamily: 'Poppins',
        fontSize: 10,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
      );
}