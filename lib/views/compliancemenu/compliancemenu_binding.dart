import 'package:get/get.dart';
import 'compliancemenu_controller.dart';

class CompliancemenuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CompliancemenuController>(
      () => CompliancemenuController(),
    );
  }
}
