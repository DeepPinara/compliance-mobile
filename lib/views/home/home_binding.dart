import 'package:compliancenavigator/modules/dashboard/dashboard_repository.dart';
import 'package:compliancenavigator/data/services/navigation_service/navigation_import.dart';
import 'package:get/get.dart';
import 'home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    final DashboardRepository dashboardRepository =
        Get.find<DashboardRepository>();
    final NavigationService navigationService = Get.find<NavigationService>();

    Get.lazyPut<HomeController>(
      () => HomeController(
        dashboardRepository: dashboardRepository,
        navigationService: navigationService,
      ),
    );
  }
}
