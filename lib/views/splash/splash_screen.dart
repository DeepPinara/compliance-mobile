import 'package:compliancenavigator/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'splash_controller.dart';



const String kSplashRoute = '/splash';
class SplashScreen extends GetWidget<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: DLAppBar(
        title: 'Splash title',
      ),
      body: Center(
        child: Text('Welcome to Splash Screen!'),
      ),
    );
  }
}
