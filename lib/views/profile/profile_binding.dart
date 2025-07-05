import 'package:compliancenavigator/data/services/navigation_service/navigation_import.dart';
import 'package:compliancenavigator/modules/auth/auth_repository.dart';
import 'package:compliancenavigator/modules/user/user_repository.dart';
import 'package:get/get.dart';
import 'profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    final userRepository = Get.find<UserRepository>();
    final authRepository = Get.find<AuthRepository>();
    final navigationService = Get.find<NavigationService>();
    Get.lazyPut<ProfileController>(
      () => ProfileController(
        userRepository: userRepository,
        authRepository: authRepository,
        navigationService: navigationService,
      ),
    );
  }
}
