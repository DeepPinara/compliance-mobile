import 'package:compliancenavigator/data/models/user.dart';
import 'package:compliancenavigator/data/services/navigation_service/navigation_import.dart';
import 'package:compliancenavigator/modules/auth/auth_repository.dart';
import 'package:compliancenavigator/modules/user/user_repository.dart';
import 'package:compliancenavigator/utils/snack_bar.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final UserRepository _userRepository;
  final AuthRepository _authRepository;
  final NavigationService _navigationService;

  ProfileController({
    required UserRepository userRepository,
    required AuthRepository authRepository,
    required NavigationService navigationService,
  })  : _userRepository = userRepository,
        _authRepository = authRepository,
        _navigationService = navigationService;

  static const String profileScreenId = 'Profile_screen';

  User? currentUser;
  bool isLoading = false;

  @override
  void onInit() {
    super.onInit();
    getCurrentUser();
  }

  void _updateState() {
    update([profileScreenId]);
  }

  Future<void> getCurrentUser() async {
    isLoading = true;
    _updateState();

    try {
      currentUser = await _userRepository.getCurrentUser();
    } catch (e) {
      showSnackBar(e.toString());
      currentUser = null;
    } finally {
      isLoading = false;
      _updateState();
    }
  }

  void logout() {
    _authRepository.logout();
    _navigationService.logOut();
  }
}
