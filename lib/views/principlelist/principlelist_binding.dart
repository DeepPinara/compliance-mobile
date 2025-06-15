import 'package:get/get.dart';
import 'principlelist_controller.dart';
import 'package:compliancenavigator/modules/principle/principle_repository.dart';
import 'package:compliancenavigator/data/services/navigation_service/navigation_import.dart';

class PrinciplelistBinding extends Bindings {
  @override
  void dependencies() {
    final PrincipleRepository principleRepository =
        Get.find<PrincipleRepository>();
    final NavigationService navigationService = Get.find<NavigationService>();
    Get.lazyPut<PrinciplelistController>(
      () => PrinciplelistController(
        principleRepository: principleRepository,
        navigationService: navigationService,
      ),
    );
  }
}
