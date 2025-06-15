import 'package:compliancenavigator/data/clients/network/api_service_base.dart';
import 'package:compliancenavigator/data/clients/network/backend/api_service.dart';
import 'package:compliancenavigator/data/clients/network/network_info.dart';
import 'package:compliancenavigator/data/clients/storage/get_storage.dart';
import 'package:compliancenavigator/data/clients/storage/storage_provider.dart';
import 'package:compliancenavigator/data/services/backend/backend_api_service.dart';
import 'package:compliancenavigator/data/services/navigation_service/navigation_import.dart';
import 'package:compliancenavigator/data/services/network_service.dart';
import 'package:compliancenavigator/data/services/storage_service.dart';
import 'package:compliancenavigator/modules/auth/auth_repository.dart';
import 'package:compliancenavigator/modules/dashboard/dashboard_repository.dart';
import 'package:compliancenavigator/modules/principle/principle_repository.dart';
import 'package:compliancenavigator/modules/tracker/tracker_repository.dart';
import 'package:compliancenavigator/modules/user/user_repository.dart';
import 'package:get/get.dart';

class DependencyInjection {
  static void init() {
    // Core dependencies
    Get.lazyPut<NetworkInfo>(
      () => NetworkInfoImpl(),
      fenix: true,
    );

    Get.lazyPut<NetworkService>(
      () => NetworkService(networkInfo: Get.find<NetworkInfo>()),
      fenix: true,
    );

    Get.lazyPut<StorageProvider>(
      () => GetxStorage(),
      fenix: true,
    );

    // Register StorageService
    Get.lazyPut<StorageService>(
      () => StorageService(Get.find<StorageProvider>()),
      fenix: true,
    );

    // NavigationService
    Get.lazyPut<NavigationService>(
      () => NavigationService(
        networkService: Get.find<NetworkService>(),
        enableLogging: true,
      ),
      fenix: true,
    );

    // You need to register ApiService
    Get.lazyPut<ApiClientBase>(
      () => ApiDioClient(), // Or however you initialize ApiService
      fenix: true,
    );

    // BackendApiCallService
    Get.lazyPut<BackendApiCallService>(
      () => BackendApiCallService(apiService: Get.find<ApiClientBase>()),
      fenix: true,
    );
    // Services
    Get.lazyPut<BackendApiCallService>(
      () => BackendApiCallService(),
      fenix: true,
    );

    // Domain layer dependencies

    // auth Repository
    Get.lazyPut<AuthRepository>(
      () => AuthRepository(
        backendApiClient: Get.find<BackendApiCallService>(),
        networkService: Get.find<NetworkService>(),
        storageProvider: Get.find<StorageService>(),
      ),
      fenix: true,
    );

    //UserRepository
    Get.lazyPut<UserRepository>(
      () => UserRepository(
        backendApiClient: Get.find<BackendApiCallService>(),
        storageService: Get.find<StorageService>(),
        networkService: Get.find<NetworkService>(),
      ),
      fenix: true,
    );

    // dashboard Repository
    Get.lazyPut<DashboardRepository>(
      () => DashboardRepository(
        backendApiClient: Get.find<BackendApiCallService>(),
        networkService: Get.find<NetworkService>(),
      ),
      fenix: true,
    );

    //PrincipleRepository
    Get.lazyPut<PrincipleRepository>(
      () => PrincipleRepository(
        backendApiClient: Get.find<BackendApiCallService>(),
        networkService: Get.find<NetworkService>(),
      ),
      fenix: true,
    );

    //TrackerRepository
    Get.lazyPut<TrackerRepository>(
      () => TrackerRepository(
        backendApiClient: Get.find<BackendApiCallService>(),
        networkService: Get.find<NetworkService>(),
      ),
      fenix: true,
    );
  }
}
