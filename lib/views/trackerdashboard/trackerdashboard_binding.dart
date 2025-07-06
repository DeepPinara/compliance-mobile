import 'package:compliancenavigator/data/services/navigation_service/navigation_import.dart';
import 'package:compliancenavigator/modules/auth/auth_repository.dart';
import 'package:compliancenavigator/modules/dashboard/dashboard_repository.dart';
import 'package:compliancenavigator/modules/principle/principle_repository.dart';
import 'package:compliancenavigator/modules/tracker/tracker_repository.dart';
import 'package:compliancenavigator/modules/user/user_repository.dart';
import 'package:compliancenavigator/views/home/home_controller.dart';
import 'package:compliancenavigator/views/profile/profile_controller.dart';
import 'package:compliancenavigator/views/trackerhome/trackerhome_controller.dart';
import 'package:compliancenavigator/views/trackermenu/trackermenu_controller.dart';
import 'package:get/get.dart';
import 'trackerdashboard_controller.dart';

class TrackerdashboardBinding extends Bindings {
  @override
  void dependencies() {
    final UserRepository userRepository = Get.find<UserRepository>();
    final AuthRepository authRepository = Get.find<AuthRepository>();
    final NavigationService navigationService = Get.find<NavigationService>();
    final PrincipleRepository principleRepository =
        Get.find<PrincipleRepository>();
    final TrackerRepository trackerRepository = Get.find<TrackerRepository>();

    userRepository.syncCurrentUser();

    final DashboardRepository dashboardRepository =
        Get.find<DashboardRepository>();

    Get.lazyPut<TrackerhomeController>(
      () => TrackerhomeController(
        dashboardRepository: dashboardRepository,
        navigationService: navigationService,
      ),
    );

    Get.lazyPut<TrackermenuController>(
      () => TrackermenuController(navigationService: navigationService),
    );

    // ProfileController
    Get.lazyPut<ProfileController>(
      () => ProfileController(
          userRepository: userRepository,
          authRepository: authRepository,
          navigationService: navigationService),
    );

    Get.lazyPut<TrackerdashboardController>(
      () => TrackerdashboardController(
        homeController: Get.find<TrackerhomeController>(),
      ),
    );
  }
}
