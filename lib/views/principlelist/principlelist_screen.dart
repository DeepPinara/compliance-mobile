import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:compliancenavigator/widgets/app_bar.dart';
import 'package:compliancenavigator/widgets/shimmer.dart';
import 'package:compliancenavigator/data/models/principle.dart';
import 'package:compliancenavigator/utils/pagination/pagination_list_view.dart';
import 'package:compliancenavigator/utils/pagination/infinite_scroll_view.dart'
    as pagination_mode;

import 'principlelist_controller.dart';

const String kPrinciplelistRoute = '/principlelist';

class PrinciplelistScreen extends GetView<PrinciplelistController> {
  const PrinciplelistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DLAppBar(
        title: 'Principle Entities',
        showBackButton: true,
      ),
      body: GetBuilder<PrinciplelistController>(
        id: PrinciplelistController.principlelistScreenId,
        builder: (controller) =>
            controller.isLoading && controller.items.isEmpty
                ? const PrincipleListShimmer()
                : PaginatedListView<PrinciplelistController, Principle>(
                    controller: controller,
                    items: controller.items,
                    itemBuilder: (context, principle, index) =>
                        _buildPrincipleCard(context, principle, index),
                    emptyWidget: const Center(
                      child: Text('No principles found'),
                    ),
                    padding: const EdgeInsets.all(16),
                    loadingWidget: const Center(
                      child: CircularProgressIndicator(),
                    ),
                    initialLoadingWidget: const Center(
                      child: CircularProgressIndicator(),
                    ),
                    physics: const BouncingScrollPhysics(),
                    paginationMode: pagination_mode.PaginationMode.standard,
                  ),
      ),
    );
  }

  Widget _buildPrincipleCard(
      BuildContext context, Principle principle, int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => controller.navigationService.navigateToPrincipleDetail(
          id: principle.id,
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
                _buildAddressSection(context, principle),
                const SizedBox(height: 16),

                // // Compliance Section
                _buildComplianceSection(context, principle),
                const SizedBox(height: 16),

                // // Additional Details Section
                _buildAdditionalDetailsSection(context, principle),
                const SizedBox(height: 16),

                // // Footer Section
                // _buildFooterSection(context, principle),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection(BuildContext context, Principle principle) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            Icons.business,
            color: Colors.blue.shade700,
            size: 24,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                principle.companyName ?? 'Unknown Company',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade800,
                    ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        // Container(
        //   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        //   decoration: BoxDecoration(
        //     color: principle.deletedAt == null ? Colors.green.shade50 : Colors.red.shade50,
        //     borderRadius: BorderRadius.circular(20),
        //     border: Border.all(
        //       color: principle.deletedAt == null ? Colors.green.shade200 : Colors.red.shade200,
        //     ),
        //   ),
        //   child: Row(
        //     mainAxisSize: MainAxisSize.min,
        //     children: [
        //       Icon(
        //         principle.deletedAt == null ? Icons.check_circle : Icons.cancel,
        //         size: 14,
        //         color: principle.deletedAt == null ? Colors.green.shade700 : Colors.red.shade700,
        //       ),
        //       const SizedBox(width: 4),
        //       Text(
        //         principle.deletedAt == null ? 'Active' : 'Inactive',
        //         style: TextStyle(
        //           color: principle.deletedAt == null ? Colors.green.shade700 : Colors.red.shade700,
        //           fontSize: 12,
        //           fontWeight: FontWeight.w600,
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }

  Widget _buildCompanyDetailsSection(
      BuildContext context, Principle principle) {
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
}

class PrincipleListShimmer extends StatelessWidget {
  const PrincipleListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 5,
      itemBuilder: (context, index) => const Padding(
        padding: EdgeInsets.only(bottom: 16.0),
        child: ShimmerCard(
          height: 180,
          borderRadius: 8,
        ),
      ),
    );
  }
}
