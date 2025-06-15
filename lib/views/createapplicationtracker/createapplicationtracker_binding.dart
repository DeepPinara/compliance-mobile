import 'package:compliancenavigator/modules/principle/principle_repository.dart';
import 'package:compliancenavigator/modules/tracker/tracker_repository.dart';
import 'package:get/get.dart';
import 'createapplicationtracker_controller.dart';

class CreateapplicationtrackerBinding extends Bindings {
  @override
  void dependencies() {
    final PrincipleRepository principleRepository =
        Get.find<PrincipleRepository>();
    final TrackerRepository trackerRepository = Get.find<TrackerRepository>();
    Get.lazyPut<CreateapplicationtrackerController>(
      () => CreateapplicationtrackerController(
        principleRepository: principleRepository,
        trackerRepository: trackerRepository,
      ),
    );
  }
}
