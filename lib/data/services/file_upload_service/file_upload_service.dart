import 'package:compliancenavigator/data/clients/network/backend/exceptions/network_exception.dart';
import 'package:compliancenavigator/data/models/api_response.dart';
import 'package:compliancenavigator/data/models/file_upload_response.dart';
import 'package:compliancenavigator/data/services/backend/backend_api_service.dart';
import 'package:compliancenavigator/utils/file_utils/file_picker.dart';

/// A service for handling file and image uploads
class FileUploadService {
  final BackendApiCallService _backendApiClient;

  FileUploadService({
    BackendApiCallService? backendApiClient,
  }) : _backendApiClient = backendApiClient ?? BackendApiCallService();

  /// Upload a file to the server
  /// Returns the URL of the uploaded file
  Future<String> uploadTrackerFileAdmin({
    required PickedFile file,
    String? fileName,
  }) async {
    try {
      final String actualFileName = fileName ??
          file.name ??
          'file_${DateTime.now().millisecondsSinceEpoch}';

      // Get presigned URL
      final ApiResponse<FileUploadResponse> presignedUrl =
          await _backendApiClient.uploadTrackerFileAdmin(
        actualFileName,
      );

      // Upload file to presigned URL using BackendApiCallService
      final bool uploadSuccess =
          await _backendApiClient.uploadFileWithPresignedUrl(
        presignedUrl.data.uploadedUrl,
        file,
        actualFileName,
      );

      if (!uploadSuccess) {
        throw NetworkException(
          message: 'Failed to upload file',
          code: 'upload_failed',
          statusCode: 500,
        );
      }
      return presignedUrl.data!.key;
    } catch (e) {
      throw NetworkException(
        message: 'Failed to upload file',
        code: 'upload_failed',
        statusCode: 500,
      );
    }
  }
}
