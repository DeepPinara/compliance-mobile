import 'package:compliancenavigator/utils/enums.dart';

class TrackerFile {
  final TrackerFilesType fileFieldName;
  final String fileKey;
  final int? id;
  final int? trackerId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;

  const TrackerFile({
    required this.fileFieldName,
    required this.fileKey,
    this.id,
    this.trackerId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory TrackerFile.fromJson(Map<String, dynamic> json) {
    return TrackerFile(
      fileFieldName: TrackerFilesType.values.firstWhere(
        (e) => e.name == json['fileFieldName'],
        orElse: () => TrackerFilesType.form5,
      ),
      fileKey: json['fileKey'] as String,
      id: json['id'] as int?,
      trackerId: json['trackerId'] as int?,
      createdAt: json['createdAt'] != null ? DateTime.tryParse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.tryParse(json['updatedAt']) : null,
      deletedAt: json['deletedAt'] != null ? DateTime.tryParse(json['deletedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fileFieldName': fileFieldName.name,
      'fileKey': fileKey,
      if (id != null) 'id': id,
      if (trackerId != null) 'trackerId': trackerId,
      if (createdAt != null) 'createdAt': createdAt!.toIso8601String(),
      if (updatedAt != null) 'updatedAt': updatedAt!.toIso8601String(),
      if (deletedAt != null) 'deletedAt': deletedAt!.toIso8601String(),
    };
  }
}
