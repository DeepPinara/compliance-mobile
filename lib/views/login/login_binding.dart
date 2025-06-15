import 'package:compliancenavigator/data/services/navigation_service/navigation_import.dart';
import 'package:compliancenavigator/modules/auth/auth_repository.dart';
import 'package:get/get.dart';
import 'login_controller.dart';

class LoginBinding extends Bindings {
  final AuthRepository authRepository = Get.find<AuthRepository>();
  final NavigationService navigationService = Get.find<NavigationService>();
  
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
      () => LoginController(
        authRepository: authRepository,
        navigationService: navigationService,
      ),
    );
  }
}
