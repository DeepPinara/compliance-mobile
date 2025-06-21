enum LoadingState {
  initial,
  loading,
  loaded,
  error,
}

enum AuthStatus {
  signedOut,
  signedIn,
  loading,
}

enum ThemeMode {
  light,
  dark,
  system,
}

enum MinWageZone {
  zone1,
  zone2,
  zone3,
  central;

  String get value {
    switch (this) {
      case MinWageZone.zone1:
        return 'Zone 1';
      case MinWageZone.zone2:
        return 'Zone 2';
      case MinWageZone.zone3:
        return 'Zone 3';
      case MinWageZone.central:
        return 'Central';
    }
  }
}

enum Selectmodule {
  compliance,
  tracker,
}

enum TrackerApplicationType {
  bocw,
  clraNew,
  clraRenewal,
  clraAmendment,
}

// extension TrackerApplicationTypeExtension
extension TrackerApplicationTypeExtension on TrackerApplicationType {
  String get displayName {
    switch (this) {
      case TrackerApplicationType.bocw:
        return 'BOCW';
      case TrackerApplicationType.clraNew:
        return 'CLRA New';
      case TrackerApplicationType.clraRenewal:
        return 'CLRA Renewal';
      case TrackerApplicationType.clraAmendment:
        return 'CLRA Amendment';
    }
  }

  // toBackend
//   CLRA_SURRENDER = "clra_surrender",
  String toBackend() {
    switch (this) {
      case TrackerApplicationType.bocw:
        return 'bocw';
      case TrackerApplicationType.clraNew:
        return 'clra_new';
      case TrackerApplicationType.clraRenewal:
        return 'clra_ren';
      case TrackerApplicationType.clraAmendment:
        return 'clra_amend';
    }
  }
}

enum TrackerFilesType {
  form5,
  workOrder,
  securityDepositeChalan,
  oldLicenceNumber,
  gstCertificate,
  authorityLetterDulySigned,
  ownerAadharCard,
  authorizePersonAadharCard,
  paymentProof,
  approvedApplication,
}

extension TrackerFilesTypeExtension on TrackerFilesType {
  String get displayName {
    switch (this) {
      case TrackerFilesType.form5:
        return 'Form 5';
      case TrackerFilesType.workOrder:
        return 'Work Order';
      case TrackerFilesType.securityDepositeChalan:
        return 'Security Deposit Chalan';
      case TrackerFilesType.oldLicenceNumber:
        return 'Old Licence Number';
      case TrackerFilesType.gstCertificate:
        return 'GST Certificate';
      case TrackerFilesType.authorityLetterDulySigned:
        return 'Authority Letter Duly Signed';
      case TrackerFilesType.ownerAadharCard:
        return 'Owner Aadhar Card';
      case TrackerFilesType.authorizePersonAadharCard:
        return 'Authorize Person Aadhar Card';
      case TrackerFilesType.paymentProof:
        return 'Payment Proof';
      case TrackerFilesType.approvedApplication:
        return 'Approved Application';
    }
  }
}


enum TrackerApplicationStatus {
  contractorDocPending,
  contractorDocPendingReview,
  contractorDocRequested,
  pending,
  approved,
  paymentPending,
  paymentReceived,
}

extension TrackerApplicationStatusExtension on TrackerApplicationStatus {
  String get displayName {
    switch (this) {
      case TrackerApplicationStatus.contractorDocPending:
        return 'Contractor Doc Pending';
      case TrackerApplicationStatus.contractorDocPendingReview:
        return 'Contractor Doc Pending Review';
      case TrackerApplicationStatus.contractorDocRequested:
        return 'Contractor Doc Requested';
      case TrackerApplicationStatus.pending:
        return 'Pending';
      case TrackerApplicationStatus.approved:
        return 'Approved';
      case TrackerApplicationStatus.paymentPending:
        return 'Payment Pending';
      case TrackerApplicationStatus.paymentReceived:
        return 'Payment Received';
    }
  }

  String toBackend() {
    switch (this) {
      case TrackerApplicationStatus.contractorDocPending:
        return 'contractor_doc_pending';
      case TrackerApplicationStatus.contractorDocPendingReview:
        return 'contractor_doc_pending_review';
      case TrackerApplicationStatus.contractorDocRequested:
        return 'contractor_doc_requested';
      case TrackerApplicationStatus.pending:
        return 'pending';
      case TrackerApplicationStatus.approved:
        return 'approved';
      case TrackerApplicationStatus.paymentPending:
        return 'payment_pending';
      case TrackerApplicationStatus.paymentReceived:
        return 'payment_received';
    }
  }
}
