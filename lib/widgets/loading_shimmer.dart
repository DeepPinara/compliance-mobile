import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingShimmer extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;
  final BoxShape shape;
  final EdgeInsetsGeometry? margin;

  const LoadingShimmer.rectangular({
    Key? key,
    required this.width,
    required this.height,
    this.borderRadius = 8.0,
    this.margin,
  })  : shape = BoxShape.rectangle,
        super(key: key);

  const LoadingShimmer.circular({
    Key? key,
    required double size,
  })  : width = size,
        height = size,
        borderRadius = 0,
        shape = BoxShape.circle,
        margin = null,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.grey[800]!
          : Colors.grey[300]!,
      highlightColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.grey[700]!
          : Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        margin: margin,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: shape,
          borderRadius: shape == BoxShape.rectangle
              ? BorderRadius.circular(borderRadius)
              : null,
        ),
      ),
    );
  }
}

class ShimmerList extends StatelessWidget {
  final int itemCount;
  final double itemHeight;
  final double itemSpacing;
  final EdgeInsetsGeometry? padding;

  const ShimmerList({
    Key? key,
    this.itemCount = 5,
    this.itemHeight = 60.0,
    this.itemSpacing = 8.0,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: padding,
      itemCount: itemCount,
      separatorBuilder: (context, index) => SizedBox(height: itemSpacing),
      itemBuilder: (context, index) => LoadingShimmer.rectangular(
        width: double.infinity,
        height: itemHeight,
      ),
    );
  }
}

class ShimmerGrid extends StatelessWidget {
  final int itemCount;
  final double childAspectRatio;
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  final EdgeInsetsGeometry? padding;

  const ShimmerGrid({
    Key? key,
    this.itemCount = 4,
    this.childAspectRatio = 1.0,
    this.crossAxisSpacing = 10.0,
    this.mainAxisSpacing = 10.0,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: padding,
      itemCount: itemCount,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: childAspectRatio,
        crossAxisSpacing: crossAxisSpacing,
        mainAxisSpacing: mainAxisSpacing,
      ),
      itemBuilder: (context, index) => const LoadingShimmer.rectangular(
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }
}
