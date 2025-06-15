class ZoneMaster {
  final int? id;
  final String zone;
  final String skill;
  final double minWage;
  final double minDa;
  final double overtimeRate;

  ZoneMaster({
    this.id,
    required this.zone,
    required this.skill,
    required this.minWage,
    required this.minDa,
    required this.overtimeRate,
  });

  factory ZoneMaster.fromJson(Map<String, dynamic> json) {
    return ZoneMaster(
      id: json['id'] as int?,
      zone: json['zone'] as String,
      skill: json['skill'] as String,
      minWage: (json['min_wage'] as num?)?.toDouble() ?? 0.0,
      minDa: (json['min_da'] as num?)?.toDouble() ?? 0.0,
      overtimeRate: (json['overtime_rate'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'zone': zone,
      'skill': skill,
      'min_wage': minWage,
      'min_da': minDa,
      'overtime_rate': overtimeRate,
    };
  }

  ZoneMaster copyWith({
    int? id,
    String? zone,
    String? skill,
    double? minWage,
    double? minDa,
    double? overtimeRate,
  }) {
    return ZoneMaster(
      id: id ?? this.id,
      zone: zone ?? this.zone,
      skill: skill ?? this.skill,
      minWage: minWage ?? this.minWage,
      minDa: minDa ?? this.minDa,
      overtimeRate: overtimeRate ?? this.overtimeRate,
    );
  }
}
