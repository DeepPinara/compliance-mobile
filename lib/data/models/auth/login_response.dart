class LoginResponse {
  final String accToken;
  final String refreshToken;

  LoginResponse({
    required this.accToken,
    required this.refreshToken,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      accToken: json['accToken'] as String,
      refreshToken: json['refreshToken'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accToken': accToken,
      'refreshToken': refreshToken,
    };
  }
} 