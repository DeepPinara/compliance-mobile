import 'package:get/get.dart';
import 'principledetail_controller.dart';
import 'package:compliancenavigator/modules/principle/principle_repository.dart';
import 'package:compliancenavigator/data/services/navigation_service/navigation_import.dart';

class PrincipledetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PrincipledetailController>(
      () => PrincipledetailController(
        navigationService: Get.find<NavigationService>(),
        principleRepository: Get.find<PrincipleRepository>(),
      ),
    );
  }
}
