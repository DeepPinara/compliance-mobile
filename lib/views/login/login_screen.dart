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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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
                type: TextFieldType.password,
                prefixIcon: Icon(Icons.lock, color: colorScheme.primary),
                isRequired: true,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: controller.handleLogin,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: colorScheme.primary,
                  foregroundColor: colorScheme.onPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
