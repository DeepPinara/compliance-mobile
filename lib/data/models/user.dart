import 'contractor.dart';

enum UserRole {
  admin,
  manager,
  teamLead,
  doer;

  String get value {
    switch (this) {
      case UserRole.admin:
        return 'admin';
      case UserRole.manager:
        return 'manager';
      case UserRole.teamLead:
        return 'team_lead';
      case UserRole.doer:
        return 'doer';
    }
  }
}

class CreateUserRequest {
  final String userName;
  final String email;
  final String password;
  final UserRole role;
  final Map<String, dynamic> modules;

  CreateUserRequest({
    required this.userName,
    required this.email,
    required this.password,
    required this.role,
    required this.modules,
  });

  factory CreateUserRequest.fromJson(Map<String, dynamic> json) {
    return CreateUserRequest(
      userName: json['userName'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      role: UserRole.values.firstWhere(
        (e) => e.value == json['role'],
        orElse: () => UserRole.doer,
      ),
      modules: json['modules'] as Map<String, dynamic>,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'email': email,
      'password': password,
      'role': role.value,
      'modules': modules,
    };
  }
}

class UpdateUserRequest {
  final String? userName;
  final String? email;
  final String? password;
  final UserRole? role;

  UpdateUserRequest({
    this.userName,
    this.email,
    this.password,
    this.role,
  });

  factory UpdateUserRequest.fromJson(Map<String, dynamic> json) {
    return UpdateUserRequest(
      userName: json['userName'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      role: json['role'] != null
          ? UserRole.values.firstWhere(
              (e) => e.value == json['role'],
              orElse: () => UserRole.doer,
            )
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (userName != null) 'userName': userName,
      if (email != null) 'email': email,
      if (password != null) 'password': password,
      if (role != null) 'role': role!.value,
    };
  }
}

class User {
  final int id;
  final String userName;
  final String email;
  final String role;
  final Map<String, List<String>> modules;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? lastActivity;
  final List<Contractor>? assignedContractor;

  User({
    required this.id,
    required this.userName,
    required this.email,
    required this.role,
    required this.modules,
    required this.createdAt,
    required this.updatedAt,
    this.lastActivity,
    this.assignedContractor,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      userName: json['userName'],
      email: json['email'],
      role: json['role'],
      modules: (json['modules'] as Map<String, dynamic>?)?.map((k, v) => MapEntry(k, List<String>.from(v ?? []))) ?? {},
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      lastActivity: json['lastActivity'] != null ? DateTime.tryParse(json['lastActivity']) : null,
      assignedContractor: json['assignedContractor'] == null
          ? null
          : (json['assignedContractor'] is List
              ? (json['assignedContractor'] as List)
                  .map((e) => Contractor.fromJson(e))
                  .toList()
              : null),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userName': userName,
      'email': email,
      'role': role,
      'modules': modules,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      if (lastActivity != null) 'lastActivity': lastActivity!.toIso8601String(),
      // if (assignedContractor != null) 'assignedContractor': assignedContractor!.map((e) => e.toJson()).toList(),
    };
  }
}
