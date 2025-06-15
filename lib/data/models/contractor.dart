class CreateContractorRequest {
  final int companyMasterId;
  final int mainEmployeeCode;
  final int employeeCode;
  final String name;
  final String ownerName;
  final String managerName;
  final String address;
  final int totalManpower;
  final String wcPolicyNo;
  final String wcValidFrom;
  final String wcValidTo;
  final String wcCoverage;
  final String ownerMobileNumber;
  final String ownerPanCard;
  final String ownerEmailId;
  final String? labourLicenceNo;
  final String? labourLicenceNoValidFrom;
  final String? labourLicenceNoTo;
  final String? labourLicenceCoverage;
  final String? ismwLicenceNo;
  final String? ismwLicenceNoValidFrom;
  final String? ismwLicenceNoTo;
  final String? ismwLicenceNoCoverage;
  final String? bocwRegdNo;
  final String? bocwRegdNoValidFrom;
  final String? bocwRegdNoTo;
  final String? bocwRegdNoCoverage;
  final String? pfNumber;
  final String? pfApplyDate;
  final String natureOfWork;
  final String? emailIdSiteIncharge;
  final String? mobileNumberSiteIncharge;
  final String? contractorPan;
  final String? gstNumber;
  final String? establishmentNo;
  final String? lwfRegistrationNo;
  final String? professionalTaxNo;
  final String? createdById;
  final double? defaultBonus;

  CreateContractorRequest({
    required this.companyMasterId,
    required this.mainEmployeeCode,
    required this.employeeCode,
    required this.name,
    required this.ownerName,
    required this.managerName,
    required this.address,
    required this.totalManpower,
    required this.wcPolicyNo,
    required this.wcValidFrom,
    required this.wcValidTo,
    required this.wcCoverage,
    required this.ownerMobileNumber,
    required this.ownerPanCard,
    required this.ownerEmailId,
    required this.natureOfWork,
    this.labourLicenceNo,
    this.labourLicenceNoValidFrom,
    this.labourLicenceNoTo,
    this.labourLicenceCoverage,
    this.ismwLicenceNo,
    this.ismwLicenceNoValidFrom,
    this.ismwLicenceNoTo,
    this.ismwLicenceNoCoverage,
    this.bocwRegdNo,
    this.bocwRegdNoValidFrom,
    this.bocwRegdNoTo,
    this.bocwRegdNoCoverage,
    this.pfNumber,
    this.pfApplyDate,
    this.emailIdSiteIncharge,
    this.mobileNumberSiteIncharge,
    this.contractorPan,
    this.gstNumber,
    this.establishmentNo,
    this.lwfRegistrationNo,
    this.professionalTaxNo,
    this.createdById,
    this.defaultBonus,
  });

  factory CreateContractorRequest.fromJson(Map<String, dynamic> json) {
    return CreateContractorRequest(
      companyMasterId: json['company_master_id'] as int,
      mainEmployeeCode: json['main_employee_code'] as int,
      employeeCode: json['employee_code'] as int,
      name: json['name'] as String,
      ownerName: json['owner_name'] as String,
      managerName: json['manager_name'] as String,
      address: json['address'] as String,
      totalManpower: json['total_manpower'] as int,
      wcPolicyNo: json['wc_policy_no'] as String,
      wcValidFrom: json['wc_valid_from'] as String,
      wcValidTo: json['wc_valid_to'] as String,
      wcCoverage: json['wc_coverage'] as String,
      ownerMobileNumber: json['owner_mobile_number'] as String,
      ownerPanCard: json['owner_pan_card'] as String,
      ownerEmailId: json['owner_email_id'] as String,
      natureOfWork: json['nature_of_work'] as String,
      labourLicenceNo: json['labour_licence_no'] as String?,
      labourLicenceNoValidFrom: json['labour_licence_no_valid_from'] as String?,
      labourLicenceNoTo: json['labour_licence_no_to'] as String?,
      labourLicenceCoverage: json['labour_licence_coverage'] as String?,
      ismwLicenceNo: json['ismw_licence_no'] as String?,
      ismwLicenceNoValidFrom: json['ismw_licence_no_valid_from'] as String?,
      ismwLicenceNoTo: json['lismw_licence_no_to'] as String?,
      ismwLicenceNoCoverage: json['ismw_licence_no_coverage'] as String?,
      bocwRegdNo: json['bocw_regd_no'] as String?,
      bocwRegdNoValidFrom: json['bocw_regd_no_valid_from'] as String?,
      bocwRegdNoTo: json['bocw_regd_no_to'] as String?,
      bocwRegdNoCoverage: json['bocw_regd_no_coverage'] as String?,
      pfNumber: json['pf_number'] as String?,
      pfApplyDate: json['pf_apply_date'] as String?,
      emailIdSiteIncharge: json['email_id_site_incharge'] as String?,
      mobileNumberSiteIncharge: json['mobile_number_site_incharge'] as String?,
      contractorPan: json['contractor_pan'] as String?,
      gstNumber: json['gst_number'] as String?,
      establishmentNo: json['establishment_no'] as String?,
      lwfRegistrationNo: json['lwf_registration_no'] as String?,
      professionalTaxNo: json['professional_tax_no'] as String?,
      createdById: json['createdById'] as String?,
      defaultBonus: json['default_bonus'] as double?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'company_master_id': companyMasterId,
      'main_employee_code': mainEmployeeCode,
      'employee_code': employeeCode,
      'name': name,
      'owner_name': ownerName,
      'manager_name': managerName,
      'address': address,
      'total_manpower': totalManpower,
      'wc_policy_no': wcPolicyNo,
      'wc_valid_from': wcValidFrom,
      'wc_valid_to': wcValidTo,
      'wc_coverage': wcCoverage,
      'owner_mobile_number': ownerMobileNumber,
      'owner_pan_card': ownerPanCard,
      'owner_email_id': ownerEmailId,
      'nature_of_work': natureOfWork,
      if (labourLicenceNo != null) 'labour_licence_no': labourLicenceNo,
      if (labourLicenceNoValidFrom != null)
        'labour_licence_no_valid_from': labourLicenceNoValidFrom,
      if (labourLicenceNoTo != null)
        'labour_licence_no_to': labourLicenceNoTo,
      if (labourLicenceCoverage != null)
        'labour_licence_coverage': labourLicenceCoverage,
      if (ismwLicenceNo != null) 'ismw_licence_no': ismwLicenceNo,
      if (ismwLicenceNoValidFrom != null)
        'ismw_licence_no_valid_from': ismwLicenceNoValidFrom,
      if (ismwLicenceNoTo != null)
        'lismw_licence_no_to': ismwLicenceNoTo,
      if (ismwLicenceNoCoverage != null)
        'ismw_licence_no_coverage': ismwLicenceNoCoverage,
      if (bocwRegdNo != null) 'bocw_regd_no': bocwRegdNo,
      if (bocwRegdNoValidFrom != null)
        'bocw_regd_no_valid_from': bocwRegdNoValidFrom,
      if (bocwRegdNoTo != null) 'bocw_regd_no_to': bocwRegdNoTo,
      if (bocwRegdNoCoverage != null)
        'bocw_regd_no_coverage': bocwRegdNoCoverage,
      if (pfNumber != null) 'pf_number': pfNumber,
      if (pfApplyDate != null) 'pf_apply_date': pfApplyDate,
      if (emailIdSiteIncharge != null)
        'email_id_site_incharge': emailIdSiteIncharge,
      if (mobileNumberSiteIncharge != null)
        'mobile_number_site_incharge': mobileNumberSiteIncharge,
      if (contractorPan != null) 'contractor_pan': contractorPan,
      if (gstNumber != null) 'gst_number': gstNumber,
      if (establishmentNo != null) 'establishment_no': establishmentNo,
      if (lwfRegistrationNo != null)
        'lwf_registration_no': lwfRegistrationNo,
      if (professionalTaxNo != null)
        'professional_tax_no': professionalTaxNo,
      if (createdById != null) 'createdById': createdById,
      if (defaultBonus != null) 'default_bonus': defaultBonus,
    };
  }
}

class UpdateContractorRequest {
  final int companyMasterId;
  final String? name;
  final String? ownerName;
  final String? managerName;
  final String? address;
  final int? totalManpower;
  final String? wcPolicyNo;
  final String? wcValidFrom;
  final String? wcValidTo;
  final String? wcCoverage;
  final String? labourLicenceNo;
  final String? labourLicenceNoValidFrom;
  final String? labourLicenceNoTo;
  final String? labourLicenceCoverage;
  final String? ismwLicenceNo;
  final String? ismwLicenceNoValidFrom;
  final String? ismwLicenceNoTo;
  final String? ismwLicenceNoCoverage;
  final String? bocwRegdNo;
  final String? bocwRegdNoValidFrom;
  final String? bocwRegdNoTo;
  final String? bocwRegdNoCoverage;
  final String? natureOfWork;
  final String? pfNumber;
  final String? pfApplyDate;
  final String? emailIdSiteIncharge;
  final String? ownerEmailId;
  final String? mobileNumberSiteIncharge;
  final String? ownerMobileNumber;
  final String? ownerPanCard;
  final String? contractorPan;
  final String? gstNumber;
  final String? establishmentNo;
  final String? lwfRegistrationNo;
  final String? professionalTaxNo;
  final String? createdById;
  final double? defaultBonus;

  UpdateContractorRequest({
    required this.companyMasterId,
    this.name,
    this.ownerName,
    this.managerName,
    this.address,
    this.totalManpower,
    this.wcPolicyNo,
    this.wcValidFrom,
    this.wcValidTo,
    this.wcCoverage,
    this.labourLicenceNo,
    this.labourLicenceNoValidFrom,
    this.labourLicenceNoTo,
    this.labourLicenceCoverage,
    this.ismwLicenceNo,
    this.ismwLicenceNoValidFrom,
    this.ismwLicenceNoTo,
    this.ismwLicenceNoCoverage,
    this.bocwRegdNo,
    this.bocwRegdNoValidFrom,
    this.bocwRegdNoTo,
    this.bocwRegdNoCoverage,
    this.natureOfWork,
    this.pfNumber,
    this.pfApplyDate,
    this.emailIdSiteIncharge,
    this.ownerEmailId,
    this.mobileNumberSiteIncharge,
    this.ownerMobileNumber,
    this.ownerPanCard,
    this.contractorPan,
    this.gstNumber,
    this.establishmentNo,
    this.lwfRegistrationNo,
    this.professionalTaxNo,
    this.createdById,
    this.defaultBonus,
  });

  factory UpdateContractorRequest.fromJson(Map<String, dynamic> json) {
    return UpdateContractorRequest(
      companyMasterId: json['company_master_id'] as int,
      name: json['name'] as String?,
      ownerName: json['owner_name'] as String?,
      managerName: json['manager_name'] as String?,
      address: json['address'] as String?,
      totalManpower: json['total_manpower'] as int?,
      wcPolicyNo: json['wc_policy_no'] as String?,
      wcValidFrom: json['wc_valid_from'] as String?,
      wcValidTo: json['wc_valid_to'] as String?,
      wcCoverage: json['wc_coverage'] as String?,
      labourLicenceNo: json['labour_licence_no'] as String?,
      labourLicenceNoValidFrom: json['labour_licence_no_valid_from'] as String?,
      labourLicenceNoTo: json['labour_licence_no_to'] as String?,
      labourLicenceCoverage: json['labour_licence_coverage'] as String?,
      ismwLicenceNo: json['ismw_licence_no'] as String?,
      ismwLicenceNoValidFrom: json['ismw_licence_no_valid_from'] as String?,
      ismwLicenceNoTo: json['lismw_licence_no_to'] as String?,
      ismwLicenceNoCoverage: json['ismw_licence_no_coverage'] as String?,
      bocwRegdNo: json['bocw_regd_no'] as String?,
      bocwRegdNoValidFrom: json['bocw_regd_no_valid_from'] as String?,
      bocwRegdNoTo: json['bocw_regd_no_to'] as String?,
      bocwRegdNoCoverage: json['bocw_regd_no_coverage'] as String?,
      natureOfWork: json['nature_of_work'] as String?,
      pfNumber: json['pf_number'] as String?,
      pfApplyDate: json['pf_apply_date'] as String?,
      emailIdSiteIncharge: json['email_id_site_incharge'] as String?,
      ownerEmailId: json['owner_email_id'] as String?,
      mobileNumberSiteIncharge: json['mobile_number_site_incharge'] as String?,
      ownerMobileNumber: json['owner_mobile_number'] as String?,
      ownerPanCard: json['owner_pan_card'] as String?,
      contractorPan: json['contractor_pan'] as String?,
      gstNumber: json['gst_number'] as String?,
      establishmentNo: json['establishment_no'] as String?,
      lwfRegistrationNo: json['lwf_registration_no'] as String?,
      professionalTaxNo: json['professional_tax_no'] as String?,
      createdById: json['createdById'] as String?,
      defaultBonus: json['default_bonus'] as double?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'company_master_id': companyMasterId,
      if (name != null) 'name': name,
      if (ownerName != null) 'owner_name': ownerName,
      if (managerName != null) 'manager_name': managerName,
      if (address != null) 'address': address,
      if (totalManpower != null) 'total_manpower': totalManpower,
      if (wcPolicyNo != null) 'wc_policy_no': wcPolicyNo,
      if (wcValidFrom != null) 'wc_valid_from': wcValidFrom,
      if (wcValidTo != null) 'wc_valid_to': wcValidTo,
      if (wcCoverage != null) 'wc_coverage': wcCoverage,
      if (labourLicenceNo != null) 'labour_licence_no': labourLicenceNo,
      if (labourLicenceNoValidFrom != null)
        'labour_licence_no_valid_from': labourLicenceNoValidFrom,
      if (labourLicenceNoTo != null)
        'labour_licence_no_to': labourLicenceNoTo,
      if (labourLicenceCoverage != null)
        'labour_licence_coverage': labourLicenceCoverage,
      if (ismwLicenceNo != null) 'ismw_licence_no': ismwLicenceNo,
      if (ismwLicenceNoValidFrom != null)
        'ismw_licence_no_valid_from': ismwLicenceNoValidFrom,
      if (ismwLicenceNoTo != null)
        'lismw_licence_no_to': ismwLicenceNoTo,
      if (ismwLicenceNoCoverage != null)
        'ismw_licence_no_coverage': ismwLicenceNoCoverage,
      if (bocwRegdNo != null) 'bocw_regd_no': bocwRegdNo,
      if (bocwRegdNoValidFrom != null)
        'bocw_regd_no_valid_from': bocwRegdNoValidFrom,
      if (bocwRegdNoTo != null) 'bocw_regd_no_to': bocwRegdNoTo,
      if (bocwRegdNoCoverage != null)
        'bocw_regd_no_coverage': bocwRegdNoCoverage,
      if (natureOfWork != null) 'nature_of_work': natureOfWork,
      if (pfNumber != null) 'pf_number': pfNumber,
      if (pfApplyDate != null) 'pf_apply_date': pfApplyDate,
      if (emailIdSiteIncharge != null)
        'email_id_site_incharge': emailIdSiteIncharge,
      if (ownerEmailId != null) 'owner_email_id': ownerEmailId,
      if (mobileNumberSiteIncharge != null)
        'mobile_number_site_incharge': mobileNumberSiteIncharge,
      if (ownerMobileNumber != null)
        'owner_mobile_number': ownerMobileNumber,
      if (ownerPanCard != null) 'owner_pan_card': ownerPanCard,
      if (contractorPan != null) 'contractor_pan': contractorPan,
      if (gstNumber != null) 'gst_number': gstNumber,
      if (establishmentNo != null) 'establishment_no': establishmentNo,
      if (lwfRegistrationNo != null)
        'lwf_registration_no': lwfRegistrationNo,
      if (professionalTaxNo != null)
        'professional_tax_no': professionalTaxNo,
      if (createdById != null) 'createdById': createdById,
      if (defaultBonus != null) 'default_bonus': defaultBonus,
    };
  }
}

class Contractor {
  final int id;
  final int employeeCode;
  final int mainEmployeeCode;
  final String name;

  Contractor({
    required this.id,
    required this.employeeCode,
    required this.mainEmployeeCode,
    required this.name,
  });

  factory Contractor.fromJson(Map<String, dynamic> json) {
    return Contractor(
      id: json['id'],
      employeeCode: json['employee_code'],
      mainEmployeeCode: json['main_employee_code'],
      name: json['name'],
    );
  }
} 