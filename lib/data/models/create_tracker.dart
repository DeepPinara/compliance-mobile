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
  final String? clraAmendStartDate;
  final String? clraAmendEndDate;
  final String? formFiveStartDate;
  final String? formFiveEndDate;
  final int? clraAmendHeadCountNumber;
  final String? currentLicenceNumber;
  final String? ifpId;
  final String? ifpPassword;
  final List<dynamic>? files;

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
    return CreateTrackerRequest(
      vendorCode: json['vendorCode'] as String,
      clientName: json['clientName'] as String,
      principalId: json['principalID'] as int,
      applicationType: json['applicationType'] as TrackerApplicationType,
      noOfLabours: json['noOfLabours'] as int?,
      contactPerson: json['contactPerson'] as String,
      contactPersonEmail: json['contactPersonEmail'] as String,
      contactPersonPhone: json['contactPersonPhone'] as String,
      clraAmendStartDate: json['clra_amend_startDate'] as String?,
      clraAmendEndDate: json['clra_amend_endDate'] as String?,
      formFiveStartDate: json['form_five_startDate'] as String?,
      formFiveEndDate: json['form_five_endDate'] as String?,
      clraAmendHeadCountNumber: json['clra_amend_headCountNumber'] as int?,
      currentLicenceNumber: json['currentLicenceNumber'] as String?,
      ifpId: json['ifp_id'] as String?,
      ifpPassword: json['ifp_password'] as String?,
      files: json['files'] as List<dynamic>?,
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
      if (clraAmendStartDate != null) 'clra_amend_startDate': clraAmendStartDate,
      if (clraAmendEndDate != null) 'clra_amend_endDate': clraAmendEndDate,
      if (formFiveStartDate != null) 'form_five_startDate': formFiveStartDate,
      if (formFiveEndDate != null) 'form_five_endDate': formFiveEndDate,
      if (clraAmendHeadCountNumber != null) 'clra_amend_headCountNumber': clraAmendHeadCountNumber,
      if (currentLicenceNumber != null) 'currentLicenceNumber': currentLicenceNumber,
      if (ifpId != null) 'ifp_id': ifpId,
      if (ifpPassword != null) 'ifp_password': ifpPassword,
      if (files != null) 'files': files,
    };
  }

  // Alias for toJson for backward compatibility
  Map<String, dynamic> toBackendJson() => toJson();

  CreateTrackerRequest copyWith({
    String? vendorCode,
    String? clientName,
    int? principalId,
    TrackerApplicationType? applicationType,
    int? noOfLabours,
    String? contactPerson,
    String? contactPersonEmail,
    String? contactPersonPhone,
    String? clraAmendStartDate,
    String? clraAmendEndDate,
    String? formFiveStartDate,
    String? formFiveEndDate,
    int? clraAmendHeadCountNumber,
    String? currentLicenceNumber,
    String? ifpId,
    String? ifpPassword,
    List<dynamic>? files,
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
      clraAmendHeadCountNumber: clraAmendHeadCountNumber ?? this.clraAmendHeadCountNumber,
      currentLicenceNumber: currentLicenceNumber ?? this.currentLicenceNumber,
      ifpId: ifpId ?? this.ifpId,
      ifpPassword: ifpPassword ?? this.ifpPassword,
      files: files ?? this.files,
    );
  }
}
