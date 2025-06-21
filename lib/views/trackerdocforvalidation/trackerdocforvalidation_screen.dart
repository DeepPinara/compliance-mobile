import 'dart:async';
import 'package:compliancenavigator/utils/enums.dart';
import 'package:compliancenavigator/utils/pagination/pagination_list_view.dart';
import 'package:compliancenavigator/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:compliancenavigator/data/models/tracker_application.dart';
import 'package:compliancenavigator/utils/colors.dart';
import 'package:compliancenavigator/utils/dimensions.dart';
import 'package:compliancenavigator/widgets/loading_indicator.dart';
import 'package:compliancenavigator/widgets/empty_state.dart';
import 'package:compliancenavigator/widgets/error_state.dart';
import 'package:compliancenavigator/widgets/search_field.dart';
import 'trackerdocforvalidation_controller.dart';
import 'package:compliancenavigator/utils/pagination/infinite_scroll_view.dart'
    as pagination_mode;

const String kTrackerdocforvalidationRoute = '/trackerdocforvalidation';

class TrackerdocforvalidationScreen
    extends GetView<TrackerdocforvalidationController> {
  const TrackerdocforvalidationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Documents for Validation'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: GetBuilder<TrackerdocforvalidationController>(
        id: TrackerdocforvalidationController.trackerdocforvalidationScreenId,
        builder: (controller) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(AppDimensions.paddingDefault),
                child: AppTextField(
                  hint: 'Search documents...',
                  onChanged: (value) => controller.onSearch(value ?? ''),
                  controller: TextEditingController(),
                ),
              ),
              Expanded(
                child: PaginatedListView<TrackerdocforvalidationController,
                    TrackerApplication>(
                  controller: controller,
                  items: controller.items,
                  itemBuilder: (context, document, index) =>
                      _buildDocumentCard(document, controller),
                  emptyWidget: const Center(
                    child: Text('No documents found'),
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
            ],
          );
        },
      ),
    );
  }

  Widget _buildDocumentCard(TrackerApplication document,
      TrackerdocforvalidationController controller) {
    return InkWell(
      onTap: () {
        controller.navigationService
            .navigateToTrackerdocforvalidationdetail(document);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(
          vertical: 8.0,
        ),
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
                        document.clientName ?? 'Untitled Document',
                        style: Get.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 4.0),
                      decoration: BoxDecoration(
                        color: _getStatusColor(
                                document.applicationStatus.displayName)
                            .withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Text(
                        document.applicationStatus.displayName.toUpperCase(),
                        style: Get.textTheme.labelSmall?.copyWith(
                          color: _getStatusColor(
                              document.applicationStatus.displayName),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                _buildInfoRow(
                    'Vendor Code', document.vendorCode ?? 'N/A', context),
                _buildInfoRow('Application Type',
                    document.applicationType.displayName, context),
                if (document.applicationNum != null)
                  _buildInfoRow(
                      'Application #', document.applicationNum!, context),
                if (document.files != null && document.files!.isNotEmpty) ...[
                  const SizedBox(height: 8.0),
                  Text(
                    'Attachments:',
                    style: Get.textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ...document.files!
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

  Widget _buildEmptyState() {
    return EmptyState(
      title: 'No Documents Found',
      message: 'There are no documents to validate at the moment.',
      onRetry: () {},
    );
  }

  Widget _buildErrorState() {
    return ErrorState(
      title: 'Error Loading Documents',
      message: 'An unknown error occurred',
      onRetry: () {},
    );
  }

  Widget _buildLoadingIndicator() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(AppDimensions.paddingLarge),
        child: LoadingIndicator(),
      ),
    );
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
}
