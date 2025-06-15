import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DLAppBarTheme extends AppBarTheme {
  const DLAppBarTheme();

  @override
  Color? get backgroundColor => Get.theme.colorScheme.primary; // Updated to match design

  @override
  double? get elevation => 0;

  @override
  TextStyle? get titleTextStyle => Get.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w700,
        fontSize: 20,
        color: Colors.white, // Ensuring text is visible on blue background
      );

  @override
  IconThemeData get iconTheme => const IconThemeData(
        color: Colors.white, // Ensuring icons are visible on blue
      );

  @override
  bool? get centerTitle => true;
}
