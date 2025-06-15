import 'package:compliancenavigator/data/clients/network/backend/exceptions/network_exception.dart';
import 'package:compliancenavigator/data/models/api_response.dart';
import 'package:compliancenavigator/data/models/list_api_response.dart';
import 'package:compliancenavigator/data/services/backend/backend_api_service.dart';
import 'package:compliancenavigator/data/services/network_service.dart';
import 'package:compliancenavigator/data/models/user.dart';
import 'package:compliancenavigator/data/services/storage_service.dart';

class UserRepository {
  final BackendApiCallService _backendApiClient;
  final StorageService _storageService;
  final NetworkService _networkService;

  UserRepository({
    required BackendApiCallService backendApiClient,
    required StorageService storageService,
    required NetworkService networkService,
  })  : _backendApiClient = backendApiClient,
        _storageService = storageService,
        _networkService = networkService;

  Future<ApiResponse<ListApiResponse<User>>> getAllUsers(
      {int? page, int? limit, String? role}) async {
    try {
      await _networkService.checkInternetConnection();
      final response = await _backendApiClient.getAllUsers(
          page: page, limit: limit, role: role);

      return ApiResponse<ListApiResponse<User>>(
        data: ListApiResponse<User>(
          data: (response.data['data'] as List<dynamic>? ?? [])
              .map((e) => User.fromJson(e as Map<String, dynamic>))
              .toList(),
          totalCount: response.data['totalCount'] as int?,
        ),
        message: response.message,
        statusCode: response.statusCode,
        success: response.success,
      );
    } on NetworkException catch (e) {
      throw e.message;
    } catch (e) {
      rethrow;
    }
  }

  Future<User> getCurrentUser() async {
    try {
      await _networkService.checkInternetConnection();
      if (_storageService.isUserAvailable()) {
        return _storageService.getUser()!;
      }
      final response = await _backendApiClient.getCurrentUser();
      saveCurrentUser(User.fromJson(response.data));

      // The response.data is already non-nullable, so we can directly use it
      return User.fromJson(response.data);
    } on NetworkException catch (e) {
      throw e.message;
    } catch (e) {
      rethrow;
    }
  }

  // syncCurrentUser
  Future<User> syncCurrentUser() async {
    try {
      await _networkService.checkInternetConnection();
      final response = await _backendApiClient.getCurrentUser();
      await saveCurrentUser(User.fromJson(response.data));
      return User.fromJson(response.data);
    } on NetworkException catch (e) {
      throw e.message;
    } catch (e) {
      rethrow;
    }
  }

  // save into storage
  Future<void> saveCurrentUser(User user) async {
    await _storageService.saveUser(user);
  }

  // get from storage
  Future<User?> getCurrentUserFromStorage() async {
    return _storageService.getUser();
  }

  // Add other methods for create, update, delete, etc. as needed
}
