import 'package:compliancenavigator/data/services/navigation_service/navigation_import.dart';
import 'package:compliancenavigator/data/services/network_service.dart';
import 'package:compliancenavigator/modules/tracker/tracker_repository.dart';
import 'package:get/get.dart';
import 'trackerlist_controller.dart';

class TrackerlistBinding extends Bindings {
  @override
  void dependencies() {
    final TrackerRepository trackerRepository = Get.find<TrackerRepository>();
    final NetworkService networkService = Get.find<NetworkService>();
    final NavigationService navigationService = Get.find<NavigationService>();

    Get.lazyPut<TrackerlistController>(
      () => TrackerlistController(
        trackerRepository: trackerRepository,
        networkService: networkService,
        navigationService: navigationService,
      ),
    );
  }
}
