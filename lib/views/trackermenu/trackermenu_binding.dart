import 'package:compliancenavigator/data/services/navigation_service/navigation_import.dart';
import 'package:get/get.dart';
import 'trackermenu_controller.dart';

class TrackermenuBinding extends Bindings {
  @override
  void dependencies() {
    final NavigationService navigationService = Get.find<NavigationService>();
    Get.lazyPut<TrackermenuController>(
      () => TrackermenuController(
        navigationService: navigationService,
      ),
    );
  }
}
