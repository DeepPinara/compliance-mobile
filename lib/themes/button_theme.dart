import 'package:compliancenavigator/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Theme for ElevatedButtons (Primary Buttons)
class DLElevatedButtonTheme extends ElevatedButtonThemeData {
  const DLElevatedButtonTheme();

  static const double _defaultHeight = 46;
  static const double _borderRadius = 8.0;
  static const double _elevation = 2.0;
  static const EdgeInsets _padding = EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0);

  @override
  ButtonStyle? get style => ButtonStyle(
    backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
      if (states.contains(WidgetState.disabled)) {
        return AppColors.disableButtonColor;
      }
      return AppColors.buttonColor;
    }),
    foregroundColor: WidgetStateProperty.resolveWith<Color>((states) {
      if (states.contains(WidgetState.disabled)) {
        return Colors.grey.shade700;
      }
      return Colors.white;
    }),
    overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
      if (states.contains(WidgetState.pressed)) {
        // ignore: deprecated_member_use
        return Colors.white.withOpacity(0.1);
      }
      return null;
    }),
    minimumSize: const WidgetStatePropertyAll(Size(double.infinity, _defaultHeight)),
    maximumSize: const WidgetStatePropertyAll(Size(double.infinity, _defaultHeight * 2)),
    padding: const WidgetStatePropertyAll(_padding),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(_borderRadius)),
    ),
    elevation: const WidgetStatePropertyAll(_elevation),
    textStyle: WidgetStatePropertyAll(
      Get.textTheme.bodyLarge?.copyWith(
        fontWeight: FontWeight.w500,
      ),
    ),
  );

  // Factory method to create custom button style
  static ButtonStyle getCustomStyle({
    Color? backgroundColor,
    Color? textColor,
    double? borderRadius,
    double? elevation,
    EdgeInsetsGeometry? padding,
  }) {
    return ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.disabled)) {
          return AppColors.disableButtonColor;
        }
        return backgroundColor ?? AppColors.buttonColor;
      }),
      foregroundColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.disabled)) {
          return Colors.grey.shade700;
        }
        return textColor ?? Colors.white;
      }),
      minimumSize: const WidgetStatePropertyAll(Size(double.infinity, _defaultHeight)),
      padding: WidgetStatePropertyAll(padding ?? _padding),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? _borderRadius),
        ),
      ),
      elevation: WidgetStatePropertyAll(elevation ?? _elevation),
      textStyle: WidgetStatePropertyAll(
        Get.textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

// Theme for OutlinedButtons (Secondary Buttons)
class DLOutlinedButtonTheme extends OutlinedButtonThemeData {
  const DLOutlinedButtonTheme();

  static const double _defaultHeight = 46;
  static const double _borderRadius = 8.0;
  static const EdgeInsets _padding = EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0);

  @override
  ButtonStyle? get style => ButtonStyle(
    backgroundColor: const WidgetStatePropertyAll(Colors.transparent),
    foregroundColor: WidgetStateProperty.resolveWith<Color>((states) {
      if (states.contains(WidgetState.disabled)) {
        return Colors.grey.shade700;
      }
      return Colors.black;
    }),
    overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
      if (states.contains(WidgetState.pressed)) {
        // ignore: deprecated_member_use
        return Colors.black.withOpacity(0.05);
      }
      return null;
    }),
    minimumSize: const WidgetStatePropertyAll(Size(double.infinity, _defaultHeight)),
    maximumSize: const WidgetStatePropertyAll(Size(double.infinity, _defaultHeight * 2)),
    padding: const WidgetStatePropertyAll(_padding),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(_borderRadius)),
    ),
    side: WidgetStateProperty.resolveWith<BorderSide>((states) {
      if (states.contains(WidgetState.disabled)) {
        return BorderSide(color: Colors.grey.shade400, width: 1.5);
      }
      return const BorderSide(color: AppColors.buttonBorderColor, width: 1.5);
    }),
    textStyle: WidgetStatePropertyAll(
      Get.textTheme.bodyLarge?.copyWith(
        fontWeight: FontWeight.w500,
      ),
    ),
  );

  // Factory method to create custom button style
  static ButtonStyle getCustomStyle({
    Color? borderColor,
    Color? textColor,
    double? borderRadius,
    EdgeInsetsGeometry? padding,
  }) {
    return ButtonStyle(
      backgroundColor: const WidgetStatePropertyAll(Colors.transparent),
      foregroundColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.disabled)) {
          return Colors.grey.shade700;
        }
        return textColor ?? Colors.black;
      }),
      minimumSize: const WidgetStatePropertyAll(Size(double.infinity, _defaultHeight)),
      padding: WidgetStatePropertyAll(padding ?? _padding),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? _borderRadius),
        ),
      ),
      side: WidgetStateProperty.resolveWith<BorderSide>((states) {
        if (states.contains(WidgetState.disabled)) {
          return BorderSide(color: Colors.grey.shade400, width: 1.5);
        }
        return BorderSide(color: borderColor ?? AppColors.buttonBorderColor, width: 1.5);
      }),
      textStyle: WidgetStatePropertyAll(
        Get.textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}