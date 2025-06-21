class FileUploadResponse {
  final String apiUrl;
  final String key;
  final String location;
  final String getUrl;

  FileUploadResponse({
    required this.apiUrl,
    required this.key,
    required this.location,
    required this.getUrl,
  });

  factory FileUploadResponse.fromJson(Map<String, dynamic> json) {
    return FileUploadResponse(
      apiUrl: json['apiUrl'],
      key: json['key'],
      location: json['location'],
      getUrl: json['getUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'apiUrl': apiUrl,
      'key': key,
      'location': location,
      'getUrl': getUrl,
    };
  }

  String get uploadedUrl => apiUrl;
}