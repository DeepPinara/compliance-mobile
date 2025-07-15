// ignore_for_file: avoid_returning_null_for_void

import 'dart:io';

import 'package:compliancenavigator/data/models/create_tracker.dart';
import 'package:compliancenavigator/data/models/dashboard_data.dart';
import 'package:compliancenavigator/data/models/auth/login_response.dart';
import 'package:compliancenavigator/data/models/bug_report.dart';
import 'package:compliancenavigator/data/models/company.dart';
import 'package:compliancenavigator/data/models/contractor.dart';
import 'package:compliancenavigator/data/models/file_upload_response.dart';
import 'package:compliancenavigator/data/models/principle.dart';
import 'package:compliancenavigator/data/models/company_name_model.dart';
import 'package:compliancenavigator/data/models/api_response.dart';
import 'package:compliancenavigator/data/models/list_api_response.dart';
import 'package:compliancenavigator/data/models/tracker_application.dart';
import 'package:compliancenavigator/data/models/user.dart';
import 'package:compliancenavigator/data/services/backend/end_points.dart';
import 'package:compliancenavigator/data/clients/network/api_service_base.dart';
import 'package:compliancenavigator/data/clients/network/backend/api_service.dart';
import 'package:compliancenavigator/data/clients/network/backend/exceptions/network_exception.dart';
import 'package:compliancenavigator/data/clients/network/backend/error_handling/network_error_constants.dart';
import 'package:compliancenavigator/utils/enums.dart';
import 'package:compliancenavigator/utils/file_utils/file_picker.dart';
import 'package:dio/dio.dart';

/// BackendApiCallService: Implementation of all API endpoints from the Swagger documentation
class BackendApiCallService {
  final ApiClientBase _apiService;

  BackendApiCallService({ApiClientBase? apiService})
      : _apiService = apiService ?? ApiDioClient();

  // ==================== Tracker API ====================

  /// Create a new tracker
  Future<CreateTrackerResponse> createTrackerApplication(
      CreateTrackerRequest request) async {
    final response = await _apiService.post<Map<String, dynamic>>(
      ApiEndpoints.tracker,
      data: request.toBackendJson(),
      fromJson: (data) => data as Map<String, dynamic>,
    );

    return CreateTrackerResponse.fromJson(response);
  }

  /// Get all trackers with pagination and search
  Future<ApiResponse<ListApiResponse<TrackerApplication>>> getTrackers({
    int page = 1,
    int limit = 10,
    String? search,
  }) async {
    final params = {
      'page': page.toString(),
      'limit': limit.toString(),
      if (search != null && search.isNotEmpty) 'search': search,
    };

    return await _apiService
        .get<ApiResponse<ListApiResponse<TrackerApplication>>>(
      ApiEndpoints.tracker,
      queryParameters: params,
      fromJson: (data) => ApiResponse.fromJson(
        data,
        (json) => ListApiResponse<TrackerApplication>.fromJson(
          json as Map<String, dynamic>,
          (json) => TrackerApplication.fromJson(json as Map<String, dynamic>),
        ),
      ),
    );
  }

  //trackerDocToBeVerified
  Future<ApiResponse<ListApiResponse<TrackerApplication>>>
      getTrackerDocToBeVerified({
    required int page,
    required int limit,
    String? search,
  }) async {
    final queryParams = <String, dynamic>{
      'page': page,
      'limit': limit,
      if (search != null) 'search': search,
    };

    return await _apiService
        .get<ApiResponse<ListApiResponse<TrackerApplication>>>(
      ApiEndpoints.trackerDocToBeVerified,
      queryParameters: queryParams,
      fromJson: (data) => ApiResponse.fromJson(
        data,
        (json) => ListApiResponse<TrackerApplication>.fromJson(
          json as Map<String, dynamic>,
          (json) => TrackerApplication.fromJson(json as Map<String, dynamic>),
        ),
      ),
    );
  }

  //Update tracker Doc To Be Verified
  Future<ApiResponse<Map<String, dynamic>>> updateDocToBeVerified({
    required int id,
    required TrackerApplicationStatus applicationStatus,
    required String remark,
  }) async {
    final body = {
      'applicationStatus': applicationStatus.toBackend(),
      'remark': remark,
    };

    return await _apiService.post<ApiResponse<Map<String, dynamic>>>(
      '${ApiEndpoints.trackerDocToBeVerified}/$id',
      data: body,
      fromJson: (data) {
        if (data == null) {
          throw NetworkException(
            code: NetworkErrorCode.unknown,
            message: 'Invalid response from server',
          );
        }
        return ApiResponse.fromJson(
          data as Map<String, dynamic>,
          (json) => json as Map<String, dynamic>,
        );
      },
    );
  }

  /// Get tracker by ID
  Future<ApiResponse<Map<String, dynamic>>> getTrackerById(int id) async {
    return await _apiService.get<ApiResponse<Map<String, dynamic>>>(
      '${ApiEndpoints.tracker}/$id',
      fromJson: (data) {
        if (data == null) {
          throw NetworkException(
            code: NetworkErrorCode.unknown,
            message: 'Invalid response from server',
          );
        }
        return ApiResponse.fromJson(
          data as Map<String, dynamic>,
          (json) => json as Map<String, dynamic>,
        );
      },
    );
  }

  /// Update tracker by ID
  Future<ApiResponse<Map<String, dynamic>>> updateTracker(
    TrackerApplication tracker,
  ) async {
    return await _apiService.put<ApiResponse<Map<String, dynamic>>>(
      '${ApiEndpoints.tracker}/${tracker.id}',
      data: tracker.toBackendJson(),
      fromJson: (data) {
        if (data == null) {
          throw NetworkException(
            code: NetworkErrorCode.unknown,
            message: 'Invalid response from server',
          );
        }

        // Handle the response format: {data: OK, message: "Tracker updated successfully"}
        final responseData = data as Map<String, dynamic>;
        return ApiResponse<Map<String, dynamic>>(
          data: responseData,
          message: responseData['message'] as String?,
          success: true,
        );
      },
    );
  }

  // Tracker File Upload Admin
  // /rest/file-upload/tracker
  Future<ApiResponse<FileUploadResponse>> uploadTrackerFileAdmin(
      String fileName) async {
    return await _apiService.post<ApiResponse<FileUploadResponse>>(
      ApiEndpoints.trackerFileUploadAdmin,
      data: {
        'fileName': fileName,
      },
      fromJson: (data) => ApiResponse.fromJson(
        data,
        (json) => FileUploadResponse.fromJson(json),
      ),
    );
  }

  // ==================== Authentication ====================

  Future<ApiResponse<LoginResponse>> login(
      String email, String password) async {
    return await _apiService.post<ApiResponse<LoginResponse>>(
      ApiEndpoints.login,
      data: {
        'email': email,
        'password': password,
      },
      fromJson: (data) {
        if (data == null) {
          throw NetworkException(
            code: NetworkErrorCode.unknown,
            message: 'Invalid response from server',
          );
        }
        return ApiResponse.fromJson(
          data as Map<String, dynamic>,
          (json) => LoginResponse.fromJson(json as Map<String, dynamic>),
        );
      },
    );
  }

  Future<ApiResponse<Map<String, dynamic>>> signup(
      String email, String password, String userName) async {
    return await _apiService.post<ApiResponse<Map<String, dynamic>>>(
      ApiEndpoints.signup,
      data: {
        'email': email,
        'password': password,
        'userName': userName,
      },
      fromJson: (data) => ApiResponse.fromJson(
        data,
        (json) => json as Map<String, dynamic>,
      ),
    );
  }

  // ==================== Logs APIs ====================

  Future<ApiResponse<void>> createLog() async {
    return await _apiService.post<ApiResponse<void>>(
      ApiEndpoints.logs,
      data: {},
      fromJson: (data) => ApiResponse.fromJson(
        data,
        (json) => {},
      ),
    );
  }


  // ==================== Bug Report APIs ====================

  Future<ApiResponse<BugReport>> createBugReport(BugReport bugReport) async {
    return await _apiService.post<ApiResponse<BugReport>>(
      ApiEndpoints.bugReport,
      data: bugReport.toJson(),
      fromJson: (data) => ApiResponse.fromJson(
        data,
        (json) => BugReport.fromJson(json),
      ),
    );
  }

  Future<ApiResponse<List<BugReport>>> getAllBugReports(
      {int? page, int? limit, String? search}) async {
    final queryParams = {
      if (page != null) 'page': page,
      if (limit != null) 'limit': limit,
      if (search != null) 'search': search,
    };

    return await _apiService.get<ApiResponse<List<BugReport>>>(
      ApiEndpoints.buildUrl(ApiEndpoints.bugReport, queryParams),
      fromJson: (data) => ApiResponse.fromJson(
        data,
        (json) => (json as List)
            .map((item) => BugReport.fromJson(item as Map<String, dynamic>))
            .toList(),
      ),
    );
  }

  Future<ApiResponse<BugReport>> getBugReportById(int id) async {
    return await _apiService.get<ApiResponse<BugReport>>(
      ApiEndpoints.bugReportById(id),
      fromJson: (data) => ApiResponse.fromJson(
        data,
        (json) => BugReport.fromJson(json),
      ),
    );
  }

  // ==================== Company APIs ====================

  Future<ApiResponse<Map<String, dynamic>>> createCompany(
      CreateCompanyRequest request) async {
    return await _apiService.post<ApiResponse<Map<String, dynamic>>>(
      ApiEndpoints.company,
      data: request.toJson(),
      fromJson: (data) => ApiResponse.fromJson(
        data,
        (json) => json as Map<String, dynamic>,
      ),
    );
  }

  Future<ApiResponse<ListApiResponse<Map<String, dynamic>>>> getCompanies(
      {int? page, int? limit}) async {
    final queryParams = {
      if (page != null) 'page': page,
      if (limit != null) 'limit': limit,
    };

    return await _apiService
        .get<ApiResponse<ListApiResponse<Map<String, dynamic>>>>(
      ApiEndpoints.buildUrl(ApiEndpoints.company, queryParams),
      fromJson: (data) => ApiResponse.fromJson(
        data,
        (json) => ListApiResponse.fromJson(json as Map<String, dynamic>,
            (json) => json as Map<String, dynamic>),
      ),
    );
  }

  Future<ApiResponse<ListApiResponse<CompanyName>>> getCompanyNames() async {
    return await _apiService.get<ApiResponse<ListApiResponse<CompanyName>>>(
      ApiEndpoints.companyNames,
      fromJson: (data) => ApiResponse.fromJson(
        data as Map<String, dynamic>,
        (json) => ListApiResponse.fromJson(json as Map<String, dynamic>,
            (json) => CompanyName.fromJson(json as Map<String, dynamic>)),
      ),
    );
  }

  Future<ApiResponse<Map<String, dynamic>>> getCompanyByCode(
      String code) async {
    return await _apiService.get<ApiResponse<Map<String, dynamic>>>(
      ApiEndpoints.companyByCode(code),
      fromJson: (data) => ApiResponse.fromJson(
        data,
        (json) => json as Map<String, dynamic>,
      ),
    );
  }

  Future<ApiResponse<Principle>> getCompanyById(int id) async {
    return await _apiService.get<ApiResponse<Principle>>(
      ApiEndpoints.companyById(id),
      fromJson: (data) => ApiResponse.fromJson(
        data,
        (json) => Principle.fromJson(json as Map<String, dynamic>),
      ),
    );
  }

  Future<ApiResponse<ListApiResponse<Principle>>> getPrincipleList({
    int? page,
    int? limit = 10,
  }) async {
    final queryParams = {
      if (page != null) 'page': page,
      if (limit != null) 'limit': limit,
    };

    return await _apiService.get<ApiResponse<ListApiResponse<Principle>>>(
      ApiEndpoints.buildUrl(ApiEndpoints.company, queryParams),
      fromJson: (data) => ApiResponse.fromJson(
        data,
        (json) => ListApiResponse<Principle>.fromJson(
          json as Map<String, dynamic>,
          (item) => Principle.fromJson(item as Map<String, dynamic>),
        ),
      ),
    );
  }

  Future<ApiResponse<void>> deleteCompany(int id) async {
    return await _apiService.delete<ApiResponse<void>>(
      ApiEndpoints.companyById(id),
      fromJson: (data) => ApiResponse.fromJson(
        data,
        (json) {},
      ),
    );
  }

  Future<ApiResponse<Map<String, dynamic>>> updateCompany(
      int id, UpdateCompanyRequest request) async {
    return await _apiService.put<ApiResponse<Map<String, dynamic>>>(
      ApiEndpoints.companyById(id),
      data: request.toJson(),
      fromJson: (data) => ApiResponse.fromJson(
        data,
        (json) => json as Map<String, dynamic>,
      ),
    );
  }

  // ==================== Contractor APIs ====================

  Future<ApiResponse<int>> getTotalContractors() async {
    return await _apiService.get<ApiResponse<int>>(
      ApiEndpoints.contractorCount,
      fromJson: (data) => ApiResponse.fromJson(
        data,
        (json) => json as int,
      ),
    );
  }

  Future<ApiResponse<void>> assignContractor(
      int contractorId, String userId) async {
    return await _apiService.post<ApiResponse<void>>(
      ApiEndpoints.contractorAssign,
      data: {
        'contractor_id': contractorId,
        'user_id': userId,
      },
      fromJson: (data) => ApiResponse.fromJson(
        data,
        (json) {},
      ),
    );
  }

  Future<ApiResponse<Map<String, dynamic>>> createContractor(
      CreateContractorRequest request) async {
    return await _apiService.post<ApiResponse<Map<String, dynamic>>>(
      ApiEndpoints.contractor,
      data: request.toJson(),
      fromJson: (data) => ApiResponse.fromJson(
        data,
        (json) => json as Map<String, dynamic>,
      ),
    );
  }

  Future<ApiResponse<List<Map<String, dynamic>>>> getContractors(
      {int? page, int? limit, String? search, bool? unAssigned}) async {
    final queryParams = {
      if (page != null) 'page': page,
      if (limit != null) 'limit': limit,
      if (search != null) 'search': search,
      if (unAssigned != null) 'unAssigned': unAssigned,
    };

    return await _apiService.get<ApiResponse<List<Map<String, dynamic>>>>(
      ApiEndpoints.buildUrl(ApiEndpoints.contractor, queryParams),
      fromJson: (data) => ApiResponse.fromJson(
        data,
        (json) => (json as List).cast<Map<String, dynamic>>(),
      ),
    );
  }

  Future<ApiResponse<List<String>>> getContractorNames() async {
    return await _apiService.get<ApiResponse<List<String>>>(
      ApiEndpoints.contractorNames,
      fromJson: (data) => ApiResponse.fromJson(
        data,
        (json) => (json as List).cast<String>(),
      ),
    );
  }

  Future<ApiResponse<Map<String, dynamic>>> getContractorById(int id) async {
    return await _apiService.get<ApiResponse<Map<String, dynamic>>>(
      ApiEndpoints.contractorById(id),
      fromJson: (data) => ApiResponse.fromJson(
        data,
        (json) => json as Map<String, dynamic>,
      ),
    );
  }

  Future<ApiResponse<Map<String, dynamic>>> updateContractor(
      int id, UpdateContractorRequest request) async {
    return await _apiService.put<ApiResponse<Map<String, dynamic>>>(
      ApiEndpoints.contractorById(id),
      data: request.toJson(),
      fromJson: (data) => ApiResponse.fromJson(
        data,
        (json) => json as Map<String, dynamic>,
      ),
    );
  }

  Future<ApiResponse<void>> deleteContractor(
      int companyId, int contractorId) async {
    return await _apiService.delete<ApiResponse<void>>(
      ApiEndpoints.contractorByCompanyAndId(companyId, contractorId),
      fromJson: (data) => ApiResponse.fromJson(
        data,
        (json) => null,
      ),
    );
  }

  // ==================== User APIs ====================

  Future<ApiResponse<Map<String, dynamic>>> getAllUsers(
      {int? page, int? limit, String? role}) async {
    final queryParams = {
      if (page != null) 'page': page,
      if (limit != null) 'limit': limit,
      if (role != null) 'role': role,
    };

    return await _apiService.get<ApiResponse<Map<String, dynamic>>>(
      ApiEndpoints.buildUrl(ApiEndpoints.users, queryParams),
      fromJson: (data) => ApiResponse.fromJson(
        data,
        (json) => json as Map<String, dynamic>,
      ),
    );
  }

  Future<ApiResponse<Map<String, dynamic>>> createUser(
      CreateUserRequest request) async {
    return await _apiService.post<ApiResponse<Map<String, dynamic>>>(
      ApiEndpoints.users,
      data: request.toJson(),
      fromJson: (data) => ApiResponse.fromJson(
        data,
        (json) => json as Map<String, dynamic>,
      ),
    );
  }

  Future<ApiResponse<void>> deleteCurrentUser() async {
    return await _apiService.delete<ApiResponse<void>>(
      ApiEndpoints.users,
      fromJson: (data) => ApiResponse.fromJson(
        data,
        (json) => null,
      ),
    );
  }

  Future<ApiResponse<Map<String, dynamic>>> getCurrentUser() async {
    return await _apiService.get<ApiResponse<Map<String, dynamic>>>(
      ApiEndpoints.currentUser,
      fromJson: (data) => ApiResponse.fromJson(
        data,
        (json) => json as Map<String, dynamic>,
      ),
    );
  }

  Future<ApiResponse<Map<String, dynamic>>> updateCurrentUser(
      UpdateUserRequest request) async {
    return await _apiService.put<ApiResponse<Map<String, dynamic>>>(
      ApiEndpoints.currentUser,
      data: request.toJson(),
      fromJson: (data) => ApiResponse.fromJson(
        data,
        (json) => json as Map<String, dynamic>,
      ),
    );
  }

  Future<ApiResponse<Map<String, dynamic>>> getUserById(String id) async {
    return await _apiService.get<ApiResponse<Map<String, dynamic>>>(
      ApiEndpoints.userById(id),
      fromJson: (data) => ApiResponse.fromJson(
        data,
        (json) => json as Map<String, dynamic>,
      ),
    );
  }

  Future<ApiResponse<Map<String, dynamic>>> updateUserById(
      String id, UpdateUserRequest request) async {
    return await _apiService.put<ApiResponse<Map<String, dynamic>>>(
      ApiEndpoints.userById(id),
      data: request.toJson(),
      fromJson: (data) => ApiResponse.fromJson(
        data,
        (json) => json as Map<String, dynamic>,
      ),
    );
  }

  Future<ApiResponse<void>> deleteUserById(String id) async {
    return await _apiService.delete<ApiResponse<void>>(
      ApiEndpoints.userById(id),
      fromJson: (data) => ApiResponse.fromJson(
        data,
        (json) => null,
      ),
    );
  }

// ==================== Dashboard APIs ====================

// Dashboard Data
  Future<ApiResponse<DashboardData>> dashboardData() async {
    return await _apiService.get<ApiResponse<DashboardData>>(
      ApiEndpoints.dashboard,
      fromJson: (data) => ApiResponse.fromJson(
        data,
        (json) => DashboardData.fromBackend(json as Map<String, dynamic>),
      ),
    );
  }

  /// Upload file using the presigned URL
  Future<bool> uploadFileWithPresignedUrl(
      String presignedUrl, PickedFile file, String fileName) async {
    try {
      final dio = Dio();

      // Read file as bytes
      final File fileObj = File(file.path!);
      final bytes = await fileObj.readAsBytes();

      // Determine content type based on file extension
      String contentType = 'application/octet-stream';
      if (fileName.toLowerCase().endsWith('.jpg') ||
          fileName.toLowerCase().endsWith('.jpeg')) {
        contentType = 'image/jpeg';
      } else if (fileName.toLowerCase().endsWith('.png')) {
        contentType = 'image/png';
      }

      final response = await dio.put(
        presignedUrl,
        data: Stream.fromIterable([bytes]),
        options: Options(
          headers: {
            'Content-Type': contentType,
            'Content-Length': bytes.length.toString(),
          },
          contentType: contentType,
        ),
      );

      return response.statusCode == 200;
    } catch (e) {
      rethrow;
    }
  }
}
