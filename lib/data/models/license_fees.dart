// CalculateLicenseFeesStruct



// FeesStruct

class LicenseFees {
  final int minWorkers;
  final int maxWorkers;
  final double fee;
  final double? additionalFeePerWorker;
  final int? maxAdditionalWorkers;

  const LicenseFees({
    required this.minWorkers,
    required this.maxWorkers,
    required this.fee,
    this.additionalFeePerWorker,
    this.maxAdditionalWorkers,
  });

  factory LicenseFees.fromJson(Map<String, dynamic> json) => LicenseFees(
        minWorkers: json['min'] as int,
        maxWorkers: json['max'] as int,
        fee: (json['fee'] as num).toDouble(),
        additionalFeePerWorker: json['additional_fee_per_worker']?.toDouble(),
        maxAdditionalWorkers: json['max_additional_workers'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'min': minWorkers,
        'max': maxWorkers,
        'fee': fee,
        if (additionalFeePerWorker != null) 'additional_fee_per_worker': additionalFeePerWorker,
        if (maxAdditionalWorkers != null) 'max_additional_workers': maxAdditionalWorkers,
      };

  bool isInRange(int workerCount) =>
      workerCount >= minWorkers && workerCount <= maxWorkers;
}