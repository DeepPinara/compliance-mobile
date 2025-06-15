class CompanyName {
  final int id;
  final String name;
  final String companyCode;

  CompanyName({
    required this.id,
    required this.name,
    required this.companyCode,
  });

  factory CompanyName.fromJson(Map<String, dynamic> json) {
    return CompanyName(
      id: json['id'] as int,
      name: json['name'] as String,
      companyCode: json['companyCode'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'companyCode': companyCode,
    };
  }
}
