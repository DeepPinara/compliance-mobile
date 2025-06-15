class BugReport {
  final String title;
  final String description;
  final String module;

  BugReport({
    required this.title,
    required this.description,
    required this.module,
  });

  factory BugReport.fromJson(Map<String, dynamic> json) {
    return BugReport(
      title: json['title'] as String,
      description: json['description'] as String,
      module: json['module'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'module': module,
    };
  }
} 