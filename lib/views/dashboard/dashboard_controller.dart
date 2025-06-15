import 'package:compliancenavigator/utils/images.dart';
import 'package:compliancenavigator/views/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController
    with GetSingleTickerProviderStateMixin {
  static const String kDashboardNavId = 'dashboardNav';
  late TabController tabController;

  final HomeController homeController;

  DashboardController({
    required this.homeController,
  });

  int selectedIndex = 0;
  int unreadCount = 0;

  final List<String> labels = ['Home', 'Menu', 'Team', 'Profile'];
  final List<String> images = [
    dSvgsHomeMenu,
    dSvgsSearch,
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
    update([kDashboardNavId]);
  }

  void _handleTabIndex() {
    if (selectedIndex == 0) {
    }
    
  }
}
