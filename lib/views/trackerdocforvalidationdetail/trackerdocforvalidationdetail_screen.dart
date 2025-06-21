import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:compliancenavigator/utils/colors.dart';
import 'package:compliancenavigator/utils/dimensions.dart';
import 'package:compliancenavigator/widgets/app_bar.dart';
import 'package:compliancenavigator/widgets/loading_indicator.dart';
import 'trackerdocforvalidationdetail_controller.dart';

const String kTrackerdocforvalidationdetailRoute = '/trackerdocforvalidationdetail';

class TrackerdocforvalidationdetailScreen extends GetView<TrackerdocforvalidationdetailController> {
  const TrackerdocforvalidationdetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DLAppBar(
        title: 'Application Details',
        showBackButton: true,
      ),
      body: GetBuilder<TrackerdocforvalidationdetailController>(
        id: TrackerdocforvalidationdetailController.trackerdocforvalidationdetailScreenId,
        builder: (controller) {
          if (controller.isLoading) {
            return const Center(child: LoadingIndicator());
          }

          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(AppDimensions.paddingDefault),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeaderSection(controller),
                      const SizedBox(height: 24),
                      _buildDocumentDetails(controller),
                      const SizedBox(height: 24),
                      _buildAttachmentsSection(controller),
                      const SizedBox(height: 24),
                      _buildRemarksSection(controller),
                      const SizedBox(height: 80), // Space for buttons
                    ],
                  ),
                ),
              ),
              _buildActionButtons(controller),
            ],
          );
        },
      ),
    );
  }

  Widget _buildHeaderSection(TrackerdocforvalidationdetailController controller) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.description_outlined,
                    color: AppColors.primary,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.document.clientName ?? 'Untitled Document',
                        style: Get.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Vendor: ${controller.document.vendorCode ?? 'N/A'}',
                        style: Get.textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                _buildStatusChip(controller.document.applicationStatus.toString().split('.').last),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDocumentDetails(TrackerdocforvalidationdetailController controller) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Document Details',
              style: Get.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            _buildDetailRow(
              Icons.assignment_outlined,
              'Application Type',
              controller.document.applicationType.toString().split('.').last,
            ),
            if (controller.document.applicationNum != null) ...[
              const SizedBox(height: 8),
              _buildDetailRow(
                Icons.numbers_outlined,
                'Application #',
                controller.document.applicationNum!,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildAttachmentsSection(TrackerdocforvalidationdetailController controller) {
    if (controller.document.files.isEmpty) {
      return const SizedBox.shrink();
    }

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Attachments',
              style: Get.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: controller.document.files
                  .map((file) => _buildAttachmentChip(file.fileFieldName.toString().split('.').last))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRemarksSection(TrackerdocforvalidationdetailController controller) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Remarks',
              style: Get.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: controller.remarksController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Enter remarks (optional)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: AppColors.primary),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(TrackerdocforvalidationdetailController controller) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () => _showRejectConfirmation(controller),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
                side: const BorderSide(color: Colors.red),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: controller.isRejecting
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                      ),
                    )
                  : const Text(
                      'Reject',
                      style: TextStyle(color: Colors.red),
                    ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: controller.isApproving ? null : controller.approveDocument,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: controller.isApproving
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : const Text('Approve'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    final color = _getStatusColor(status);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        status.toUpperCase(),
        style: Get.textTheme.labelSmall?.copyWith(
          color: color,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildAttachmentChip(String fileKey) {
    final fileName = fileKey.split('/').last;
    final fileExt = fileName.split('.').last.toLowerCase();
    
    IconData icon;
    Color iconColor;
    
    if (['pdf'].contains(fileExt)) {
      icon = Icons.picture_as_pdf_outlined;
      iconColor = Colors.red;
    } else if (['doc', 'docx'].contains(fileExt)) {
      icon = Icons.description_outlined;
      iconColor = Colors.blue;
    } else if (['xls', 'xlsx'].contains(fileExt)) {
      icon = Icons.table_chart_outlined;
      iconColor = Colors.green;
    } else if (['jpg', 'jpeg', 'png', 'gif'].contains(fileExt)) {
      icon = Icons.image_outlined;
      iconColor = Colors.purple;
    } else {
      icon = Icons.insert_drive_file_outlined;
      iconColor = Colors.grey;
    }

    return InkWell(
      onTap: () {
        // TODO: Implement file preview/download
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 20, color: iconColor),
            const SizedBox(width: 8),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 150),
              child: Text(
                fileName,
                style: Get.textTheme.bodySmall?.copyWith(
                  color: Colors.grey[800],
                  overflow: TextOverflow.ellipsis,
                ),
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: Colors.grey[500]),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Get.textTheme.bodySmall?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: Get.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'approved':
        return Colors.green;
      case 'rejected':
        return Colors.red;
      case 'in review':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  void _showRejectConfirmation(TrackerdocforvalidationdetailController controller) {
    Get.defaultDialog(
      title: 'Reject Document',
      content: Column(
        children: [
          const Text('Are you sure you want to reject this document?'),
          const SizedBox(height: 16),
          TextField(
            controller: controller.remarksController,
            decoration: const InputDecoration(
              labelText: 'Remarks',
              border: OutlineInputBorder(),
              hintText: 'Enter reason for rejection',
            ),
            maxLines: 3,
          ),
        ],
      ),
      textConfirm: 'Confirm Reject',
      textCancel: 'Cancel',
      confirmTextColor: Colors.white,
      buttonColor: Colors.red,
      cancelTextColor: Colors.grey[700],
      onConfirm: () async {
        if (controller.remarksController.text.trim().isEmpty) {
          Get.snackbar('Error', 'Please provide a reason for rejection');
          return;
        }
        Get.back();
        await controller.rejectDocument();
      },
    );
  }
}
