import 'package:compliancenavigator/data/services/navigation_service/navigation_import.dart';
import 'package:compliancenavigator/modules/tracker/tracker_repository.dart';
import 'package:get/get.dart';
import 'trackerdocforvalidation_controller.dart';

class TrackerdocforvalidationBinding extends Bindings {
  @override
  void dependencies() {
    final TrackerRepository trackerRepository = Get.find<TrackerRepository>();
    final NavigationService navigationService = Get.find<NavigationService>();
    Get.lazyPut<TrackerdocforvalidationController>(
      () => TrackerdocforvalidationController(
        trackerRepository: trackerRepository,
        navigationService: navigationService,
      ),
    );
  }
}
