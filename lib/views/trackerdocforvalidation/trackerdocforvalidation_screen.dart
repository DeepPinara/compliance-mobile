import 'package:compliancenavigator/utils/enums.dart';
import 'package:compliancenavigator/utils/pagination/pagination_list_view.dart';
import 'package:compliancenavigator/widgets/text_field.dart';
import 'package:compliancenavigator/widgets/tracker_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:compliancenavigator/data/models/tracker_application.dart';
import 'package:compliancenavigator/utils/colors.dart';
import 'package:compliancenavigator/utils/dimensions.dart';
import 'package:compliancenavigator/widgets/loading_indicator.dart';
import 'package:compliancenavigator/widgets/empty_state.dart';
import 'package:compliancenavigator/widgets/error_state.dart';
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
}
