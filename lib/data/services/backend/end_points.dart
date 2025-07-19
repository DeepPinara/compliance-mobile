class ApiEndpoints {
  // Base URLs
  // static const String baseUrl = "https://api.compliancenavigator.pro/";
  static const String baseUrl = "http://13.201.46.237/";
  static const String apiPrefix = "rest";
  static const String apiBase = "$baseUrl$apiPrefix";
  
  // Auth endpoints
  static const String login = "$apiBase/auth/login";
  static const String signup = "$apiBase/auth/signup";
  
  // Bug Report endpoints
  static const String bugReport = "$apiBase/report-bug";
  static String bugReportById(int id) => "$bugReport/$id";
  
  // Company endpoints
  static const String company = "$apiBase/company";
  static const String companyNames = "$company/get-company-names";
  static String companyByCode(String code) => "$companyNames/$code";
  static String companyById(int id) => "$company/$id";

  // logs endpoints
  static const String logs = "$apiBase/logs";
  static String logsById(int id) => "$logs/$id";
  static String logsByUser(int userId) => "$logs/user/$userId";
  
  // Contractor endpoints
  static const String contractor = "$apiBase/contractor";
  static const String contractorCount = "$contractor/count";
  static const String contractorAssign = "$contractor/assign";
  static const String contractorNames = "$contractor/names";
  static String contractorById(int id) => "$contractor/$id";
  static String contractorByCompanyAndId(int companyId, int contractorId) =>
      "$contractor/$companyId/$contractorId";
  
  // Dashboard endpoints
  static const String dashboard = "$apiBase/dashboard";
  static const String dashboardTeams = "$dashboard/teams";

  // Tracker Dashboard endpoints
  static const String trackerDashboardStats = "$dashboard/stats";
  
  // File Upload endpoints
  static const String fileUpload = "$apiBase/file-upload";
  static const String fileUploadBulk = "$fileUpload/bulk";
  static const String fileUploadSaveKey = "$fileUpload/save-key";
  static const String fileUploadSaveKeyBulk = "$fileUpload/save-key/bulk";
  static const String fileUploadProcessData = "$fileUpload/process-data";
  static String fileUploadByContractorEmpCode(int contractorEmpCode) =>
      "$fileUpload/$contractorEmpCode";
  
  // User endpoints
  static const String users = "$apiBase/users";
  static const String currentUser = "$users/me";
  static String userById(String id) => "$users/$id";
  
  // Wage Master endpoints
  static const String wageMaster = "$apiBase/wage-master";
  
  // Tracker endpoints
  static const String tracker = "$apiBase/tracker";
  static const String trackerDocToBeVerified = "$tracker/doc-to-be-verified";
  static String trackerHyperLink(String secret) => "$tracker/$secret/hyper-link";
  static String trackerById(int id) => "$tracker/$id";
  static String trackerDocToBeVerifiedById(int id) => "$trackerDocToBeVerified/$id";
  static const String trackerFileUploadAdmin = "$apiBase/file-upload/tracker";
  static const String wageMasterBulk = "$wageMaster/bulk";
  static String wageMasterById(int id) => "$wageMaster/$id";
  
  // Workman endpoints
  static const String workman = "$apiBase/workman";
  static const String workmanBulk = "$workman/bulk";
  static String workmanById(String id) => "$workman/$id";
  
  // Zone Master endpoints
  static const String zoneMaster = "$apiBase/zone-master";
  static String zoneMasterById(int id) => "$zoneMaster/$id";
  
  // Misc endpoints
  static const String helloWorld = "$apiBase/hello-world";
  
  // Utility method to build endpoints with parameters
  static String buildPath(String endpoint, Map<String, dynamic> params) {
    String path = endpoint;
    params.forEach((key, value) {
      path = path.replaceAll('{$key}', value.toString());
    });
    return path;
  }
  
  // Utility method to build URL with query parameters
  static String buildUrl(String endpoint, Map<String, dynamic> queryParams) {
    if (queryParams.isEmpty) return endpoint;
    
    final Uri uri = Uri.parse(endpoint);
    final finalUri = uri.replace(queryParameters: queryParams.map(
      (key, value) => MapEntry(key, value.toString()),
    ));
    
    return finalUri.toString();
  }
}