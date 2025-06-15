import 'package:compliancenavigator/utils/pagination/infinite_scroll_view.dart';
import 'package:compliancenavigator/utils/pagination/pagination_mixin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// A simplified ListView implementation that uses InfiniteScrollView
/// for infinite scrolling and pagination.
class PaginatedListView<T extends GetxController, P> extends StatelessWidget {
  final T controller;
  final List<P> items;
  final Widget Function(BuildContext context, P item, int index) itemBuilder;
  final Widget? emptyWidget;
  final Widget? endOfListWidget;
  final EdgeInsets? padding;
  final Axis scrollDirection;
  final double? heightConstraint;
  final Widget Function(BuildContext, int)? separatorBuilder;
  final ScrollPhysics? physics;
  final Widget? loadingWidget;
  final Widget? initialLoadingWidget;
  final bool shrinkWrap;
  final PaginationMode paginationMode;

  const PaginatedListView({
    super.key,
    required this.controller,
    required this.items,
    required this.itemBuilder,
    this.emptyWidget,
    this.endOfListWidget,
    this.padding,
    this.scrollDirection = Axis.vertical,
    this.heightConstraint,
    this.separatorBuilder,
    this.physics,
    this.loadingWidget,
    this.initialLoadingWidget,
    this.shrinkWrap = false,
    this.paginationMode = PaginationMode.standard,
  }) : assert(
          controller is PaginationMixin,
          'Controller must implement PaginationMixin',
        );

  @override
  Widget build(BuildContext context) {
    return InfiniteScrollView(
      controller: controller,
      items: items,
      itemBuilder: itemBuilder,
      emptyWidget: emptyWidget,
      endOfListWidget: endOfListWidget,
      padding: padding,
      scrollDirection: scrollDirection,
      heightConstraint: heightConstraint,
      separatorBuilder: separatorBuilder,
      physics: physics,
      loadingWidget: loadingWidget,
      initialLoadingWidget: initialLoadingWidget,
      shrinkWrap: shrinkWrap,
      paginationMode: paginationMode,
      layout: InfiniteScrollLayout.list,
    );
  }
}
