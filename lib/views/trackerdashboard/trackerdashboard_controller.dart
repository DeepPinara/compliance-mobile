import 'package:compliancenavigator/utils/images.dart';
import 'package:compliancenavigator/views/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TrackerdashboardController extends GetxController
    with GetSingleTickerProviderStateMixin {
  static const String trackerdashboardScreenId = 'Trackerdashboard_screen';
  late TabController tabController;

  final HomeController homeController;

  TrackerdashboardController({
    required this.homeController,
  });

  int selectedIndex = 0;
  int unreadCount = 0;

  final List<String> labels = ['Home', 'Menu', 'Team', 'Profile'];
  final List<String> images = [
    dSvgsHomeMenu,
    dSvgsMenu,
    dSvgsTeamManagement,
    dSvgsUserMenu
  ];

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(vsync: this, length: 4);
  }

  //on tab bar tap
  void onTabTap(int index) {
    selectedIndex = index;
    tabController.animateTo(index);
    _handleTabIndex();
    update([TrackerdashboardController.trackerdashboardScreenId]);
  }

  void _handleTabIndex() {
    if (selectedIndex == 0) {}
  }
}
