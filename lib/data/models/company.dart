
import 'package:compliancenavigator/utils/enums.dart';

class CreateCompanyRequest {
  final String companyName;
  final String companyCode;
  final String plantCode;
  final String businessUnit;
  final String? clraRcNo;
  final String? clraRcDate;
  final String? ismwRcNo;
  final String? bocwRcNo;
  final String? establishmentPfCode;
  final String? factoryLicenseNum;
  final MinWageZone? minWageZone;
  final double? defaultBonus;
  final String? companyAddress;

  CreateCompanyRequest({
    required this.companyName,
    required this.companyCode,
    required this.plantCode,
    required this.businessUnit,
    this.clraRcNo,
    this.clraRcDate,
    this.ismwRcNo,
    this.bocwRcNo,
    this.establishmentPfCode,
    this.factoryLicenseNum,
    this.minWageZone,
    this.defaultBonus,
    this.companyAddress,
  });

  factory CreateCompanyRequest.fromJson(Map<String, dynamic> json) {
    return CreateCompanyRequest(
      companyName: json['company_name'] as String,
      companyCode: json['company_code'] as String,
      plantCode: json['plant_code'] as String,
      businessUnit: json['business_unit'] as String,
      clraRcNo: json['clra_rc_no'] as String?,
      clraRcDate: json['clra_rc_date'] as String?,
      ismwRcNo: json['ismw_rc_no'] as String?,
      bocwRcNo: json['bocw_rc_no'] as String?,
      establishmentPfCode: json['establishment_pf_code'] as String?,
      factoryLicenseNum: json['factory_license_num'] as String?,
      minWageZone: json['min_wage_zone'] != null
          ? MinWageZone.values.firstWhere(
              (e) => e.value == json['min_wage_zone'],
              orElse: () => MinWageZone.zone1)
          : null,
      defaultBonus: json['default_bonus'] as double?,
      companyAddress: json['company_address'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'company_name': companyName,
      'company_code': companyCode,
      'plant_code': plantCode,
      'business_unit': businessUnit,
      if (clraRcNo != null) 'clra_rc_no': clraRcNo,
      if (clraRcDate != null) 'clra_rc_date': clraRcDate,
      if (ismwRcNo != null) 'ismw_rc_no': ismwRcNo,
      if (bocwRcNo != null) 'bocw_rc_no': bocwRcNo,
      if (establishmentPfCode != null)
        'establishment_pf_code': establishmentPfCode,
      if (factoryLicenseNum != null)
        'factory_license_num': factoryLicenseNum,
      if (minWageZone != null) 'min_wage_zone': minWageZone!.value,
      if (defaultBonus != null) 'default_bonus': defaultBonus,
      if (companyAddress != null) 'company_address': companyAddress,
    };
  }
}

class UpdateCompanyRequest {
  final String? companyName;
  final String? companyAddress;
  final String? clraRcNo;
  final String? ismwRcNo;
  final String? bocwRcNo;
  final String? clraRcDate;
  final String? establishmentPfCode;
  final String? businessUnit;
  final String? factoryLicenseNum;
  final double? defaultBonus;
  final MinWageZone? minWageZone;

  UpdateCompanyRequest({
    this.companyName,
    this.companyAddress,
    this.clraRcNo,
    this.ismwRcNo,
    this.bocwRcNo,
    this.clraRcDate,
    this.establishmentPfCode,
    this.businessUnit,
    this.factoryLicenseNum,
    this.defaultBonus,
    this.minWageZone,
  });

  factory UpdateCompanyRequest.fromJson(Map<String, dynamic> json) {
    return UpdateCompanyRequest(
      companyName: json['company_name'] as String?,
      companyAddress: json['company_address'] as String?,
      clraRcNo: json['clra_rc_no'] as String?,
      ismwRcNo: json['ismw_rc_no'] as String?,
      bocwRcNo: json['bocw_rc_no'] as String?,
      clraRcDate: json['clra_rc_date'] as String?,
      establishmentPfCode: json['establishment_pf_code'] as String?,
      businessUnit: json['business_unit'] as String?,
      factoryLicenseNum: json['factory_license_num'] as String?,
      defaultBonus: json['default_bonus'] as double?,
      minWageZone: json['min_wage_zone'] != null
          ? MinWageZone.values.firstWhere(
              (e) => e.value == json['min_wage_zone'],
              orElse: () => MinWageZone.zone1)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (companyName != null) 'company_name': companyName,
      if (companyAddress != null) 'company_address': companyAddress,
      if (clraRcNo != null) 'clra_rc_no': clraRcNo,
      if (ismwRcNo != null) 'ismw_rc_no': ismwRcNo,
      if (bocwRcNo != null) 'bocw_rc_no': bocwRcNo,
      if (clraRcDate != null) 'clra_rc_date': clraRcDate,
      if (establishmentPfCode != null)
        'establishment_pf_code': establishmentPfCode,
      if (businessUnit != null) 'business_unit': businessUnit,
      if (factoryLicenseNum != null)
        'factory_license_num': factoryLicenseNum,
      if (defaultBonus != null) 'default_bonus': defaultBonus,
      if (minWageZone != null) 'min_wage_zone': minWageZone!.value,
    };
  }
} 