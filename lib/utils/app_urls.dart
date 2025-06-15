class AppUrls {
  static const String baseUrl = 'https://api.example.com';
  static const String apiVersion = 'v1';
  
  static String get apiBaseUrl => '${AppUrls.baseUrl}/${AppUrls.apiVersion}';
  
  // Auth endpoints
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String logout = '/auth/logout';
  
  // User endpoints
  static const String profile = '/user/profile';
  static const String updateProfile = '/user/update';
}
