import 'dart:async';

import 'package:compliancenavigator/data/clients/network/backend/exceptions/network_exception.dart';
import 'package:compliancenavigator/data/services/backend/backend_api_service.dart';
import 'package:compliancenavigator/data/services/network_service.dart';
import 'package:compliancenavigator/data/services/storage_service.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class LogsRepository extends GetxController {
  final BackendApiCallService _backendApiClient;
  final NetworkService _networkService;
  final StorageService _storageService;

  LogsRepository({
    required BackendApiCallService backendApiClient,
    required NetworkService networkService,
    required StorageService storageService,
  })  : _backendApiClient = backendApiClient,
        _networkService = networkService,
        _storageService = storageService;

  Timer? _timer;

  @override
  void onClose() {
    super.onClose();
    _timer?.cancel();
  }



  // Start logs After every 2 minutes
  void startLogs() {
    _timer = Timer.periodic(const Duration(minutes: 2), (timer) {
      createLog();
    });
  }

  /// Login email and password
  Future<void> createLog() async {
    try {
      await _networkService.checkInternetConnection();
      final bool isTokenAvailable = _storageService.isTokenAvailable();
      if (isTokenAvailable) {
        await _backendApiClient.createLog();
      }
    } on NetworkException catch (e) {
      throw e.message;
    } catch (e) {
      rethrow;
    }
  }
}
