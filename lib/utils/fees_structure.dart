
import 'package:compliancenavigator/data/models/license_fees.dart';
import 'package:compliancenavigator/utils/enums.dart';

class FeesStructure {
  // BOCW Fee Tiers
  static const List<LicenseFees> bocwFeeTiers = [
    LicenseFees(minWorkers: 1, maxWorkers: 50, fee: 250.0),
    LicenseFees(minWorkers: 51, maxWorkers: 100, fee: 1000.0),
    LicenseFees(minWorkers: 101, maxWorkers: 300, fee: 2000.0),
    LicenseFees(minWorkers: 301, maxWorkers: 500, fee: 4000.0),
    LicenseFees(minWorkers: 501, maxWorkers: 999999, fee: 5000.0),
  ];

  // CLRA Fee Tiers
  static const List<LicenseFees> clraFeeTiers = [
    LicenseFees(minWorkers: 1, maxWorkers: 50, fee: 0.0),
    LicenseFees(minWorkers: 51, maxWorkers: 100, fee: 450.0),
    LicenseFees(minWorkers: 101, maxWorkers: 200, fee: 900.0),
    LicenseFees(minWorkers: 201, maxWorkers: 400, fee: 1800.0),
    LicenseFees(minWorkers: 401, maxWorkers: 800, fee: 2250.0),
    LicenseFees(minWorkers: 801, maxWorkers: 999999, fee: 3600.0),
  ];

  // Service fee per person for BOCW
  static const double serviceFeeBOCW = 200.0;

  // Service fee per person for CLRA
  static const double serviceFeePerCLRA = 100.0;

  // Challan fee per person (if applicable)
  static const double challanFeePerPerson = 10.0;

  // Whether to include challan fee in total
  static const bool includeChallanFee = true;

  // Calculate fees based on application type and manpower count
  final double licenseFee;
  final double serviceFee;
  final double challanFee;
  final double totalFee;

  // Calculate fees based on application type and manpower count
  FeesStructure.calculate({
    required TrackerApplicationType applicationType,
    required int manpowerCount,
  })  : licenseFee = _getFeeFromTiers(
            manpowerCount,
            applicationType == TrackerApplicationType.bocw
                ? bocwFeeTiers
                : clraFeeTiers,
          ),
        serviceFee = applicationType == TrackerApplicationType.bocw
            ? serviceFeeBOCW * manpowerCount
            : serviceFeePerCLRA * manpowerCount,
        challanFee = includeChallanFee
            ? challanFeePerPerson * manpowerCount
            : 0.0,
        totalFee = (applicationType == TrackerApplicationType.bocw
                    ? serviceFeeBOCW * manpowerCount
                    : serviceFeePerCLRA * manpowerCount) +
                _getFeeFromTiers(
                  manpowerCount,
                  applicationType == TrackerApplicationType.bocw
                      ? bocwFeeTiers
                      : clraFeeTiers,
                ) +
                (includeChallanFee ? challanFeePerPerson * manpowerCount : 0.0);

  // Helper method to get fee from tiers
  static double _getFeeFromTiers(int workerCount, List<LicenseFees> tiers) {
    try {
      final tier = tiers.firstWhere((tier) => tier.isInRange(workerCount));
      return tier.fee;
    } catch (e) {
      throw Exception('No fee tier found for $workerCount workers');
    }
  }

  // Factory constructor for JSON deserialization
  factory FeesStructure.fromJson(Map<String, dynamic> json) {
    return FeesStructure.calculate(
      applicationType: TrackerApplicationType.values.firstWhere(
        (e) => e.toString() == 'TrackerApplicationType.${json['applicationType']}',
      ),
      manpowerCount: json['manpowerCount'] as int,
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'licenseFee': licenseFee,
      'serviceFee': serviceFee,
      'challanFee': challanFee,
      'totalFee': totalFee,
    };
  }

  // Calculate total fees for a given application type and manpower count
  static double calculateTotalFees({
    required TrackerApplicationType applicationType,
    required int manpowerCount,
  }) {
    final fees = FeesStructure.calculate(
      applicationType: applicationType,
      manpowerCount: manpowerCount,
    );
    return fees.totalFee;
  }

  // Get a breakdown of all fees
  Map<String, double> getFeeBreakdown() {
    return {
      'licenseFee': licenseFee,
      'serviceFee': serviceFee,
      'challanFee': challanFee,
      'totalFee': totalFee,
    };
  }
}