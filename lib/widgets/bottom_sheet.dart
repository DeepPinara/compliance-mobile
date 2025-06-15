import 'package:compliancenavigator/themes/colors.dart';
import 'package:compliancenavigator/utils/constants.dart';
import 'package:compliancenavigator/widgets/image_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DLBaseBottomSheet extends StatelessWidget {
  final String title;
  final Widget child;
  final bool isTitleCenter;
  final bool showCloseButton;
  final bool isDismissible;
  final String? prefixSVGIcon;
  // final EdgeInsets padding;

  const DLBaseBottomSheet({
    super.key,
    required this.title,
    required this.child,
    this.isTitleCenter = false,
    this.showCloseButton = true,
    this.isDismissible = true,
    this.prefixSVGIcon,
    // this.padding = const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
  });

  static Future<T?> show<T>(
      {required String title,
      required Widget child,
      bool isTitleCenter = false,
      bool showCloseButton = true,
      bool isDismissible = true,
      String? prefixSVGIcon
      // EdgeInsets? padding,
      }) {
    return showModalBottomSheet<T>(
      context: Get.overlayContext!,
      isScrollControlled: true,
      isDismissible: isDismissible,
      backgroundColor: Colors.transparent,
      builder: (context) => DLBaseBottomSheet(
        title: title,
        isTitleCenter: isTitleCenter,
        showCloseButton: showCloseButton,
        prefixSVGIcon: prefixSVGIcon,
        // padding: padding ??
        //     const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: isTitleCenter
              ? CrossAxisAlignment.center
              : CrossAxisAlignment.start,
          children: [
            // Handle at top
            Padding(
              padding: const EdgeInsets.only(
                top: 8,
              ),
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: 80,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.divideColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),
            // Title and close button
            Padding(
              padding: const EdgeInsets.only(
                left: AppConstants.kAppScreenSpacing,
                right: AppConstants.kAppScreenSpacing,
                top: 8,
              ),
              child: Row(
                mainAxisAlignment: isTitleCenter
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.spaceBetween,
                children: [
                  if (prefixSVGIcon != null) ...[
                    ImageViewer(
                      imageUrl:
                          prefixSVGIcon!, // Replace with your warning icon
                      width: 20,
                      height: 20,
                      color: Colors.amber,
                    ).build(),
                    const SizedBox(
                      width: 8,
                    )
                  ],
                  if (!isTitleCenter || !showCloseButton)
                    Expanded(
                      child: Text(
                        title,
                        style: Get.textTheme.titleMedium?.copyWith(
                          fontSize: 22,
                          fontWeight: FontWeight.w400,
                          color: AppColors.secondaryTextColor,
                        ),
                        textAlign:
                            isTitleCenter ? TextAlign.center : TextAlign.start,
                      ),
                    ),
                  if (isTitleCenter && showCloseButton)
                    Expanded(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Text(
                            title,
                            style: Get.textTheme.titleMedium?.copyWith(
                              fontSize: 22,
                              fontWeight: FontWeight.w400,
                              color: AppColors.secondaryTextColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Positioned(
                            right: 0,
                            child: _buildCloseButton(),
                          ),
                        ],
                      ),
                    ),
                  if (!isTitleCenter && showCloseButton) _buildCloseButton(),
                ],
              ),
            ),

            // Content
            const SizedBox(height: 10),
            const Divider(
              color: AppColors.divideColor,
              height: 2,
            ),
            const SizedBox(height: 10),

            child,
          ],
        ),
      ),
    );
  }

  Widget _buildCloseButton() {
    return InkWell(
      onTap: () => Get.back(),
      child: Container(
        // width: 28,
        // height: 28,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: Colors.grey[300]!,
            width: 1,
          ),
        ),
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: Icon(
              Icons.close,
              size: 18,
              color: AppColors.primaryTextColor,
            ),
          ),
        ),
      ),
    );
  }
}
