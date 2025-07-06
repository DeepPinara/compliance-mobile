import 'package:compliancenavigator/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:compliancenavigator/data/models/tracker_application.dart';
import 'package:compliancenavigator/utils/colors.dart';

Widget buildTrackerCard({
  required TrackerApplication tracker,
  required Function ontap,
}) {
  return Card(
    margin: const EdgeInsets.symmetric(
      vertical: 8.0,
    ),
    child: InkWell(
      onTap: () => ontap(),
      borderRadius: BorderRadius.circular(12.0),
      child: Padding( 
        padding: const EdgeInsets.all(16.0),
        child: Builder(
          builder: (context) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      tracker.clientName,
                      style: Get.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4.0),
                    decoration: BoxDecoration(
                      color:
                          _getStatusColor(tracker.applicationStatus.displayName)
                              .withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Text(
                      tracker.applicationStatus.displayName.toUpperCase(),
                      style: Get.textTheme.labelSmall?.copyWith(
                        color: _getStatusColor(
                            tracker.applicationStatus.displayName),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              _buildInfoRow(
                  'Vendor Code', tracker.vendorCode ?? 'N/A', context),
              _buildInfoRow('Application Type',
                  tracker.applicationType.displayName, context),
              if (tracker.applicationNum != null)
                _buildInfoRow(
                    'Application #', tracker.applicationNum!, context),
              if (tracker.files != null && tracker.files.isNotEmpty) ...[
                const SizedBox(height: 8.0),
                Text(
                  'Attachments:',
                  style: Get.textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ...tracker.files!
                    .map((file) => Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            file.fileFieldName.displayName,
                            style: Get.textTheme.bodySmall?.copyWith(
                              color: AppColors.primary,
                              decoration: TextDecoration.underline,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ))
                    .toList(),
              ],
            ],
          ),
        ),
      ),
    ),
  );
}

Color _getStatusColor(String status) {
  final theme = Theme.of(Get.context!);
  switch (status.toLowerCase()) {
    case 'pending':
      return Colors.orange;
    case 'approved':
      return Colors.green;
    case 'rejected':
      return Colors.red;
    case 'in_review':
      return theme.primaryColor;
    default:
      return theme.hintColor;
  }
}

Widget _buildInfoRow(String label, String value, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label: ',
          style: Get.textTheme.bodySmall?.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: Get.textTheme.bodySmall,
          ),
        ),
      ],
    ),
  );
}
