import 'package:compliancenavigator/data/services/navigation_service/navigation_import.dart';
import 'package:compliancenavigator/modules/tracker/tracker_repository.dart';
import 'package:get/get.dart';
import 'trackerapplicationdetail_controller.dart';

class TrackerapplicationdetailBinding extends Bindings {
  @override
  void dependencies() {
    final NavigationService navigationService = Get.find<NavigationService>();
    final TrackerRepository trackerRepository = Get.find<TrackerRepository>();
    Get.lazyPut<TrackerapplicationdetailController>(
      () => TrackerapplicationdetailController(
        navigationService: navigationService,
        trackerRepository: trackerRepository,
      ),
    );
  }
}
