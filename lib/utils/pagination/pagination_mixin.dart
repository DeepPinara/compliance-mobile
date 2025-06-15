import 'package:flutter/material.dart';
import 'package:get/get.dart';

// kPageSize
const int kPageSize = 10;

/// Use the [PaginationMixin] in the [GetxController] for the pagination feature.

/// Just only need to implement the [loadMoreData] method in the controller it should be the API call for the pagination.

/// The [loadMoreData] method will be called when the user scroll the list.

/// handle with the [hasMore] variable to stop the API call when the list is finished.

/// There should be a time we need to handle the multiple pagination  in the same screen like [GlobalSearchController] or [FollowEventController]
/// in this case we need to handle the another [hasMore] variable in the [GetxController] method.

mixin PaginationMixin on GetxController {
  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_listener);
  }

  bool hasMore = true;

  bool isPaginating = false;
  bool isInitialLoading = false;

  void loadMoreData();

  final ScrollController scrollController = ScrollController();

  // Optional parent scroll controller for nested scroll view scenarios
  ScrollController? parentScrollController;

  // Setup parent scroll controller with custom threshold
  void setupParentScrollController(
      {ScrollController? controller, double threshold = 0.8}) {
    if (controller != null) {
      parentScrollController = controller;
      parentScrollController!
          .addListener(() => _parentScrollListener(threshold));
    }
  }

  // Parent scroll listener for nested scroll views
  void _parentScrollListener(double threshold) {
    if (parentScrollController == null || !parentScrollController!.hasClients) {
      return;
    }

    final maxScroll = parentScrollController!.position.maxScrollExtent;
    final currentScroll = parentScrollController!.position.pixels;
    double percentage = (currentScroll / maxScroll) * 100;

    // Load more when scrolled past threshold
    if (percentage >= threshold * 100 && !isPaginating && hasMore) {
      loadMoreData();
    }
  }

  int offset(int length, [int pageSize = kPageSize]) {
    return (length / pageSize).floor();
  }

  _listener() async {
    if (!scrollController.hasClients) return;

    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.position.pixels;
    double percentage = (currentScroll / maxScroll) * 100;
    if (percentage >= 70 && !isPaginating && hasMore) {
      loadMoreData();
    }
  }

  @override
  void onClose() {
    scrollController.removeListener(_listener);
    scrollController.dispose();

    // Clean up parent scroll controller if it exists
    if (parentScrollController != null) {
      parentScrollController!.removeListener(() => _parentScrollListener(0.8));
      // Note: We don't dispose the parent controller here because it might be owned by another widget
    }

    super.onClose();
  }
}
