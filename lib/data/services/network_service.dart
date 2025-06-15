import 'package:compliancenavigator/data/clients/network/backend/error_handling/network_error_constants.dart';
import 'package:compliancenavigator/data/clients/network/backend/exceptions/network_exception.dart';
import 'package:compliancenavigator/data/clients/network/network_info.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkService {
  final NetworkInfo networkInfo;

  NetworkService({required this.networkInfo}) {
    // initialize();
  }

  Future<bool> get isConnected => networkInfo.isConnected;

  Stream<ConnectivityResult> get onConnectivityChanged =>
      networkInfo.onConnectivityChanged;

  Future<void> initialize() => networkInfo.initialize();

  Future<void> checkInternetConnection() async {
    if (!await networkInfo.isConnected) {
      // Exception with message "No Internet Connection"
      throw NetworkException.fromNetworkException(
        NetworkException(
          code: NetworkErrorCode.noInternet,
          message: NetworkErrorMessage.noInternet,
        ),
      );
    }
  }
}
