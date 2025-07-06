import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final double borderRadius;
  final VoidCallback? onTap;
  final bool showBorder;
  final Color? borderColor;
  final double? width;
  final double? height;
  final List<BoxShadow>? boxShadow;
  final bool isElivated;

  const CustomCard({
    Key? key,
    required this.child,
    this.padding,
    this.backgroundColor,
    this.borderRadius = 12.0,
    this.onTap,
    this.showBorder = false,
    this.borderColor,
    this.width,
    this.height,
    this.boxShadow,
    this.isElivated = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius),
        border: showBorder
            ? Border.all(
                color: borderColor ?? theme.dividerColor.withOpacity(0.5),
                width: 1,
              )
            : null,
        boxShadow: boxShadow ??
            [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 10,
                offset: const Offset(0, 8),
              ),
            ],
      ),
      child: Material(
        type: MaterialType.transparency,
        borderRadius: BorderRadius.circular(borderRadius),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Padding(
            padding: padding ?? const EdgeInsets.all(16.0),
            child: child,
          ),
        ),
      ),
    );
  }
}
