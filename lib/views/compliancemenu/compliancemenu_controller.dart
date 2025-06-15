// lib/views/compliancemenu/compliancemenu_controller.dart
import 'package:compliancenavigator/views/principlelist/principlelist_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompliancemenuController extends GetxController {
  static const String compliancemenuScreenId = 'Compliancemenu_screen';

  final menuItems = [
    const _MenuItem('Principle Entity', Icons.apartment, kPrinciplelistRoute),
    const _MenuItem('Contractor\'s', Icons.apartment, '/contractors'),
    const _MenuItem('Worker\'s', Icons.apartment, '/workers'),
    const _MenuItem('Wage Master', Icons.apartment, '/wage_master'),
    // _MenuItem('Compliances Create', Icons.apartment, '/compliances_create'),
    const _MenuItem('Minimum Wage Master', Icons.attach_money, '/minimum_wage_master'),
  ];
}

class _MenuItem {
  final String title;
  final IconData icon;
  final String route;
  const _MenuItem(this.title, this.icon, this.route);
}