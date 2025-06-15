import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final bool isLoading;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final Color? textColor;
  final double? borderRadius;
  final double? fontSize;
  final FontWeight? fontWeight;
  final EdgeInsetsGeometry? padding;
  final Widget? icon;

  const PrimaryButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.isLoading = false,
    this.width,
    this.height = 48,
    this.backgroundColor,
    this.textColor,
    this.borderRadius = 8,
    this.fontSize,
    this.fontWeight,
    this.padding,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? theme.primaryColor,
          foregroundColor: textColor ?? Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius!),
          ),
          padding: padding,
          elevation: 0,
        ),
        child: isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    icon!,
                    const SizedBox(width: 8),
                  ],
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: fontSize ?? 16,
                      fontWeight: fontWeight ?? FontWeight.w600,
                      color: textColor ?? Colors.white,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
