import 'package:compliancenavigator/data/services/navigation_service/navigation_import.dart';
import 'package:compliancenavigator/modules/tracker/tracker_repository.dart';
import 'package:get/get.dart';
import 'trackerdocforvalidationdetail_controller.dart';

class TrackerdocforvalidationdetailBinding extends Bindings {
  @override
  void dependencies() {
    final TrackerRepository trackerRepository = Get.find<TrackerRepository>();
    final NavigationService navigationService = Get.find<NavigationService>();
    Get.lazyPut<TrackerdocforvalidationdetailController>(
      () => TrackerdocforvalidationdetailController(
        trackerRepository: trackerRepository,
        navigationService: navigationService,
      ),
    );
  }
}
