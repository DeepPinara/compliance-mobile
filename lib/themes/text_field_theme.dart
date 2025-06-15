import 'package:compliancenavigator/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class DLInputDecorationTheme extends InputDecorationTheme {
  const DLInputDecorationTheme();

  // Define static constants for reusable values
  static final BorderRadius _borderRadius = BorderRadius.circular(8);
  static const Color _fillColor = AppColors.backgroundColor;
  static const Color _borderColor = AppColors.textFieldBorderColor;
  static const Color _hintColor = AppColors.primaryTextColor;
  static const Color _errorColor = AppColors.errorColor;
  static const double defaultHeight = 76;

  // Border styles
  static InputBorder _defaultBorder({Color? color, double width = 1.0}) {
    return OutlineInputBorder(
      borderRadius: _borderRadius,
      borderSide: BorderSide(
        color: color ?? _borderColor,
        width: width,
      ),
    );
  }

  // Default values
  static const EdgeInsetsGeometry _contentPadding =
      EdgeInsets.symmetric(vertical: 12, horizontal: 12);

  static final TextStyle _labelStyle = Get.textTheme.bodyMedium?.copyWith(
        color: AppColors.primaryTextColor,
        fontWeight: FontWeight.w500,
      ) ??
      const TextStyle();

  static final TextStyle _hintStyle = Get.textTheme.bodyMedium?.copyWith(
        fontSize: 13,
        // ignore: deprecated_member_use
        color: _hintColor.withOpacity(0.5),
      ) ??
      const TextStyle();

  // Theme override properties
  @override
  bool get filled => true;

  @override
  Color? get fillColor => _fillColor;

  @override
  InputBorder? get border => _defaultBorder();

  @override
  InputBorder? get enabledBorder => _defaultBorder();

  @override
  InputBorder? get focusedBorder => _defaultBorder(width: 2.0);

  @override
  InputBorder? get errorBorder => _defaultBorder(color: _errorColor);

  @override
  InputBorder? get focusedErrorBorder =>
      _defaultBorder(color: _errorColor, width: 2.0);

  @override
  EdgeInsetsGeometry? get contentPadding => _contentPadding;

  @override
  TextStyle? get hintStyle => _hintStyle;

  @override
  TextStyle? get labelStyle => _labelStyle;

  @override
  bool get isDense => true;

  String? get counterText => '';

  @override
  FloatingLabelBehavior get floatingLabelBehavior =>
      FloatingLabelBehavior.never;

  @override
  BoxConstraints? get constraints => const BoxConstraints(
        minHeight: defaultHeight,
        maxHeight: defaultHeight,
      );

  // Method to get decoration with custom properties
  static InputDecoration getDecoration({
    String? hint,
    Widget? prefixIcon,
    Widget? suffixIcon,
    TextStyle? hintStyle,
    Color? fillColor,
    BorderRadius? borderRadius,
    EdgeInsetsGeometry? contentPadding,
    String? errorText,
    TextStyle? errorStyle,
  }) {
    return InputDecoration(
      fillColor: fillColor ?? _fillColor,
      filled: true,
      border: _defaultBorder(),
      enabledBorder: _defaultBorder(),
      focusedBorder: _defaultBorder(width: 2.0),
      errorBorder: _defaultBorder(color: _errorColor),
      focusedErrorBorder: _defaultBorder(color: _errorColor, width: 2.0),
      hintText: hint,
      hintStyle: hintStyle ?? _hintStyle,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      contentPadding: contentPadding ?? _contentPadding,
      counterText: '',
      isDense: true,
      errorText: errorText,
      // errorStyle: errorStyle ?? _errorStyle,
      constraints: const BoxConstraints(
        maxHeight: defaultHeight,
      ),
    );
  }

  // Factory method for phone number field decoration
  static InputDecoration phoneNumberDecoration({
    required String hint,
  }) {
    return getDecoration(
      hint: hint,
    );
  }
}
