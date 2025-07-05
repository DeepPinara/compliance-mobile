import 'package:compliancenavigator/data/clients/network/backend/exceptions/network_exception.dart';
import 'package:compliancenavigator/data/models/api_response.dart';
import 'package:compliancenavigator/data/models/auth/login_response.dart';
import 'package:compliancenavigator/data/services/backend/backend_api_service.dart';
import 'package:compliancenavigator/data/services/network_service.dart';
import 'package:compliancenavigator/data/services/storage_service.dart';

class AuthRepository {
  final BackendApiCallService _backendApiClient;
  final NetworkService _networkService;
  final StorageService _storageService;

  AuthRepository({
    required BackendApiCallService backendApiClient,
    required NetworkService networkService,
    required StorageService storageProvider,
  })  : _backendApiClient = backendApiClient,
        _storageService = storageProvider,
        _networkService = networkService;

  /// Login email and password
  Future<LoginResponse> login({
    required String email,
    required String password,
  }) async {
    try {
      await _networkService.checkInternetConnection();

      final ApiResponse<LoginResponse> response =
          await _backendApiClient.login(email, password);

      if (response.success) {
        // Store tokens in secure storage
        await _storageService.setAccessToken(response.data.accToken);
        await _storageService.setRefreshToken(response.data.refreshToken);

        return response.data;
      } else {
        throw response.message ?? 'Login failed';
      }
    } on NetworkException catch (e) {
      throw e.message;
    } catch (e) {
      rethrow;
    }
  }

  Future<String?> getToken() async {
    return _storageService.getAccessToken();
  }

  // Logout
  Future<void> logout() async {
    await _storageService.clearAuthData();
  }
}
