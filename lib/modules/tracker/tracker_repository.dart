import 'package:compliancenavigator/data/clients/network/backend/exceptions/network_exception.dart';
import 'package:compliancenavigator/data/models/create_tracker.dart';
import 'package:compliancenavigator/data/models/list_api_response.dart';
import 'package:compliancenavigator/data/models/tracker_application.dart';
import 'package:compliancenavigator/data/services/backend/backend_api_service.dart';
import 'package:compliancenavigator/data/services/network_service.dart';
import 'package:compliancenavigator/data/services/file_upload_service/file_upload_service.dart';
import 'package:compliancenavigator/utils/enums.dart';
import 'package:compliancenavigator/utils/file_utils/file_picker.dart';

class TrackerRepository {
  final BackendApiCallService _backendApiClient;
  final NetworkService _networkService;
  final FileUploadService _fileUploadService;

  TrackerRepository({
    required BackendApiCallService backendApiClient,
    required NetworkService networkService,
    required FileUploadService fileUploadService,
  })  : _backendApiClient = backendApiClient,
        _networkService = networkService,
        _fileUploadService = fileUploadService;

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
  Future<ListApiResponse<TrackerApplication>> fetchTrackerdocforvalidation({
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

      // The response is an ApiResponse containing ListApiResponse
      return response.data;
    } on NetworkException catch (e) {
      throw e.message;
    } catch (e) {
      throw 'Failed to fetch trackerdocforvalidation: $e';
    }
  }

  // updateDocToBeVerified
  Future<Map<String, dynamic>> updateDocToBeVerified({
    required int id,
    required TrackerApplicationStatus applicationStatus,
    required String remark,
  }) async {
    try {
      await _networkService.checkInternetConnection();
      final response = await _backendApiClient.updateDocToBeVerified(
        id: id,
        applicationStatus: applicationStatus,
        remark: remark,
      );
      return response.data;
    } on NetworkException catch (e) {
      throw e.message;
    } catch (e) {
      throw 'Failed to update doc to be verified: $e';
    }
  }

  // Upload files
  Future<String> uploadFiles(PickedFile file) async {
    try {
      await _networkService.checkInternetConnection();
      final response = await _fileUploadService.uploadTrackerFileAdmin(
        file: file,
        fileName: file.name,
      );
      return response;
    } on NetworkException catch (e) {
      throw e.message;
    } catch (e) {
      throw 'Failed to upload files: $e';
    }
  }

  // updateTracker
  Future<Map<String, dynamic>> updateTracker(TrackerApplication tracker) async {
    try {
      await _networkService.checkInternetConnection();
      final response = await _backendApiClient.updateTracker(tracker);
      return response.data;
    } on NetworkException catch (e) {
      throw e.message;
    } catch (e) {
      throw 'Failed to update tracker: $e';
    }
  }

  // Get Tracker for Admin
  Future<ListApiResponse<TrackerApplication>> fetchTrackerForAdmin({
    required int page,
    required int limit,
    String? search,
  }) async {
    try {
      await _networkService.checkInternetConnection();
      final response = await _backendApiClient.getTrackers(
        page: page,
        limit: limit,
        search: search,
      );

      // The response is an ApiResponse containing ListApiResponse
      return response.data;
    } on NetworkException catch (e) {
      throw e.message;
    } catch (e) {
      throw 'Failed to fetch trackerdocforvalidation: $e';
    }
  }
}
