import 'package:compliancenavigator/utils/enums.dart';
import 'package:compliancenavigator/data/models/tracker_file.dart';

class TrackerApplication {
  final int id;
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
  final String? ifpId;
  final String? ifpPassword;
  final String? currentLicenceNumber;
  final String? lastLicenceNumber;
  final bool paymentReceived;
  final String? applicationNum;
  final DateTime? applicationDate;
  final TrackerApplicationStatus applicationStatus;
  final String creatorId;
  final List<TrackerFile> files;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  const TrackerApplication({
    required this.id,
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
    this.ifpId,
    this.ifpPassword,
    this.currentLicenceNumber,
    this.lastLicenceNumber,
    required this.paymentReceived,
    this.applicationNum,
    this.applicationDate,
    required this.applicationStatus,
    required this.creatorId,
    required this.files,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory TrackerApplication.fromJson(Map<String, dynamic> json) {
    return TrackerApplication(
      id: json['id'] as int,
      vendorCode: json['vendorCode'] as String,
      clientName: json['clientName'] as String,
      principalId: json['principalID'] as int,
      applicationType: TrackerApplicationType.values.firstWhere(
        (e) => e.toBackend() == json['applicationType'],
        orElse: () => TrackerApplicationType.bocw,
      ),
      noOfLabours: json['noOfLabours'] as int?,
      contactPerson: json['contactPerson'] as String,
      contactPersonEmail: json['contactPersonEmail'] as String,
      contactPersonPhone: json['contactPersonPhone'] as String,
      clraAmendStartDate: json['clra_amend_startDate'] != null ? DateTime.parse(json['clra_amend_startDate']) : null,
      clraAmendEndDate: json['clra_amend_endDate'] != null ? DateTime.parse(json['clra_amend_endDate']) : null,
      formFiveStartDate: json['form_five_startDate'] != null ? DateTime.parse(json['form_five_startDate']) : null,
      formFiveEndDate: json['form_five_endDate'] != null ? DateTime.parse(json['form_five_endDate']) : null,
      clraAmendHeadCountNumber: json['clra_amend_headCountNumber'] as int?,
      ifpId: json['ifp_id'] as String?,
      ifpPassword: json['ifp_password'] as String?,
      currentLicenceNumber: json['currentLicenceNumber'] as String?,
      lastLicenceNumber: json['lastLicenceNumber'] as String?,
      paymentReceived: json['paymentReceived'] as bool? ?? false,
      applicationNum: json['applicationNum'] as String?,
      applicationDate: json['applicationDate'] != null ? DateTime.parse(json['applicationDate']) : null,
      applicationStatus: TrackerApplicationStatus.values.firstWhere(
        (e) => e.toBackend() == json['applicationStatus'],
        orElse: () => TrackerApplicationStatus.pending,
      ),
      creatorId: json['creatorId'] as String,
      files: (json['files'] as List<dynamic>?)
              ?.map((file) => TrackerFile.fromJson(file as Map<String, dynamic>))
              .toList() ??
          [],
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null
          ? DateTime.tryParse(json['deletedAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'vendorCode': vendorCode,
      'clientName': clientName,
      'principalID': principalId,
      'applicationType': applicationType.toBackend(),
      if (noOfLabours != null) 'noOfLabours': noOfLabours,
      'contactPerson': contactPerson,
      'contactPersonEmail': contactPersonEmail,
      'contactPersonPhone': contactPersonPhone,
      if (clraAmendStartDate != null)
        'clra_amend_startDate': clraAmendStartDate?.toIso8601String(),
      if (clraAmendEndDate != null)
        'clra_amend_endDate': clraAmendEndDate?.toIso8601String(),
      if (formFiveStartDate != null)
        'form_five_startDate': formFiveStartDate?.toIso8601String(),
      if (formFiveEndDate != null)
        'form_five_endDate': formFiveEndDate?.toIso8601String(),
      if (clraAmendHeadCountNumber != null)
        'clra_amend_headCountNumber': clraAmendHeadCountNumber,
      if (ifpId != null) 'ifp_id': ifpId,
      if (ifpPassword != null) 'ifp_password': ifpPassword,
      if (currentLicenceNumber != null)
        'currentLicenceNumber': currentLicenceNumber,
      if (lastLicenceNumber != null) 'lastLicenceNumber': lastLicenceNumber,
      'paymentReceived': paymentReceived,
      if (applicationNum != null) 'applicationNum': applicationNum,
      if (applicationDate != null)
        'applicationDate': applicationDate?.toIso8601String(),
      'applicationStatus': applicationStatus.toBackend(),
      'creatorId': creatorId,
      'files': files.map((file) => file.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      if (deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
    };
  }
}
