import 'package:compliancenavigator/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../data/models/principle.dart';
import 'principledetail_controller.dart';
import 'package:compliancenavigator/widgets/shimmer.dart';

const String kPrincipledetailRoute = '/principledetail';

class PrincipledetailScreen extends GetView<PrincipledetailController> {
  const PrincipledetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DLAppBar(
        title: 'Principle Detail',
        showBackButton: true,
      ),
      body: GetBuilder<PrincipledetailController>(
        id: PrincipledetailController.principledetailScreenId,
        builder: (controller) {
          if (controller.isLoading || controller.principle == null) {
            return const PrincipleDetailShimmer();
          }

          final principle = controller.principle!;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Main Card
                Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white,
                          Colors.blue.shade50.withOpacity(0.3),
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header Section
                          _buildHeaderSection(context, principle),
                          const SizedBox(height: 16),

                          // Company Details Section
                          _buildCompanyDetailsSection(context, principle),
                          const SizedBox(height: 16),

                          // // Address Section
                          // _buildAddressSection(context, principle),
                          // const SizedBox(height: 16),

                          // // Compliance Section
                          // _buildComplianceSection(context, principle),
                        ],
                      ),
                    ),
                  ),
                ),

                // Address Section
                _buildSectionTitle('Address', icon: Icons.location_on),
                _buildDetailCard(
                  context,
                  children: 
                  [
                    _buildDetailRow(
                      context,
                      'Address',
                      controller.principle!.companyAddress,
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Compliance Details Section
                _buildSectionTitle('Compliance Details',
                    icon: Icons.verified_user),
                _buildDetailCard(
                  context,
                  children: [
                    if (controller.principle!.clraRcNo.isNotEmpty)
                      _buildDetailRow(
                        context,
                        'CLRA RC No',
                        controller.principle!.clraRcNo,
                      ),
                    if (controller.principle!.clraRcDate != null)
                      _buildDetailRow(
                        context,
                        'CLRA RC Date',
                        controller.principle!.clraRcDate!,
                      ),
                    if (controller.principle!.ismwRcNo.isNotEmpty)
                      _buildDetailRow(
                        context,
                        'ISMW RC No',
                        controller.principle!.ismwRcNo,
                      ),
                    if (controller.principle!.bocwRcNo.isNotEmpty)
                      _buildDetailRow(
                        context,
                        'BOCW RC No',
                        controller.principle!.bocwRcNo,
                      ),
                    if (controller.principle!.establishmentPfCode.isNotEmpty)
                      _buildDetailRow(
                        context,
                        'Establishment PF Code',
                        controller.principle!.establishmentPfCode,
                      ),
                    if (controller.principle!.factoryLicenseNum.isNotEmpty)
                      _buildDetailRow(
                        context,
                        'Factory License No',
                        controller.principle!.factoryLicenseNum,
                      ),
                    if (controller.principle!.minWageZone.isNotEmpty)
                      _buildDetailRow(
                        context,
                        'Min Wage Zone',
                        controller.principle!.minWageZone,
                      ),
                    if (controller.principle!.defaultBonus != null)
                      _buildDetailRow(
                        context,
                        'Default Bonus',
                        controller.principle!.defaultBonus.toString(),
                      ),
                  ],
                ),
               
                const SizedBox(height: 24),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeaderSection(BuildContext context, Principle principle) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Get.theme.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            Icons.business,
            color: Get.theme.primaryColor,
            size: 24,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                principle.companyName,
                style: Get.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Get.theme.primaryColor,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              if (principle.companyCode.isNotEmpty) ...[
                const SizedBox(height: 4),
                Text(
                  'Code: ${principle.companyCode}',
                  style: Get.textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCompanyDetailsSection(
      BuildContext context, Principle principle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Company Details'),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _buildDetailRow(
                context,
                'Business Unit',
                principle.businessUnit,
                icon: Icons.business_center,
              ),
            ),
            Expanded(
              child: _buildDetailRow(
                context,
                'Plant Code',
                principle.plantCode,
                icon: Icons.location_city,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAddressSection(BuildContext context, Principle principle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Address'),
        const SizedBox(height: 8),
        _buildDetailRow(
          context,
          'Address',
          principle.companyAddress,
          icon: Icons.location_on,
        ),
      ],
    );
  }

  Widget _buildComplianceSection(BuildContext context, Principle principle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Compliance Details'),
        const SizedBox(height: 8),
        if (principle.clraRcNo.isNotEmpty)
          _buildDetailRow(
            context,
            'CLRA RC No',
            principle.clraRcNo,
            icon: Icons.assignment,
          ),
        if (principle.ismwRcNo.isNotEmpty)
          _buildDetailRow(
            context,
            'ISMW RC No',
            principle.ismwRcNo,
            icon: Icons.assignment_ind,
          ),
        if (principle.bocwRcNo.isNotEmpty)
          _buildDetailRow(
            context,
            'BOCW RC No',
            principle.bocwRcNo,
            icon: Icons.work,
          ),
        if (principle.establishmentPfCode.isNotEmpty)
          _buildDetailRow(
            context,
            'Establishment PF Code',
            principle.establishmentPfCode,
            icon: Icons.account_balance,
          ),
      ],
    );
  }

  Widget _buildSectionTitle(String title, {IconData? icon}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, size: 20, color: Get.theme.primaryColor),
            const SizedBox(width: 8),
          ],
          Text(
            title,
            style: Get.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailCard(
    BuildContext context, {
    required List<Widget> children,
  }) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200, width: 1),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal:0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context,
    String label,
    String? value, {
    IconData? icon,
  }) {
    if (value == null || value.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 20, color: Get.theme.primaryColor),
            const SizedBox(width: 12),
          ] else
            const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Get.textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: Get.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[800],
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(BuildContext context, String status) {
    Color backgroundColor;
    Color textColor;

    switch (status.toLowerCase()) {
      case 'compliant':
        backgroundColor = Colors.green.shade100;
        textColor = Colors.green.shade800;
        break;
      case 'non-compliant':
        backgroundColor = Colors.red.shade100;
        textColor = Colors.red.shade800;
        break;
      case 'in-progress':
        backgroundColor = Colors.orange.shade100;
        textColor = Colors.orange.shade800;
        break;
      default:
        backgroundColor = Colors.grey.shade200;
        textColor = Colors.grey.shade800;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        status.toUpperCase(),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: textColor,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
      ),
    );
  }
}

class PrincipleDetailShimmer extends DLShimmerWidget {
  const PrincipleDetailShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Shimmer
          buildShimmerBox(height: 120, width: double.infinity),
          const SizedBox(height: 24),

          // Section Title Shimmer
          buildShimmerBox(height: 24, width: 150),
          const SizedBox(height: 8),

          // Detail Card Shimmer
          buildShimmerBox(height: 120, width: double.infinity),
          const SizedBox(height: 24),

          // Section Title Shimmer
          buildShimmerBox(height: 24, width: 150),
          const SizedBox(height: 8),

          // Detail Card Shimmer
          buildShimmerBox(height: 120, width: double.infinity),
          const SizedBox(height: 24),

          // Section Title Shimmer
          buildShimmerBox(height: 24, width: 150),
          const SizedBox(height: 8),

          // Section Title Shimmer
          buildShimmerBox(height: 24, width: 100),
          const SizedBox(height: 8),

          // Detail Card Shimmer with multiple lines
          ...List.generate(
            4,
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: buildShimmerBox(height: 20, width: double.infinity),
            ),
          ),
          const SizedBox(height: 16),

          // Section Title Shimmer
          buildShimmerBox(height: 24, width: 180),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

Widget _buildCompanyDetailsSection(BuildContext context, Principle principle) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Company Details',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: Colors.grey.shade800,
              ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildDetailRow(
                context,
                Icons.qr_code,
                'Company Code',
                principle.companyCode ?? 'N/A',
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildDetailRow(
                context,
                Icons.factory,
                'Plant Code',
                principle.plantCode ?? 'N/A',
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        _buildDetailRow(
          context,
          Icons.account_tree,
          'Business Unit',
          principle.businessUnit ?? 'N/A',
        ),
      ],
    ),
  );
}

Widget _buildAddressSection(BuildContext context, Principle principle) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.amber.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.amber.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.location_on, size: 18, color: Colors.amber.shade700),
            const SizedBox(width: 8),
            Text(
              'Company Address',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Colors.amber.shade800,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          principle.companyAddress ?? 'Address not provided',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey.shade700,
                height: 1.4,
              ),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    ),
  );
}

Widget _buildComplianceSection(BuildContext context, Principle principle) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Icon(Icons.verified_user, size: 18, color: Colors.blue.shade600),
          const SizedBox(width: 8),
          Text(
            'Compliance Details',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Colors.grey.shade800,
                ),
          ),
        ],
      ),
      const SizedBox(height: 12),
      Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          if (principle.clraRcNo?.isNotEmpty == true)
            _buildComplianceTag(
                'CLRA: ${principle.clraRcNo}', Colors.blue, Icons.assignment),
          if (principle.clraRcDate?.isNotEmpty == true)
            _buildComplianceTag('CLRA Date: ${principle.clraRcDate}',
                Colors.blue.shade300, Icons.calendar_today),
          if (principle.ismwRcNo?.isNotEmpty == true)
            _buildComplianceTag(
                'ISMW: ${principle.ismwRcNo}', Colors.orange, Icons.work),
          if (principle.bocwRcNo?.isNotEmpty == true)
            _buildComplianceTag('BOCW: ${principle.bocwRcNo}', Colors.purple,
                Icons.construction),
          if (principle.factoryLicenseNum?.isNotEmpty == true)
            _buildComplianceTag(
                'Factory License: ${principle.factoryLicenseNum}',
                Colors.green,
                Icons.factory),
          if (principle.establishmentPfCode?.isNotEmpty == true)
            _buildComplianceTag('PF Code: ${principle.establishmentPfCode}',
                Colors.teal, Icons.account_balance),
        ],
      ),
    ],
  );
}

Widget _buildAdditionalDetailsSection(
    BuildContext context, Principle principle) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.purple.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.purple.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Additional Information',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: Colors.purple.shade800,
              ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildDetailRow(
                context,
                Icons.location_city,
                'Min Wage Zone',
                principle.minWageZone ?? 'Not Set',
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildDetailRow(
                context,
                Icons.monetization_on,
                'Default Bonus',
                principle.defaultBonus != null
                    ? '₹${principle.defaultBonus}'
                    : 'Not Set',
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildDetailRow(
    BuildContext context, IconData icon, String label, String value) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey.shade600),
          const SizedBox(width: 6),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ),
      const SizedBox(height: 4),
      Padding(
        padding: const EdgeInsets.only(left: 22),
        child: Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade800,
              ),
        ),
      ),
    ],
  );
}

Widget _buildComplianceTag(String text, Color color, IconData icon) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: color.withOpacity(0.1),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: color.withOpacity(0.3)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 6),
        Text(
          text,
          style: TextStyle(
            color: color,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

Widget _buildTimestampRow(BuildContext context, IconData icon, String label,
    DateTime? dateTime, Color color) {
  if (dateTime == null) return const SizedBox.shrink();

  return Row(
    children: [
      Icon(icon, size: 14, color: color),
      const SizedBox(width: 6),
      Text(
        '$label: ${_formatDate(dateTime)}',
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w500,
            ),
      ),
    ],
  );
}

Widget _buildActionButton(BuildContext context, IconData icon, String label,
    Color color, VoidCallback onPressed) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      foregroundColor: color,
      backgroundColor: color.withOpacity(0.1),
      elevation: 0,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: color.withOpacity(0.3)),
      ),
      textStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16),
        const SizedBox(width: 4),
        Text(label),
      ],
    ),
  );
}

String _formatDate(DateTime? date) {
  if (date == null) return 'N/A';
  return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
}
