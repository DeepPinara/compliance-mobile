class FileUpload {
  final String fileName;
  final String folder;
  final int contractorId;
  final String year;
  final String month;
  final String? key;

  FileUpload({
    required this.fileName,
    required this.folder,
    required this.contractorId,
    required this.year,
    required this.month,
    this.key,
  });

  factory FileUpload.fromJson(Map<String, dynamic> json) {
    return FileUpload(
      fileName: json['fileName'] as String,
      folder: json['folder'] as String,
      contractorId: json['contractorId'] as int,
      year: json['year'] as String,
      month: json['month'] as String,
      key: json['key'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fileName': fileName,
      'folder': folder,
      'contractorId': contractorId,
      'year': year,
      'month': month,
      'key': key,
    };
  }

  FileUpload copyWith({
    String? fileName,
    String? folder,
    int? contractorId,
    String? year,
    String? month,
    String? key,
  }) {
    return FileUpload(
      fileName: fileName ?? this.fileName,
      folder: folder ?? this.folder,
      contractorId: contractorId ?? this.contractorId,
      year: year ?? this.year,
      month: month ?? this.month,
      key: key ?? this.key,
    );
  }
}
