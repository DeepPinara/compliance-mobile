// ignore_for_file: unused_element

part of 'navigation_import.dart';

/// Navigation service to abstract navigation logic
/// This ensures controllers don't directly handle navigation

class NavigationService {
  //  extends GetxService
  final NetworkService _networkService;
  final bool _enableLogging;

  NavigationService({
    required NetworkService networkService,
    bool enableLogging = true,
  })  : _enableLogging = enableLogging,
        _networkService = networkService;

  /// Private method to navigate to a new screen
  Future<dynamic> _navigateTo(
    String route, {
    dynamic arguments,
  }) async {
    try {
      await checkInternetConnection();
      _logNavigation('navigate_to', route, arguments);
      return await Get.toNamed(route, arguments: arguments);
    } catch (e) {
      showSnackBar(e.toString());
      return;
    }
  }

  /// Private method to navigate to a new screen and remove the previous screen
  Future<dynamic> _navigateToAndRemove(String route,
      {dynamic arguments}) async {
    try {
      await checkInternetConnection();
      _logNavigation('navigate_to_and_remove', route, arguments);
      return await Get.offAndToNamed(route, arguments: arguments);
    } catch (e) {
      showSnackBar(e.toString());
      return;
    }
  }

  /// Private method to navigate to a new screen and remove all previous screens
  Future<dynamic> _navigateToAndRemoveUntil(String route,
      {dynamic arguments}) async {
    try {
      await checkInternetConnection();
      _logNavigation('navigate_to_and_remove_until', route, arguments);
      return await Get.offAllNamed(route, arguments: arguments);
    } catch (e) {
      showSnackBar(e.toString());
      return;
    }
  }

  /// Go back to the previous screen
  void goBack() {
    _logNavigation('go_back', Get.currentRoute);
    Get.back();
  }

  bool canGoBack() {
    return Get.key.currentState?.canPop() ?? false;
  }

  /// Log out and navigate to login screen
  void logOut() {
    _logNavigation('logout', kLoginRoute);
    _navigateToAndRemoveUntil(kLoginRoute);
  }

  // login and signup
  void navigateToLoginAndRemoveUntil() {
    _navigateToAndRemoveUntil(kLoginRoute);
  }

  void navigateToDashboard() {
    _navigateToAndRemoveUntil(kDashboardRoute);
  }

  void navigateToTrackerdashboard() {
    _navigateToAndRemoveUntil(kTrackerdashboardRoute);
  }

  void navigateToTrackermenu() {
    _navigateTo(kTrackermenuRoute);
  }

  void navigateToCreateTracker() {
    _navigateTo(kCreateapplicationtrackerRoute);
  }

  void navigateToTrackerdocforvalidation() {
    _navigateTo(kTrackerdocforvalidationRoute);
  }


  // principle

  void navigateToPrincipleList() {
    _navigateTo(kPrinciplelistRoute);
  }

  void navigateToPrincipleDetail({required int id, Principle? principle}) {
    _navigateTo(kPrincipledetailRoute, arguments: {
      'principleId': id,
      'principle': principle,
    });
  }

  void navigateToSelectmodule() {
    _navigateToAndRemoveUntil(kSelectmoduleRoute);
  }

  /// Check internet connection
  Future<void> checkInternetConnection() async {
    if (!await _networkService.isConnected) {
      // Exception with message "No Internet Connection"
      throw 'No Internet Connection';
    }
  }

  // MARK: - Analytics Logging

  /// Log navigation events to analytics
  void _logNavigation(String action, String route, [dynamic arguments]) {
    // Log to console if enabled
    if (_enableLogging) {
      logger('Navigation: $action - $route, Arguments: $arguments');
    }

    // Log to analytics if client is available
    try {
      // _analyticsClient.logEvent(
      //   name: 'navigation',
      //   parameters: {
      //     'action': action,
      //     'route': route,
      //     'arguments': arguments?.toString() ?? '',
      //     'timestamp': DateTime.now().toIso8601String(),
      //   },
      // );

      // // Also log screen view for navigation actions
      // if (action == 'navigate_to' ||
      //     action == 'navigate_to_and_remove' ||
      //     action == 'navigate_to_and_remove_until') {
      //   _analyticsClient.logScreenView(
      //     screenName: route,
      //     screenClass: 'Screen',
      //   );
      // }
    } catch (e) {
      logger('Error logging navigation to analytics: $e');
    }
  }

  // logger
  void logger(String message) {
    // log('NavigationService: $message');
  }
}
