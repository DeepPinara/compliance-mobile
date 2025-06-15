import 'package:compliancenavigator/modules/user/user_repository.dart';
import 'package:get/get.dart';
import 'teammanagement_controller.dart';

class TeammanagementBinding extends Bindings {
  @override
  void dependencies() {
    final UserRepository userRepository = Get.find<UserRepository>();

    Get.lazyPut<TeammanagementController>(
      () => TeammanagementController(
         userRepository,
      ),
    );
  }
}
