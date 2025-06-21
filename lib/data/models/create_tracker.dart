import 'package:compliancenavigator/data/models/tracker_file.dart';
import 'package:compliancenavigator/utils/enums.dart';

class CreateTrackerResponse {
  final String id;
  final String message;

  CreateTrackerResponse({
    required this.id,
    required this.message,
  });

  factory CreateTrackerResponse.fromJson(Map<String, dynamic> json) {
    return CreateTrackerResponse(
      id: json['data'] as String,
      message: json['message'] as String,
    );
  }

  @override
  String toString() => 'CreateTrackerResponse(id: $id, message: $message)';
}

class CreateTrackerRequest {
  final String vendorCode;
  final String clientName;
  final int principalId;
  final TrackerApplicationType applicationType;
  final int? noOfLabours;
  final String contactPerson;
  final String contactPersonEmail;
  final String contactPersonPhone;
  final DateTime? clraAmendStartDate;
  final DateTime? clraAmendEndDate;
  final DateTime? formFiveStartDate;
  final DateTime? formFiveEndDate;
  final int? clraAmendHeadCountNumber;
  final String? currentLicenceNumber;
  final String? ifpId;
  final String? ifpPassword;
  final List<TrackerFile>? files;

  CreateTrackerRequest({
    required this.vendorCode,
    required this.clientName,
    required this.principalId,
    required this.applicationType,
    this.noOfLabours,
    required this.contactPerson,
    required this.contactPersonEmail,
    required this.contactPersonPhone,
    this.clraAmendStartDate,
    this.clraAmendEndDate,
    this.formFiveStartDate,
    this.formFiveEndDate,
    this.clraAmendHeadCountNumber,
    this.currentLicenceNumber,
    this.ifpId,
    this.ifpPassword,
    this.files,
  });

  factory CreateTrackerRequest.fromJson(Map<String, dynamic> json) {
    // Helper function to parse date strings into DateTime
    DateTime? parseDate(dynamic dateValue) {
      if (dateValue == null) return null;
      if (dateValue is DateTime) return dateValue;
      if (dateValue is String) return DateTime.tryParse(dateValue);
      return null;
    }

    // Parse files if they exist
    List<TrackerFile>? parseFiles(dynamic filesData) {
      if (filesData == null) return null;
      if (filesData is List) {
        return filesData
            .whereType<Map<String, dynamic>>()
            .map((fileJson) => TrackerFile(
                  fileFieldName: TrackerFilesType.values.firstWhere(
                    (e) => e.toString().split('.').last == fileJson['fileFieldName'],
                    orElse: () => TrackerFilesType.form5,
                  ),
                  fileKey: fileJson['fileKey'] as String,
                ))
            .toList();
      }
      return null;
    }

    return CreateTrackerRequest(
      vendorCode: json['vendorCode'] as String,
      clientName: json['clientName'] as String,
      principalId: json['principalID'] as int,
      applicationType: TrackerApplicationType.values.firstWhere(
        (e) => e.toString().split('.').last == json['applicationType'],
        orElse: () => TrackerApplicationType.bocw,
      ),
      noOfLabours: json['noOfLabours'] as int?,
      contactPerson: json['contactPerson'] as String,
      contactPersonEmail: json['contactPersonEmail'] as String,
      contactPersonPhone: json['contactPersonPhone'] as String,
      clraAmendStartDate: parseDate(json['clra_amend_startDate']),
      clraAmendEndDate: parseDate(json['clra_amend_endDate']),
      formFiveStartDate: parseDate(json['form_five_startDate']),
      formFiveEndDate: parseDate(json['form_five_endDate']),
      clraAmendHeadCountNumber: json['clra_amend_headCountNumber'] as int?,
      currentLicenceNumber: json['currentLicenceNumber'] as String?,
      ifpId: json['ifp_id'] as String?,
      ifpPassword: json['ifp_password'] as String?,
      files: parseFiles(json['files']),
    );
  }

  // Convert to JSON for API request
  Map<String, dynamic> toJson() {
    return {
      'vendorCode': vendorCode,
      'clientName': clientName,
      'principalID': principalId,
      'applicationType': applicationType.name,
      if (noOfLabours != null) 'noOfLabours': noOfLabours,
      'contactPerson': contactPerson,
      'contactPersonEmail': contactPersonEmail,
      'contactPersonPhone': contactPersonPhone,
      if (clraAmendStartDate != null)
        'clra_amend_startDate': clraAmendStartDate,
      if (clraAmendEndDate != null) 'clra_amend_endDate': clraAmendEndDate,
      if (formFiveStartDate != null) 'form_five_startDate': formFiveStartDate,
      if (formFiveEndDate != null) 'form_five_endDate': formFiveEndDate,
      if (clraAmendHeadCountNumber != null)
        'clra_amend_headCountNumber': clraAmendHeadCountNumber,
      if (currentLicenceNumber != null)
        'currentLicenceNumber': currentLicenceNumber,
      if (ifpId != null) 'ifp_id': ifpId,
      if (ifpPassword != null) 'ifp_password': ifpPassword,
      if (files != null) 'files': files?.map((e) => e.toJson()).toList(),
    };
  }

  // Alias for toJson for backward compatibility
  Map<String, dynamic> toBackendJson() {
    // Helper function to format DateTime to ISO 8601 string
    String formatDate(DateTime? date) => date?.toIso8601String() ?? '';

    return {
      'vendorCode': vendorCode,
      'clientName': clientName,
      'principalID': principalId,
      'applicationType': applicationType.toString().split('.').last,
      if (noOfLabours != null) 'noOfLabours': noOfLabours,
      'contactPerson': contactPerson,
      'contactPersonEmail': contactPersonEmail,
      'contactPersonPhone': contactPersonPhone,
      if (clraAmendStartDate != null)
        'clra_amend_startDate': formatDate(clraAmendStartDate!),
      if (clraAmendEndDate != null)
        'clra_amend_endDate': formatDate(clraAmendEndDate!),
      if (formFiveStartDate != null)
        'form_five_startDate': formatDate(formFiveStartDate!),
      if (formFiveEndDate != null)
        'form_five_endDate': formatDate(formFiveEndDate!),
      if (clraAmendHeadCountNumber != null)
        'clra_amend_headCountNumber': clraAmendHeadCountNumber,
      if (currentLicenceNumber != null)
        'currentLicenceNumber': currentLicenceNumber,
      if (ifpId != null) 'ifp_id': ifpId,
      if (ifpPassword != null) 'ifp_password': ifpPassword,
      if (files != null && files!.isNotEmpty)
        'files': files!.map((file) => file.toJson()).toList(),
    };
  }

  CreateTrackerRequest copyWith({
    String? vendorCode,
    String? clientName,
    int? principalId,
    TrackerApplicationType? applicationType,
    int? noOfLabours,
    String? contactPerson,
    String? contactPersonEmail,
    String? contactPersonPhone,
    DateTime? clraAmendStartDate,
    DateTime? clraAmendEndDate,
    DateTime? formFiveStartDate,
    DateTime? formFiveEndDate,
    int? clraAmendHeadCountNumber,
    String? currentLicenceNumber,
    String? ifpId,
    String? ifpPassword,
    List<TrackerFile>? files,
  }) {
    return CreateTrackerRequest(
      vendorCode: vendorCode ?? this.vendorCode,
      clientName: clientName ?? this.clientName,
      principalId: principalId ?? this.principalId,
      applicationType: applicationType ?? this.applicationType,
      noOfLabours: noOfLabours ?? this.noOfLabours,
      contactPerson: contactPerson ?? this.contactPerson,
      contactPersonEmail: contactPersonEmail ?? this.contactPersonEmail,
      contactPersonPhone: contactPersonPhone ?? this.contactPersonPhone,
      clraAmendStartDate: clraAmendStartDate ?? this.clraAmendStartDate,
      clraAmendEndDate: clraAmendEndDate ?? this.clraAmendEndDate,
      formFiveStartDate: formFiveStartDate ?? this.formFiveStartDate,
      formFiveEndDate: formFiveEndDate ?? this.formFiveEndDate,
      clraAmendHeadCountNumber:
          clraAmendHeadCountNumber ?? this.clraAmendHeadCountNumber,
      currentLicenceNumber: currentLicenceNumber ?? this.currentLicenceNumber,
      ifpId: ifpId ?? this.ifpId,
      ifpPassword: ifpPassword ?? this.ifpPassword,
      files: files ?? this.files,
    );
  }
}
