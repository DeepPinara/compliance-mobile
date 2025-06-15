import 'package:compliancenavigator/data/clients/network/backend/exceptions/network_exception.dart';
import 'package:compliancenavigator/data/models/api_response.dart';
import 'package:compliancenavigator/data/models/company_name_model.dart';
import 'package:compliancenavigator/data/models/list_api_response.dart';
import 'package:compliancenavigator/data/models/principle.dart';
import 'package:compliancenavigator/data/services/backend/backend_api_service.dart';
import 'package:compliancenavigator/data/services/network_service.dart';

class PrincipleRepository {
  final BackendApiCallService _backendApiClient;
  final NetworkService _networkService;

  PrincipleRepository({
    required BackendApiCallService backendApiClient,
    required NetworkService networkService,
  })  : _backendApiClient = backendApiClient,
        _networkService = networkService;

  /// Get paginated list of principles
  Future<ApiResponse<ListApiResponse<Principle>>> getPrinciples({
    int page = 1,
    int limit = 10,
  }) async {
    try {
      await _networkService.checkInternetConnection();
      return await _backendApiClient.getPrincipleList(
        page: page,
        limit: limit,
      );
    } on NetworkException catch (e) {
      throw e.message;
    } catch (e) {
      rethrow;
    }
  }

  // get Principles By Id
  Future<ApiResponse<Principle>> getPrinciplesById(int id) async {
    try {
      await _networkService.checkInternetConnection();
      return await _backendApiClient.getCompanyById(id);
    } on NetworkException catch (e) {
      throw e.message;
    } catch (e) {
      rethrow;
    }
  }

  // get principles name
  Future<ApiResponse<ListApiResponse<CompanyName>>> getPrinciplesByName() async {
    try {
      await _networkService.checkInternetConnection();
      final response = await _backendApiClient.getCompanyNames();
      return response;
    } on NetworkException catch (e) {
      throw e.message;
    } catch (e) {
      rethrow;
    }
  }
}
