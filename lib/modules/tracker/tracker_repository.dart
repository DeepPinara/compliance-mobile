import 'dart:developer';

import 'package:compliancenavigator/data/clients/network/backend/exceptions/network_exception.dart';
import 'package:compliancenavigator/data/models/create_tracker.dart';
import 'package:compliancenavigator/data/services/backend/backend_api_service.dart';
import 'package:compliancenavigator/data/services/network_service.dart';

class TrackerRepository {
  final BackendApiCallService _backendApiClient;
  final NetworkService _networkService;

  TrackerRepository({
    required BackendApiCallService backendApiClient,
    required NetworkService networkService,
  })  : _backendApiClient = backendApiClient,
        _networkService = networkService;

  Future<CreateTrackerResponse> createTrackerApplication(
    CreateTrackerRequest createTrackerRequest,
  ) async {
    try {
      await _networkService.checkInternetConnection();
      final response = await _backendApiClient
          .createTrackerApplication(createTrackerRequest);
      return response;
    } on NetworkException catch (e) {
      throw e.message;
    } catch (e) {
      throw 'Failed to create tracker application: $e';
    }
  }

  // fetchTrackerdocforvalidation
  Future<void> fetchTrackerdocforvalidation({
    required int page,
    required int limit,
    String? search,
  }) async {
    try {
      await _networkService.checkInternetConnection();
      final response = await _backendApiClient.getTrackerDocToBeVerified(
        page: page,
        limit: limit,
        search: search,
      );
      log(response.toString());
      // return response;
    } on NetworkException catch (e) {
      throw e.message;
    } catch (e) {
      throw 'Failed to fetch trackerdocforvalidation: $e';
    }
  }
}

class Tracker {}
