
class Principle {
  final int id;
  final String companyName;
  final String companyAddress;
  final String companyCode;
  final String plantCode;
  final String businessUnit;
  final String clraRcNo;
  final String? clraRcDate;
  final String ismwRcNo;
  final String bocwRcNo;
  final String establishmentPfCode;
  final String factoryLicenseNum;
  final String minWageZone;
  final int? defaultBonus;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;

  const Principle({
    required this.id,
    required this.companyName,
    required this.companyAddress,
    required this.companyCode,
    required this.plantCode,
    required this.businessUnit,
    required this.clraRcNo,
    this.clraRcDate,
    required this.ismwRcNo,
    required this.bocwRcNo,
    required this.establishmentPfCode,
    required this.factoryLicenseNum,
    required this.minWageZone,
    this.defaultBonus,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory Principle.fromJson(Map<String, dynamic> json) {
    return Principle(
      id: json['id'] as int,
      companyName: json['company_name'] as String,
      companyAddress: json['company_address'] as String,
      companyCode: json['company_code'] as String,
      plantCode: json['plant_code'] as String,
      businessUnit: json['business_unit'] as String,
      clraRcNo: json['clra_rc_no'] as String,
      clraRcDate: json['clra_rc_date'] as String?,
      ismwRcNo: json['ismw_rc_no'] as String,
      bocwRcNo: json['bocw_rc_no'] as String,
      establishmentPfCode: json['establishment_pf_code'] as String,
      factoryLicenseNum: json['factory_license_num'] as String,
      minWageZone: json['min_wage_zone'] as String,
      defaultBonus: json['default_bonus'] as int?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
      deletedAt: json['deleted_at'] != null
          ? DateTime.parse(json['deleted_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'company_name': companyName,
      'company_address': companyAddress,
      'company_code': companyCode,
      'plant_code': plantCode,
      'business_unit': businessUnit,
      'clra_rc_no': clraRcNo,
      'clra_rc_date': clraRcDate,
      'ismw_rc_no': ismwRcNo,
      'bocw_rc_no': bocwRcNo,
      'establishment_pf_code': establishmentPfCode,
      'factory_license_num': factoryLicenseNum,
      'min_wage_zone': minWageZone,
      'default_bonus': defaultBonus,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'deleted_at': deletedAt?.toIso8601String(),
    };
  }
}
