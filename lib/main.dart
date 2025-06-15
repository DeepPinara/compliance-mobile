import 'package:compliancenavigator/data/services/storage_service.dart';
import 'package:compliancenavigator/routes/route_imports.dart';
import 'package:compliancenavigator/themes/app_bar.dart';
import 'package:compliancenavigator/themes/button_theme.dart';
import 'package:compliancenavigator/themes/colors.dart';
import 'package:compliancenavigator/themes/fonts.dart';
import 'package:compliancenavigator/themes/text_field_theme.dart';
import 'package:compliancenavigator/utils/constants.dart';
import 'package:compliancenavigator/utils/enums.dart';
import 'package:compliancenavigator/views/dashboard/dashboard_screen.dart';
import 'package:compliancenavigator/views/login/login_screen.dart';
import 'package:compliancenavigator/core/di/dependency_injection.dart';
import 'package:compliancenavigator/views/selectmodule/selectmodule_screen.dart';
import 'package:compliancenavigator/views/trackerdashboard/trackerdashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  DependencyInjection.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // navigatorObservers: <NavigatorObserver>[observer],
      debugShowCheckedModeBanner: false,
      title: AppConstants.appName,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.backgroundColor,
        appBarTheme: const DLAppBarTheme(),
        colorScheme: AppColors.lightTheme,
        useMaterial3: true,
        elevatedButtonTheme: const DLElevatedButtonTheme(),
        outlinedButtonTheme: const DLOutlinedButtonTheme(),
        textTheme: const DLTextTheme(),
        inputDecorationTheme: const DLInputDecorationTheme(),
      ),
      // darkTheme: ThemeData(
      //   scaffoldBackgroundColor: AppColors.darkBackgroundColor,
      //   appBarTheme: const DLAppBarTheme(),
      //   colorScheme: AppColors.darkTheme,
      //   useMaterial3: true,
      //   elevatedButtonTheme: const DLElevatedButtonTheme(),
      //   outlinedButtonTheme: const DLOutlinedButtonTheme(),
      //   textTheme: const DLTextTheme(),
      //   inputDecorationTheme: const DLInputDecorationTheme(),
      // ),
      // themeMode: ThemeMode.system, // This will follow system theme
      initialBinding: MainBinding(),
      getPages: Routes().getGetXPages(),
      initialRoute: getInitialRoute(),
    );
  }

  String getInitialRoute() {
    final storageService = Get.find<StorageService>();
    bool hasValidUser = storageService.isTokenAvailable();
    bool hasValidSelectmodule = storageService.isSelectmoduleAvailable();
    Selectmodule? selectmodule = storageService.getSelectmodule();

    // navigateToSelectmodule
    return hasValidUser
        ? hasValidSelectmodule
            ? selectmodule?.name == Selectmodule.compliance.name
                ? kDashboardRoute
                : kTrackerdashboardRoute
            : kSelectmoduleRoute
        : kLoginRoute;
  }
}

class MainBinding extends Bindings {
  @override
  void dependencies() {}
}
