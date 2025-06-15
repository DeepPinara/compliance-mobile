import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:get/get_utils/src/platform/platform.dart';

class AppConstants {
  // App Info
  static const String appName = 'Compliance Navigator';
  static const String appVersion = '1.0.0';

  // Storage Keys
  static const String tokenKey = 'auth_token';
  static const String userKey = 'user_data';

  // Timeouts
  static const int connectionTimeout = 30000;
  static const int receiveTimeout = 30000;

  // Pagination
  static const int defaultPageSize = 20;

  static const double kAppScreenSpacing = 16.0;

  static double kAppBottomSpacing = GetPlatform.isIOS ? 0.0 : 12.0;

  static const int kSplashScreenMillisecond = 1500;

  static const int kScreenTransitionDuration = 300;
  static const Transition kScreenTransitionType = Transition.fadeIn;

  static const double kSocialLoginIconSize = 30.0;

  static const String kAppdateFormat = 'dd-MMM-yyyy';
  static const String kAppTimeFormat = 'hh:mm a';

  static const String kAppdateFormatWithTime = 'dd-MMM-yyyy hh:mm a';
  static const String kAppdateFormatWithTime24 = 'dd-MMM-yyyy HH:mm';
}
