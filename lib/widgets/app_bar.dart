import 'package:compliancenavigator/themes/colors.dart';
import 'package:compliancenavigator/widgets/image_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DLAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? subtitle;
  final bool showBackButton;
  final String? profileImageUrl;
  final VoidCallback? onBackPressed;
  final VoidCallback? onProfileTap;
  final Widget? suffixWidget;

  const DLAppBar({
    super.key,
    required this.title,
    this.subtitle,
    this.showBackButton = false,
    this.profileImageUrl,
    this.onBackPressed,
    this.onProfileTap,
    this.suffixWidget,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: height,
      automaticallyImplyLeading: false,
      // leading: showBackButton
      //     ? GestureDetector(
      //         onTap: onBackPressed ?? () => Navigator.pop(context),
      //         child: Container(
      //           margin: const EdgeInsets.only(left: 8.0),
      //           child: const Icon(Icons.arrow_back),
      //         ),
      //       )
      // : null,
      title: SizedBox(
        // color: Colors.amber,
        width: Get.width,
        child: Padding(
          padding: EdgeInsets.only(top: Get.height * 0.00),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  if (showBackButton)
                    GestureDetector(
                      onTap: onBackPressed ?? () => Get.back(),
                      child: const Padding(
                        padding: EdgeInsets.only(right: 8.0, bottom: 4),
                        child: Icon(Icons.arrow_back),
                      ),
                    ),
                  if (profileImageUrl != null)
                    InkWell(
                      onTap: onProfileTap,
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(3)),
                        ),
                        child: ImageViewer(
                          imageUrl: profileImageUrl!,
                          width: 32,
                          height: 32,
                          fit: BoxFit.cover,
                        ).build(),
                      ),
                    ),
                ],
              ),
              if (profileImageUrl != null) const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Get.textTheme.titleLarge!.copyWith(
                        color: AppColors.onPrimaryTextColor,
                        letterSpacing: 0.1,
                        fontSize: 24,
                      ),
                      // textAlign: TextAlign.start,
                    ),
                    if (subtitle != null)
                      SizedBox(
                        width: double
                            .infinity, // Ensures the text can use full width
                        child: Text(
                          subtitle!,
                          style: Get.textTheme.titleMedium!.copyWith(
                            color: AppColors.onPrimaryTextColor,
                            fontSize: 18,
                          ),
                          softWrap: true, // Enables text wrapping
                          maxLines: 2, // Allows unlimited lines
                        ),
                      ),
                  ],
                ),
              ),
              if (suffixWidget != null) suffixWidget!
            ],
          ),
        ),
      ),
      // actions: suffixWidget != null
      //     ? [
      //         Padding(
      //           padding:
      //               const EdgeInsets.only(right: constants.kAppScreenSpacing),
      //           child: suffixWidget,
      //         ),
      //       ]
      //     : null,
      backgroundColor: Get.theme.colorScheme.primary,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);

  double get height => Get.height * 0.06;
}
