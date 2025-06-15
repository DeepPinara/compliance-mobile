import 'package:compliancenavigator/utils/pagination/pagination_mixin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Enum to define the layout type for the InfiniteScrollView
enum InfiniteScrollLayout {
  list,
  grid,
}

/// Enum to define how the pagination should be triggered
enum PaginationMode {
  /// Standard mode - uses the scrollController from PaginationMixin
  standard,

  /// Manual mode - disables automatic pagination, allowing for parent scroll control
  manual,
}

/// A custom widget that works with controllers that implement the PaginationMixin
/// to manage infinite scrolling and loading UI.
///
/// This widget handles:
/// - Displaying a list of items
/// - Showing an initial loading indicator when data is first being fetched
/// - Showing a loading indicator when more data is being loaded
/// - Handling empty states
/// - Managing end of list indicators
/// - Supporting both standard and manual pagination modes
class InfiniteScrollView<T extends GetxController, P> extends StatelessWidget {
  /// The controller that implements the PaginationMixin
  final T controller;

  /// List of items to display
  final List<P> items;

  /// Builder function to create widgets for each item
  final Widget Function(BuildContext context, P item, int index) itemBuilder;

  /// Widget to display when the list is empty
  final Widget? emptyWidget;

  /// Widget to display at the bottom of the list when there's no more data
  final Widget? endOfListWidget;

  /// Widget to display when initial data is loading
  final Widget? initialLoadingWidget;

  /// Additional space to add at the bottom of the list
  final double bottomSpace;

  /// Whether to show the loading indicator
  final bool showLoading;

  /// Whether the list should shrink wrap its contents
  final bool shrinkWrap;

  /// Physics for the scroll view
  final ScrollPhysics? physics;

  /// Padding for the list
  final EdgeInsets? padding;

  // scrollDirection
  final Axis scrollDirection;

  //  height constraint for the list
  final double? heightConstraint;

  /// Additional widgets to display at the bottom of the list
  final List<Widget>? bottomWidgets;

  /// Separator builder for the list
  final Widget Function(BuildContext, int)? separatorBuilder;

  /// The layout type to use (list or grid)
  final InfiniteScrollLayout layout;

  /// The pagination mode to use (standard or manual)
  final PaginationMode paginationMode;

  /// Grid-specific properties
  final int? gridCrossAxisCount;
  final double? gridMainAxisSpacing;
  final double? gridCrossAxisSpacing;
  final double? gridChildAspectRatio;

  /// Custom loading widget to display when paginating
  /// If not provided, a default CircularProgressIndicator will be used
  final Widget? loadingWidget;

  const InfiniteScrollView({
    super.key,
    required this.controller,
    required this.items,
    required this.itemBuilder,
    this.emptyWidget,
    this.endOfListWidget,
    this.initialLoadingWidget,
    this.bottomSpace = 100,
    this.showLoading = true,
    this.shrinkWrap = false,
    this.physics,
    this.padding,
    this.scrollDirection = Axis.vertical,
    this.heightConstraint,
    this.bottomWidgets,
    this.separatorBuilder,
    this.layout = InfiniteScrollLayout.list,
    this.paginationMode = PaginationMode.standard,
    this.gridCrossAxisCount = 2,
    this.gridMainAxisSpacing = 10.0,
    this.gridCrossAxisSpacing = 10.0,
    this.gridChildAspectRatio = 1.0,
    this.loadingWidget,
  }) : assert(
          controller is PaginationMixin,
          'Controller must implement PaginationMixin',
        );

  @override
  Widget build(BuildContext context) {
    // Cast controller to access PaginationMixin properties
    final paginationController = controller as PaginationMixin;

    // Get scroll controller from the mixin (only used in standard mode)
    final scrollController = paginationMode == PaginationMode.standard
        ? paginationController.scrollController
        : ScrollController(); // Dummy controller for manual mode

    // Show initial loading state if specified
    if (paginationController.isInitialLoading) {
      return Center(
        child: initialLoadingWidget ??
            loadingWidget ??
            const CircularProgressIndicator(),
      );
    }

    // If items is empty, show empty widget
    if (items.isEmpty) {
      return emptyWidget ?? const Center(child: Text('No items found'));
    }

    // Build the content widget based on layout
    Widget contentWidget;
    switch (layout) {
      case InfiniteScrollLayout.grid:
        contentWidget =
            _buildGridView(scrollController, context, paginationController);
        break;
      case InfiniteScrollLayout.list:
        contentWidget = separatorBuilder != null
            ? _buildSeparatedListView(
                scrollController, context, paginationController)
            : _buildListView(scrollController, context, paginationController);
    }

    // Wrap with a Container with fixed height if heightConstraint is provided
    // and scrollDirection is horizontal
    if (heightConstraint != null && scrollDirection == Axis.horizontal) {
      contentWidget = SizedBox(
        height: heightConstraint,
        child: contentWidget,
      );
    }

    // For manual mode, add bottom indicators separately
    if (paginationMode == PaginationMode.manual) {
      return Column(
        children: [
          // Main content
          Expanded(child: contentWidget),

          // Manual bottom indicators
          _buildManualBottomWidgets(context, paginationController),
        ],
      );
    }

    // For standard mode, return the content widget directly
    return contentWidget;
  }

  ListView _buildListView(ScrollController scrollController,
      BuildContext context, PaginationMixin paginationController) {
    return ListView.builder(
      controller: scrollController,
      shrinkWrap: shrinkWrap,
      physics: physics,
      padding: padding,
      scrollDirection: scrollDirection,
      itemCount: items.length +
          (paginationMode == PaginationMode.standard
              ? 1
              : 0), // Add +1 only in standard mode
      itemBuilder: (context, index) {
        // If we've reached the end of the list and in standard mode, show loading or end of list widget
        if (index == items.length &&
            paginationMode == PaginationMode.standard) {
          return _buildBottomWidget(context, paginationController);
        }

        // Otherwise, build an item widget
        return itemBuilder(context, items[index], index);
      },
    );
  }

  ListView _buildSeparatedListView(ScrollController scrollController,
      BuildContext context, PaginationMixin paginationController) {
    return ListView.separated(
      controller: scrollController,
      shrinkWrap: shrinkWrap,
      physics: physics,
      padding: padding,
      itemCount: items.length +
          (paginationMode == PaginationMode.standard
              ? 1
              : 0), // Add +1 only in standard mode
      separatorBuilder: separatorBuilder!,
      itemBuilder: (context, index) {
        // If we've reached the end of the list and in standard mode, show loading or end of list widget
        if (index == items.length &&
            paginationMode == PaginationMode.standard) {
          return _buildBottomWidget(context, paginationController);
        }

        // Otherwise, build an item widget
        return itemBuilder(context, items[index], index);
      },
    );
  }

  GridView _buildGridView(ScrollController scrollController,
      BuildContext context, PaginationMixin paginationController) {
    // For grid view in manual mode, don't add the +1 for loading indicator
    // because it would disrupt the grid layout. Instead, we'll add it separately.
    return GridView.builder(
      controller: scrollController,
      shrinkWrap: shrinkWrap,
      physics: physics,
      padding: padding,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: gridCrossAxisCount!,
        mainAxisSpacing: gridMainAxisSpacing!,
        crossAxisSpacing: gridCrossAxisSpacing!,
        childAspectRatio: gridChildAspectRatio!,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return itemBuilder(context, items[index], index);
      },
    );
  }

  Widget _buildBottomWidget(
      BuildContext context, PaginationMixin paginationController) {
    // Get pagination state from the mixin
    final hasMore = paginationController.hasMore;
    final isPaginating = paginationController.isPaginating;

    return Column(
      children: [
        // If we're paginating and should show loading, show the loading indicator
        if (isPaginating && showLoading)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Center(
              child: loadingWidget ?? const CircularProgressIndicator(),
            ),
          ),

        // If there's no more data, show the end of list widget
        if (!hasMore && !isPaginating)
          endOfListWidget ?? const SizedBox.shrink(),

        // Add any additional bottom widgets
        if (bottomWidgets != null) ...bottomWidgets!,

        // Add bottom space
        SizedBox(height: bottomSpace),
      ],
    );
  }

  Widget _buildManualBottomWidgets(
      BuildContext context, PaginationMixin paginationController) {
    // Get pagination state from the mixin
    final hasMore = paginationController.hasMore;
    final isPaginating = paginationController.isPaginating;

    return Column(
      children: [
        // If we're paginating and should show loading, show the loading indicator
        if (isPaginating && showLoading)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Center(
              child: loadingWidget ?? const CircularProgressIndicator(),
            ),
          ),

        // If there's no more data, show the end of list widget
        if (!hasMore && !isPaginating && items.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: endOfListWidget ?? const Text('No more items to load'),
          ),

        // Add any additional bottom widgets
        if (bottomWidgets != null) ...bottomWidgets!,

        // Add bottom space
        SizedBox(height: bottomSpace),
      ],
    );
  }
}
