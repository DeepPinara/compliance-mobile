import 'package:compliancenavigator/data/models/tracker_application.dart';
import 'package:compliancenavigator/utils/dimensions.dart';
import 'package:compliancenavigator/utils/pagination/pagination_list_view.dart';
import 'package:compliancenavigator/widgets/empty_state.dart';
import 'package:compliancenavigator/widgets/error_state.dart';
import 'package:compliancenavigator/widgets/loading_indicator.dart';
import 'package:compliancenavigator/widgets/text_field.dart';
import 'package:compliancenavigator/widgets/tracker_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'trackerlist_controller.dart';
import 'package:compliancenavigator/widgets/app_bar.dart';
import 'package:compliancenavigator/utils/pagination/infinite_scroll_view.dart'
    as pagination_mode;

const String kTrackerlistRoute = '/trackerlist';

class TrackerlistScreen extends GetWidget<TrackerlistController> {
  const TrackerlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tracker List'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: GetBuilder<TrackerlistController>(
        id: TrackerlistController.trackerlistScreenId,
        builder: (controller) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(AppDimensions.paddingDefault),
                child: AppTextField(
                  hint: 'Search tracker...',
                  onChanged: (value) => controller.onSearch(value ?? ''),
                  controller: TextEditingController(),
                ),
              ),
              Expanded(
                child: PaginatedListView<TrackerlistController,
                    TrackerApplication>(
                  controller: controller,
                  items: controller.items,
                  itemBuilder: (context, document, index) =>
                      _buildDocumentCard(document, controller),
                  emptyWidget: const Center(
                    child: Text('No tracker found'),
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

  Widget _buildDocumentCard(
      TrackerApplication document, TrackerlistController controller) {
    return buildTrackerCard(
      tracker: document,
      ontap: () {
        controller.navigationService
            .navigateToTrackerdocforvalidationdetail(document);
      },
    );
  }

  Widget _buildEmptyState() {
    return EmptyState(
      title: 'No Tracker Found',
      message: 'There are no tracker to validate at the moment.',
      onRetry: () {},
    );
  }

  Widget _buildErrorState() {
    return ErrorState(
      title: 'Error Loading Tracker',
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
}
