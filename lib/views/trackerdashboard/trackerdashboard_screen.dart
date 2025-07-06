import 'package:compliancenavigator/themes/colors.dart';
import 'package:compliancenavigator/views/home/home_screen.dart';
import 'package:compliancenavigator/views/profile/profile_screen.dart';
import 'package:compliancenavigator/views/trackerhome/trackerhome_screen.dart';
import 'package:compliancenavigator/views/trackermenu/trackermenu_screen.dart';
import 'package:compliancenavigator/widgets/image_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'trackerdashboard_controller.dart';

const String kTrackerdashboardRoute = '/trackerdashboard';

class TrackerdashboardScreen extends GetWidget<TrackerdashboardController> {
  const TrackerdashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<TrackerdashboardController>(
          id: TrackerdashboardController.trackerdashboardScreenId,
          builder: (_) {
            return IndexedStack(
              index: controller.selectedIndex,
              children: [
                const TrackerhomeScreen(),
                const TrackermenuScreen(),
                Container(),
                const ProfileScreen(),
              ],
            );
          }),
      bottomNavigationBar: const DLBottomNavigationBar(),
    );
  }
}

class DLBottomNavigationBar extends GetWidget<TrackerdashboardController> {
  const DLBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TrackerdashboardController>(
      id: TrackerdashboardController.trackerdashboardScreenId,
      builder: (context) {
        return SafeArea(
          bottom: true,
          top: false,
          child: SizedBox(
            // height: 83,
            child: Container(
              decoration: BoxDecoration(
                color: Get.theme.colorScheme.surface,
                border: const Border(
                  top: BorderSide(
                    color: AppColors.divideColor,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 8.0,
                ),
                child: TabBar(
                  indicatorColor: Colors.transparent,
                  dividerColor: Colors.transparent,
                  splashFactory: NoSplash.splashFactory,
                  onTap: controller.onTabTap,
                  tabs: [
                    for (int i = 0; i < controller.labels.length; i++)
                      _buildBottomNavBarItem(
                        _buildImage(controller.images[i],
                            i == controller.selectedIndex),
                        controller.labels[i],
                        isSelected: i == controller.selectedIndex,
                        unreadCount: i == 1 ? controller.unreadCount : 0,
                      ),
                  ],
                  controller: controller.tabController,
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  labelPadding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildImage(String path, isSelected) {
    return ImageViewer(
      imageUrl: path,
      color: isSelected
          ? AppColors.navBarActiveIconColor
          : Get.theme.colorScheme.primary,
      height: 27,
      width: 27,
    ).build();
  }

  Container _buildBottomNavBarItem(
    Widget icon,
    String label, {
    bool isSelected = false,
    int unreadCount = 0,
  }) {
    return Container(
      // width: isSelected ? 104 : 64,
      decoration: BoxDecoration(
        color: isSelected ? Get.theme.colorScheme.primary : null,
        borderRadius: BorderRadius.circular(12),
        border: isSelected
            ? Border.all(color: AppColors.navBarInActiveIconColor)
            : const Border(),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon,
            // Text(
            //   label,
            //   style: TextStyle(
            //     fontWeight: FontWeight.w500,
            //     fontSize: 12,
            //     color: isSelected
            //         ? Get.theme.colorScheme.primary
            //         : AppColors.navBarActiveIconColor,
            //   ),
            //   maxLines: 1,
            // ),
          ],
        ),
      ),
    );
  }
}
