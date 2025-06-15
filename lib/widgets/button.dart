import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum AppButtonType { primary, secondary, signInWith }

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final AppButtonType buttonType;
  final Widget? icon;
  final double? width;
  final double? height;

  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.buttonType = AppButtonType.primary,
    this.icon,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    // Create the button content with loading indicator or text + icon
    final Widget buttonContent = isLoading
        ? SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(
              color: AppButtonType.signInWith == buttonType
                  ? Get.theme.colorScheme.primary
                  : Colors.white,
              strokeWidth: 2,
            ),
          )
        :
        //  Text(
        //     label,
        //     style: TextStyle(
        //       color: DLButtonType.signInWith == buttonType
        //           ? Get.theme.colorScheme.primary
        //           : Colors.white,
        //     ),
        //   );
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            // spacing: 8,
            children: [
              if (icon != null) icon!,
              Text(label),
            ],
          );

    // Size the button according to provided dimensions
    final Widget sizedButton = SizedBox(
      width: width,
      height: height,
      child: _buildButton(buttonContent),
    );

    return sizedButton;
  }

  Widget _buildButton(Widget childContent) {
    // Use the appropriate button type based on the buttonType property
    switch (buttonType) {
      case AppButtonType.primary:
        return ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          child: childContent,
        );
      case AppButtonType.secondary:
        return OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          child: childContent,
        );
      case AppButtonType.signInWith:
        return OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          // Use Above style for SignInWith Button
          style: ButtonStyle(
            side: WidgetStateProperty.all(
              const BorderSide(
                color: Colors.grey,
                width: 1,
              ),
            ),
          ),
          child: childContent,
        );
    }
  }
}
