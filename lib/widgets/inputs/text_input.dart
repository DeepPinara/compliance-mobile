import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? hintText;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool readOnly;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final int? maxLines;
  final int? maxLength;
  final bool enabled;
  final Function()? onTap;
  final Function(String)? onChanged;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final String? initialValue;
  final bool autofocus;
  final TextCapitalization textCapitalization;
  final EdgeInsetsGeometry? contentPadding;
  final String? errorText;

  const TextInput({
    Key? key,
    required this.controller,
    required this.label,
    this.hintText,
    this.validator,
    this.keyboardType,
    this.obscureText = false,
    this.readOnly = false,
    this.suffixIcon,
    this.prefixIcon,
    this.maxLines = 1,
    this.maxLength,
    this.enabled = true,
    this.onTap,
    this.onChanged,
    this.textInputAction,
    this.focusNode,
    this.initialValue,
    this.autofocus = false,
    this.textCapitalization = TextCapitalization.none,
    this.contentPadding,
    this.errorText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        color: theme.dividerColor,
        width: 1.0,
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
            color: theme.textTheme.bodyMedium?.color?.withOpacity(0.8),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          style: theme.textTheme.bodyMedium,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: theme.textTheme.bodyMedium?.copyWith(
              color: theme.hintColor.withOpacity(0.7),
            ),
            border: border,
            enabledBorder: border,
            focusedBorder: border.copyWith(
              borderSide: BorderSide(
                color: theme.primaryColor,
                width: 1.5,
              ),
            ),
            errorBorder: border.copyWith(
              borderSide: BorderSide(
                color: theme.colorScheme.error,
                width: 1.5,
              ),
            ),
            focusedErrorBorder: border.copyWith(
              borderSide: BorderSide(
                color: theme.colorScheme.error,
                width: 1.5,
              ),
            ),
            filled: true,
            fillColor: readOnly
                ? theme.colorScheme.surfaceVariant.withOpacity(0.5)
                : theme.colorScheme.surface,
            contentPadding: contentPadding ??
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            errorText: errorText,
            errorMaxLines: 2,
            errorStyle: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.error,
              height: 1.2,
            ),
          ),
          keyboardType: keyboardType,
          obscureText: obscureText,
          readOnly: readOnly,
          maxLines: maxLines,
          maxLength: maxLength,
          onTap: onTap,
          onChanged: onChanged,
          validator: validator,
          enabled: enabled,
          textInputAction: textInputAction,
          focusNode: focusNode,
          initialValue: initialValue,
          autofocus: autofocus,
          textCapitalization: textCapitalization,
        ),
      ],
    );
  }
}
