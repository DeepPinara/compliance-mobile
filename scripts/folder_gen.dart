// ignore_for_file: avoid_print

import 'dart:io';
import 'package:path/path.dart' as path;

// File content creation functions
String createUserModel() {
  return '''
class User {
  final String id;
  final String name;
  final String email;

  User({
    required this.id,
    required this.name,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }
}
''';
}

String createStorageService() {
  return '''
class StorageService {
  Future<void> saveData(String key, String value) async {
    // TODO: Implement storage logic
  }

  Future<String?> getData(String key) async {
    // TODO: Implement retrieval logic
    return null;
  }

  Future<void> deleteData(String key) async {
    // TODO: Implement deletion logic
  }
}
''';
}

String createAuthRepository() {
  return '''
class AuthRepository {
  Future<void> signIn(String email, String password) async {
    // TODO: Implement sign in logic
  }

  Future<void> signOut() async {
    // TODO: Implement sign out logic
  }

  Future<bool> isSignedIn() async {
    // TODO: Implement auth state check
    return false;
  }
}
''';
}

String createRoutes() {
  return '''
import 'package:flutter/material.dart';
import 'route_imports.dart';

class Routes {
  static const String splash = '/';
  static const String login = '/login';
  static const String home = '/home';
  static const String profile = '/profile';
  static const String settings = '/settings';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      splash: (context) => const SplashScreen(),
      login: (context) => const LoginScreen(),
      home: (context) => const HomeScreen(),
      profile: (context) => const ProfileScreen(),
      settings: (context) => const SettingsScreen(),
    };
  }

  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case settings:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for \${routeSettings.name}'),
            ),
          ),
        );
    }
  }
}
''';
}

String createRouteImports() {
  return '''
// Import all your screen files here
import '../views/splash_screen.dart';
import '../views/login_screen.dart';
import '../views/home_screen.dart';
import '../views/profile_screen.dart';
import '../views/settings_screen.dart';
''';
}

String createColors() {
  return '''
import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF2196F3);
  static const Color secondary = Color(0xFF03A9F4);
  static const Color accent = Color(0xFF00BCD4);
  static const Color background = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFF5F5F5);
  static const Color error = Color(0xFFB00020);
  static const Color text = Color(0xFF000000);
}
''';
}

String createFonts() {
  return '''
import 'package:flutter/material.dart';

class AppFonts {
  static const String primaryFont = 'Roboto';
  static const String secondaryFont = 'OpenSans';

  static const TextStyle heading1 = TextStyle(
    fontFamily: primaryFont,
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle heading2 = TextStyle(
    fontFamily: primaryFont,
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle body = TextStyle(
    fontFamily: secondaryFont,
    fontSize: 16,
  );
}
''';
}

String createAppUrls() {
  return '''
class AppUrls {
  static const String baseUrl = 'https://api.example.com';
  static const String apiVersion = 'v1';
  
  static String get apiBaseUrl => '\${AppUrls.baseUrl}/\${AppUrls.apiVersion}';
  
  // Auth endpoints
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String logout = '/auth/logout';
  
  // User endpoints
  static const String profile = '/user/profile';
  static const String updateProfile = '/user/update';
}
''';
}

String createConstants() {
  return '''
class AppConstants {
  // App Info
  static const String appName = 'Your App Name';
  static const String appVersion = '1.0.0';
  
  // Storage Keys
  static const String tokenKey = 'auth_token';
  static const String userKey = 'user_data';
  
  // Timeouts
  static const int connectionTimeout = 30000;
  static const int receiveTimeout = 30000;
  
  // Pagination
  static const int defaultPageSize = 20;
}
''';
}

String createEnums() {
  return '''
enum LoadingState {
  initial,
  loading,
  loaded,
  error,
}

enum AuthStatus {
  signedOut,
  signedIn,
  loading,
}

enum ThemeMode {
  light,
  dark,
  system,
}
''';
}

String createConstantStrings() {
  return '''
class AppStrings {
  // Common
  static const String ok = 'OK';
  static const String cancel = 'Cancel';
  static const String error = 'Error';
  static const String success = 'Success';
  
  // Auth
  static const String login = 'Login';
  static const String logout = 'Logout';
  static const String email = 'Email';
  static const String password = 'Password';
  
  // Errors
  static const String networkError = 'Network error occurred';
  static const String unknownError = 'An unknown error occurred';
}
''';
}

void main(List<String> arguments) async {
  try {
    // Get the project root directory (where the script is being run from)
    final projectRoot = Directory.current.path;
    
    // Define the folder structure
    final folders = [
      'lib',
      'lib/core',
      'lib/core/di',
      'lib/data',
      'lib/data/clients',
      'lib/data/clients/auth',
      'lib/data/clients/storage',
      'lib/data/models',
      'lib/data/service',
      'lib/modules',
      'lib/modules/auth',
      'lib/routes',
      'lib/themes',
      'lib/utils',
      'lib/utils/extensions',
      'lib/widgets',
      'lib/views',
      'test',
    ];

    print('🚀 Creating folder structure...');

    // Create each folder
    for (final folder in folders) {
      final folderPath = path.join(projectRoot, folder);
      final directory = Directory(folderPath);
      
      if (!await directory.exists()) {
        await directory.create(recursive: true);
        print('✅ Created: $folder');
      } else {
        print('ℹ️  Already exists: $folder');
      }
    }

    // Create files with example content
    final files = {
      'lib/data/models/user.dart': createUserModel(),
      'lib/data/services/storage_service.dart': createStorageService(),
      'lib/modules/auth/auth_repository.dart': createAuthRepository(),
      'lib/routes/routes.dart': createRoutes(),
      'lib/routes/route_imports.dart': createRouteImports(),
      'lib/themes/colors.dart': createColors(),
      'lib/themes/fonts.dart': createFonts(),
      'lib/utils/app_urls.dart': createAppUrls(),
      'lib/utils/constants.dart': createConstants(),
      'lib/utils/enums.dart': createEnums(),
      'lib/utils/constant_strings.dart': createConstantStrings(),
    };

    // Create each file with its content
    for (final entry in files.entries) {
      final filePath = path.join(projectRoot, entry.key);
      final file = File(filePath);
      
      if (!await file.exists()) {
        await file.create(recursive: true);
        await file.writeAsString(entry.value);
        print('📝 Created: ${entry.key}');
      } else {
        print('ℹ️  Already exists: ${entry.key}');
      }
    }

    print('\n✨ Folder structure and files created successfully!');
    print('\n📁 Created the following structure:');
    print('''
lib/
├── core/
│   └── di/
├── data/
│   ├── clients/
│   │   ├── auth/
│   │   └── storage/
│   ├── models/
│   │   └── user.dart
│   └── service/
│       └── storage_service.dart
├── modules/
│   └── auth/
│       └── auth_repository.dart
├── routes/
│   ├── routes.dart
│   └── route_imports.dart
├── themes/
│   ├── colors.dart
│   └── fonts.dart
├── utils/
│   ├── extensions/
│   ├── app_urls.dart
│   ├── constants.dart
│   ├── enums.dart
│   └── constant_strings.dart
├── widgets/
└── views/
test/
''');

  } catch (e) {
    print('❌ Error creating folder structure: $e');
    exit(1);
  }
} 