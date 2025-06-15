
class DashboardData {
  final int totalCompanies;
  final int totalContractors;
  final int totalWorkmen;
  final List<WcExpiringContractor> wcExpiringContractors;
  final List<dynamic> llExpiringContractors;
  final int maleRatio;
  final int femaleRatio;
  final int teamMembers;
  final int pendingCompliances;

  DashboardData({
    required this.totalCompanies,
    required this.totalContractors,
    required this.totalWorkmen,
    required this.wcExpiringContractors,
    required this.llExpiringContractors,
    required this.maleRatio,
    required this.femaleRatio,
    required this.teamMembers,
    required this.pendingCompliances,
  });

  factory DashboardData.fromBackend(Map<String, dynamic> json) {
    return DashboardData(
      totalCompanies: json['totalCompanies'] ?? 0,
      totalContractors: json['totalContractors'] ?? 0,
      totalWorkmen: json['totalWorkmen'] ?? 0,
      wcExpiringContractors: (json['wcExpiringContractors'] as List?)
              ?.map((e) => WcExpiringContractor.fromBackend(e))
              .toList() ??
          [],
      llExpiringContractors: json['llExpiringContractors'] ?? [],
      maleRatio: json['maleRatio'] ?? 0,
      femaleRatio: json['femaleRatio'] ?? 0,
      teamMembers: json['teamMembers'] ?? 0,
      pendingCompliances: json['pendingCompliances'] ?? 0,
    );
  }
}

class WcExpiringContractor {
  final int id;
  final int mainEmployeeCode;
  final int employeeCode;
  final String name;
  final DateTime wcValidTo;
  final String createdById;

  WcExpiringContractor({
    required this.id,
    required this.mainEmployeeCode,
    required this.employeeCode,
    required this.name,
    required this.wcValidTo,
    required this.createdById,
  });

  factory WcExpiringContractor.fromBackend(Map<String, dynamic> json) {
    return WcExpiringContractor(
      id: json['id'] ?? 0,
      mainEmployeeCode: json['main_employee_code'] ?? 0,
      employeeCode: json['employee_code'] ?? 0,
      name: json['name'] ?? '',
      wcValidTo: DateTime.parse(json['wc_valid_to'] ?? DateTime.now().toIso8601String()),
      createdById: json['createdById'] ?? '',
    );
  }
} 