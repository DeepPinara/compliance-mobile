class DashboardStats {
  final StatusSummary? statusSummary;
  final TimeMetrics? timeMetrics;
  final PrincipalMetrics? principalMetrics;
  final LaborMetrics? laborMetrics;
  final DocumentMetrics? documentMetrics;

  DashboardStats({
    this.statusSummary,
    this.timeMetrics,
    this.principalMetrics,
    this.laborMetrics,
    this.documentMetrics,
  });

  factory DashboardStats.fromJson(Map<String, dynamic> json) {
    try {
      return DashboardStats(
        statusSummary: json['statusSummary'] == null
            ? null
            : StatusSummary.fromJson(
                Map<String, dynamic>.from(json['statusSummary'])),
        timeMetrics: json['timeMetrics'] == null
            ? null
            : TimeMetrics.fromJson(
                Map<String, dynamic>.from(json['timeMetrics'])),
        principalMetrics: json['principalMetrics'] == null
            ? null
            : PrincipalMetrics.fromJson(
                Map<String, dynamic>.from(json['principalMetrics'])),
        laborMetrics: json['laborMetrics'] == null
            ? null
            : LaborMetrics.fromJson(
                Map<String, dynamic>.from(json['laborMetrics'])),
        documentMetrics: json['documentMetrics'] == null
            ? null
            : DocumentMetrics.fromJson(
                Map<String, dynamic>.from(json['documentMetrics'])),
      );
    } catch (e) {
      print('Error parsing DashboardStats: $e');
      rethrow;
    }
  }
}

class StatusSummary {
  final int? total;
  final Map<String, int>? byStatus;

  StatusSummary({this.total, this.byStatus});

  factory StatusSummary.fromJson(Map<String, dynamic> json) {
    try {
      return StatusSummary(
        total: json['total'] as int?,
        byStatus: json['byStatus'] == null
            ? null
            : Map<String, int>.from(
                (json['byStatus'] as Map).map((k, v) => 
                  MapEntry(k as String, (v as num).toInt()),
                ),
              ),
      );
    } catch (e) {
      print('Error parsing StatusSummary: $e');
      rethrow;
    }
  }
}

class TimeMetrics {
  final int? recentApplications;
  final int? last30Days;
  final List<PendingOverTime>? pendingOverTime;

  TimeMetrics({this.recentApplications, this.last30Days, this.pendingOverTime});

  factory TimeMetrics.fromJson(Map<String, dynamic> json) {
    try {
      return TimeMetrics(
        recentApplications: json['recentApplications'] as int?,
        last30Days: json['last30Days'] as int?,
        pendingOverTime: json['pendingOverTime'] == null
            ? null
            : List<PendingOverTime>.from(
                (json['pendingOverTime'] as List).map(
                  (x) => PendingOverTime.fromJson(Map<String, dynamic>.from(x as Map)),
                ),
              ),
      );
    } catch (e) {
      print('Error parsing TimeMetrics: $e');
      rethrow;
    }
  }
}

class PendingOverTime {
  final String? range;
  final int? count;

  PendingOverTime({this.range, this.count});

  factory PendingOverTime.fromJson(Map<String, dynamic> json) {
    try {
      return PendingOverTime(
        range: json['range'] as String?,
        count: json['count'] as int?,
      );
    } catch (e) {
      print('Error parsing PendingOverTime: $e');
      rethrow;
    }
  }
}

class PrincipalMetrics {
  final List<Principal>? topPrincipals;
  final int? totalPrincipals;

  PrincipalMetrics({this.topPrincipals, this.totalPrincipals});

  factory PrincipalMetrics.fromJson(Map<String, dynamic> json) {
    try {
      return PrincipalMetrics(
        topPrincipals: json['topPrincipals'] == null
            ? null
            : List<Principal>.from(
                (json['topPrincipals'] as List).map(
                  (x) => Principal.fromJson(Map<String, dynamic>.from(x as Map)),
                ),
              ),
        totalPrincipals: json['totalPrincipals'] as int?,
      );
    } catch (e) {
      print('Error parsing PrincipalMetrics: $e');
      rethrow;
    }
  }
}

class Principal {
  final String? principalName;
  final String? applicationCount;

  Principal({this.principalName, this.applicationCount});

  factory Principal.fromJson(Map<String, dynamic> json) {
    try {
      return Principal(
        principalName: json['principalName'] as String?,
        applicationCount: json['applicationCount'] as String?,
      );
    } catch (e) {
      print('Error parsing Principal: $e');
      rethrow;
    }
  }
}

class LaborMetrics {
  final int? totalLabor;
  final String? avgLaborPerApp;
  final int? totalApplications;

  LaborMetrics({this.totalLabor, this.avgLaborPerApp, this.totalApplications});

  factory LaborMetrics.fromJson(Map<String, dynamic> json) {
    try {
      return LaborMetrics(
        totalLabor: json['totalLabor'] as int?,
        avgLaborPerApp: json['avgLaborPerApp'] as String?,
        totalApplications: json['totalApplications'] as int?,
      );
    } catch (e) {
      print('Error parsing LaborMetrics: $e');
      rethrow;
    }
  }
}

class DocumentMetrics {
  final int? pendingVerification;
  final int? verifiedLast30Days;

  DocumentMetrics({this.pendingVerification, this.verifiedLast30Days});

  factory DocumentMetrics.fromJson(Map<String, dynamic> json) {
    try {
      return DocumentMetrics(
        pendingVerification: json['pendingVerification'] as int?,
        verifiedLast30Days: json['verifiedLast30Days'] as int?,
      );
    } catch (e) {
      print('Error parsing DocumentMetrics: $e');
      rethrow;
    }
  }
}
