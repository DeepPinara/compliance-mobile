import 'package:compliancenavigator/data/services/navigation_service/navigation_import.dart';
import 'package:compliancenavigator/data/services/storage_service.dart';
import 'package:compliancenavigator/utils/enums.dart';
import 'package:get/get.dart';

class SelectmoduleController extends GetxController {
  final StorageService storageService;
  final NavigationService navigationService;

  SelectmoduleController(
      {required this.storageService, required this.navigationService});

  static const String selectmoduleScreenId = 'Selectmodule_screen';

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void onSelectmodule(Selectmodule selectmodule) {
    storageService.saveSelectmodule(selectmodule);
    switch (selectmodule) {
      case Selectmodule.compliance:
        navigationService.navigateToDashboard();
        break;
      case Selectmodule.tracker:
        navigationService.navigateToTrackerdashboard();
        break;
    }
  }
}
