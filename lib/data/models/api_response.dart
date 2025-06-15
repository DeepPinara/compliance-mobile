class ApiResponse<T> {
  final T data;
  final String? message;
  final bool success;
  final int? statusCode;

  ApiResponse({
    required this.data,
    this.message,
    this.success = true,
    this.statusCode,
  });

  factory ApiResponse.fromJson(
      Map<String, dynamic> json, T Function(dynamic json) fromJson) {
    return ApiResponse(
      data: fromJson(json['data']),
      message: json['message'] as String?,
      success: json['success'] as bool? ?? true,
      statusCode: json['statusCode'] as int?,
    );
  }

  Map<String, dynamic> toJson(Map<String, dynamic> Function(T data) toJson) {
    return {
      'data': toJson(data),
      if (message != null) 'message': message,
      'success': success,
      if (statusCode != null) 'statusCode': statusCode,
    };
  }
} 