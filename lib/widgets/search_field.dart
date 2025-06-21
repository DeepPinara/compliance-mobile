import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final String? hintText;
  final bool autofocus;
  final bool enabled;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final Color? fillColor;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? initialValue;
  final FocusNode? focusNode;

  const SearchField({
    Key? key,
    this.controller,
    this.onChanged,
    this.onTap,
    this.hintText = 'Search...',
    this.autofocus = false,
    this.enabled = true,
    this.padding,
    this.borderRadius = 8.0,
    this.fillColor,
    this.suffixIcon,
    this.prefixIcon,
    this.initialValue,
    this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return TextFormField(
      controller: controller,
      initialValue: initialValue,
      onChanged: onChanged,
      onTap: onTap,
      enabled: enabled,
      autofocus: autofocus,
      focusNode: focusNode,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon ?? const Icon(Icons.search),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: fillColor ?? theme.cardColor,
        contentPadding: padding ??
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: theme.primaryColor.withOpacity(0.5),
            width: 1.0,
          ),
        ),
        hintStyle: theme.textTheme.bodyMedium?.copyWith(
          color: theme.hintColor,
        ),
      ),
      style: theme.textTheme.bodyMedium,
    );
  }
}
