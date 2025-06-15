import 'package:compliancenavigator/data/models/user.dart';
import 'package:compliancenavigator/modules/user/user_repository.dart';
import 'package:compliancenavigator/utils/snack_bar.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final UserRepository _userRepository;

  ProfileController({required UserRepository userRepository})
      : _userRepository = userRepository;

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
}
 