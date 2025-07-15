import 'package:compliancenavigator/utils/images.dart';
import 'package:compliancenavigator/widgets/buttons/primary_button.dart';
import 'package:compliancenavigator/widgets/image_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'login_controller.dart';
import 'package:compliancenavigator/widgets/text_field.dart';
// import 'package:digilex/widgets/app_bar.dart';

const String kLoginRoute = '/login';

class LoginScreen extends GetWidget<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      // appBar: const DLAppBar(
      //   title: 'Login title',
      //   subtitle: 'Login subtitle',
      // ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ImageViewer(
                  imageUrl: dImagesLogo01,
                  height: 300,
                  fit: BoxFit.cover,
                ).build(),
                Text(
                  'Welcome Back!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                AppTextField(
                  controller: controller.emailController,
                  label: 'Email',
                  hint: 'Enter your email',
                  type: TextFieldType.email,
                  prefixIcon: Icon(Icons.email, color: colorScheme.primary),
                  isRequired: true,
                ),
                const SizedBox(height: 16),
                AppTextField(
                  controller: controller.passwordController,
                  label: 'Password',
                  hint: 'Enter your password',
                  type: TextFieldType.text,
                  prefixIcon: Icon(Icons.lock, color: colorScheme.primary),
                  isRequired: true,
                ),
                const SizedBox(height: 24),
                PrimaryButton(
                  onPressed: controller.handleLogin,
                  text: 'Login',
                  isLoading: controller.isLoading,
                  width: double.infinity,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
