import 'package:compliancenavigator/data/clients/network/backend/exceptions/network_exception.dart';
import 'package:compliancenavigator/data/models/dashboard_data.dart';
import 'package:compliancenavigator/data/services/backend/backend_api_service.dart';
import 'package:compliancenavigator/data/services/network_service.dart';

class DashboardRepository {
  final BackendApiCallService _backendApiClient;
  final NetworkService _networkService;

  DashboardRepository({
    required BackendApiCallService backendApiClient,
    required NetworkService networkService,
  })  : _backendApiClient = backendApiClient,
        _networkService = networkService;

  Future<DashboardData> dashboardData() async {
    try {
      await _networkService.checkInternetConnection();
      final response = await _backendApiClient.dashboardData();

      // The response.data is already non-nullable, so we can directly return it
      return response.data;
    } on NetworkException catch (e) {
      throw e.message;
    } catch (e) {
      rethrow;
    }
  }
}
