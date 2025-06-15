import 'dart:ui';

import 'package:flutter/material.dart';

class SimpleBlurWidget extends StatelessWidget {
  final Widget child;
  final double sigmaX;
  final double sigmaY;
  final bool isBlurEnabled;

  const SimpleBlurWidget({
    super.key,
    required this.child,
    this.sigmaX = 4.0,
    this.sigmaY = 4.0,
    this.isBlurEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return isBlurEnabled
        ? ImageFiltered(
            imageFilter: ImageFilter.blur(
              sigmaX: sigmaX,
              sigmaY: sigmaY,
            ),
            child: child,
          )
        : child;
  }
}
