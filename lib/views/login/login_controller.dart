import 'package:compliancenavigator/data/services/navigation_service/navigation_import.dart';
import 'package:compliancenavigator/modules/auth/auth_repository.dart';
import 'package:compliancenavigator/utils/snack_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final AuthRepository authRepository;
  final NavigationService navigationService;

  LoginController(
      {required this.authRepository, required this.navigationService});

  static const String loginScreenId = 'Login_screen';
  bool isLoading = false;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void onInit() {
    super.onInit();

    if (kDebugMode) {
      emailController.text = 'deepinara10@gmail.com';
      passwordController.text = 'Deep@12345';
    }
  }

  @override
  void onClose() {
    super.onClose();
  }

  void updateLoadingState({bool isLoading = false}) {
    this.isLoading = isLoading;
    update([loginScreenId]);
  }

  void handleLogin() async {
    try {
      updateLoadingState(isLoading: true);
      final email = emailController.text.trim();
      final password = passwordController.text.trim();

      if (email.isEmpty || password.isEmpty) {
        throw 'Please enter email and password';
      }

      await authRepository.login(email: email, password: password);

      showSnackBar('Login successful', isSuccess: true);

      navigationService.navigateToDashboard();
    } catch (e) {
      showSnackBar(e.toString(), isSuccess: false);
    } finally {
      updateLoadingState();
    }
  }

}
