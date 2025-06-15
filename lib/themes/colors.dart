import 'package:flutter/material.dart';

class AppColors extends ColorScheme {
  // Light Theme Colors
  static const primaryColor = Color(0xFF2790C3);
  static const onPrimaryColor = Color(0xFFF8FAFC);
  static const secondaryColor = Color(0xFFE9F4F9);
  static const onSecondaryColor = Color(0xFFF8FAFC);
  static const onInverseSurfaceColor = Color(0xFFD9F4FF);
  static const primaryTextColor = Color(0xFF575757);
  static const secondaryTextColor = Color(0xFF2A2A2A);
  static const onPrimaryTextColor = Color(0xFFFFFFFF);
  static const backgroundColor = Color(0xFFFFFFFF);
  static const onBackgroundColor = Color(0xFF2790C3);
  static const successColor = Color(0xFF00B489);
  static const warningColor = Color(0xFFF7AAB0);
  static const errorColor = Color(0xFFDC2626);
  static const processingDividerColor = Color(0xFF2790C3);
  static const processingColor = Color(0xFF2790C3);
  static const offSetBackGround = Color(0xFF2790C3);
  static const verifyColor = Color(0xFFF79E1B);
  static const buttonColor = Color(0xFF2790C3);
  static const buttonBorderColor = Color(0xFF2790C3);
  static const disableButtonColor = Color(0xFFD9D9D9);
  static const secondaryButtonColor = Color(0xFFE2E8F0);
  static const textFieldBorderColor = Color(0xFF2790C3);
  static const navBarActiveIconColor = Color(0xFFFFFFFF);
  static const navBarInActiveIconColor = Color(0xFF2790C3);
  static const divideColor = Color(0xFFD9D9D9);
  static const userChatColor = Color(0xFFE9F4F9);
  static const otherChatColor = Color(0xFFFDFDFE);
  static const notificationColor = Color(0xFFE9F4F9);
  static const readNotificationColor = Color(0xFFD9D9D9);

  // Dark Theme Colors
  static const darkPrimaryColor = Color(0xFF1A6B8F);
  static const darkOnPrimaryColor = Color(0xFFE2E8F0);
  static const darkSecondaryColor = Color(0xFF1E293B);
  static const darkOnSecondaryColor = Color(0xFFE2E8F0);
  static const darkBackgroundColor = Color(0xFF0F172A);
  static const darkOnBackgroundColor = Color(0xFFE2E8F0);
  static const darkSurfaceColor = Color(0xFF1E293B);
  static const darkOnSurfaceColor = Color(0xFFE2E8F0);
  static const darkErrorColor = Color(0xFFEF4444);
  static const darkSuccessColor = Color(0xFF10B981);
  static const darkWarningColor = Color(0xFFF59E0B);

  const AppColors({
    super.brightness = Brightness.light,
    super.primary = primaryColor,
    super.onPrimary = onPrimaryColor,
    super.secondary = secondaryColor,
    super.onSecondary = onSecondaryColor,
    super.onSecondaryContainer = backgroundColor,
    super.error = errorColor,
    super.onError = onBackgroundColor,
    super.surface = backgroundColor,
    super.onSurface = primaryTextColor,
    super.errorContainer = errorColor,
    super.onInverseSurface = onInverseSurfaceColor,
    super.background = backgroundColor,
    super.onBackground = onBackgroundColor,
    super.surfaceVariant = processingColor,
    super.onSurfaceVariant = onPrimaryTextColor,
  });

  static ColorScheme get lightTheme => const AppColors();

  static ColorScheme get darkTheme => const AppColors(
        brightness: Brightness.dark,
        primary: darkPrimaryColor,
        onPrimary: darkOnPrimaryColor,
        secondary: darkSecondaryColor,
        onSecondary: darkOnSecondaryColor,
        background: darkBackgroundColor,
        onBackground: darkOnBackgroundColor,
        surface: darkSurfaceColor,
        onSurface: darkOnSurfaceColor,
        error: darkErrorColor,
        onError: darkOnBackgroundColor,
      );
}
