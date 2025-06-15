import 'package:compliancenavigator/data/services/navigation_service/navigation_import.dart';
import 'package:compliancenavigator/modules/dashboard/dashboard_repository.dart';
import 'package:compliancenavigator/modules/user/user_repository.dart';
import 'package:compliancenavigator/views/compliancemenu/compliancemenu_controller.dart';
import 'package:compliancenavigator/views/home/home_controller.dart';
import 'package:compliancenavigator/views/profile/profile_controller.dart';
import 'package:compliancenavigator/views/teammanagement/teammanagement_controller.dart';
import 'package:get/get.dart';
import 'dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    final UserRepository userRepository = Get.find<UserRepository>();
    final NavigationService navigationService = Get.find<NavigationService>();

    userRepository.syncCurrentUser();

    final DashboardRepository dashboardRepository =
        Get.find<DashboardRepository>();

    Get.lazyPut<HomeController>(
      () => HomeController(
        dashboardRepository: dashboardRepository,
        navigationService: navigationService,
      ),
    );

    Get.lazyPut<CompliancemenuController>(
      () => CompliancemenuController(),
    );

    // TeammanagementController
    Get.lazyPut<TeammanagementController>(
      () => TeammanagementController(
        userRepository,
      ),
    );

    // ProfileController
    Get.lazyPut<ProfileController>(
      () => ProfileController(userRepository: userRepository),
    );

    Get.lazyPut<DashboardController>(
      () => DashboardController(
        homeController: Get.find<HomeController>(),
      ),
    );
  }
}
