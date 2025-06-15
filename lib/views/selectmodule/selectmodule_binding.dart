import 'package:get/get.dart';
import 'selectmodule_controller.dart';
import 'package:compliancenavigator/data/services/navigation_service/navigation_import.dart';
import 'package:compliancenavigator/data/services/storage_service.dart';

class SelectmoduleBinding extends Bindings {
  @override
  void dependencies() {
    final StorageService storageService = Get.find<StorageService>();
    final NavigationService navigationService = Get.find<NavigationService>();
    Get.lazyPut<SelectmoduleController>(
      () => SelectmoduleController(
        storageService: storageService,
        navigationService: navigationService,
      ),
    );
  }
}
