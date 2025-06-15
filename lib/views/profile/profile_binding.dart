import 'package:compliancenavigator/modules/user/user_repository.dart';
import 'package:get/get.dart';
import 'profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    final userRepository = Get.find<UserRepository>();
    Get.lazyPut<ProfileController>(
      () => ProfileController(userRepository: userRepository),
    );
  }
}
