import 'package:compliancenavigator/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart' as shimmer_pkg;

abstract class DLShimmerWidget extends StatelessWidget {
  const DLShimmerWidget({super.key});

  Widget buildShimmerBox({
    required double height,
    required double width,
    double borderRadius = 8,
  }) {
    return shimmer_pkg.Shimmer.fromColors(
      baseColor: AppColors.secondaryButtonColor,
      highlightColor: Get.theme.colorScheme.secondary,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}

class ShimmerCard extends StatelessWidget {
  final double height;
  final double width;
  final double borderRadius;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Widget? child;

  const ShimmerCard({
    Key? key,
    this.height = 100,
    this.width = double.infinity,
    this.borderRadius = 8.0,
    this.margin,
    this.padding,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      child: shimmer_pkg.Shimmer.fromColors(
        baseColor: AppColors.secondaryButtonColor,
        highlightColor: Get.theme.colorScheme.secondary,
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: child,
        ),
      ),
    );
  }
}