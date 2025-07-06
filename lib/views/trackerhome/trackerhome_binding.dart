import 'package:compliancenavigator/data/services/navigation_service/navigation_import.dart';
import 'package:compliancenavigator/modules/dashboard/dashboard_repository.dart';
import 'package:get/get.dart';
import 'trackerhome_controller.dart';

class TrackerhomeBinding extends Bindings {
  @override
  void dependencies() {
    final DashboardRepository dashboardRepository =
        Get.find<DashboardRepository>();
    final NavigationService navigationService = Get.find<NavigationService>();
    Get.lazyPut<TrackerhomeController>(
      () => TrackerhomeController(
        dashboardRepository: dashboardRepository,
        navigationService: navigationService,
      ),
    );
  }
}
