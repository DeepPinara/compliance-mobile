import 'dart:io';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ImageViewer {
  final String imageUrl;
  final BoxFit? fit;
  final double? width;
  final double? height;
  final Color? color;
  final Widget? loadingBuilder;

  ImageViewer({
    required this.imageUrl,
    this.fit,
    this.width,
    this.height,
    this.color,
    this.loadingBuilder,
  });

  Widget build() {
    if (imageUrl.endsWith("svg")) {
      return SvgPicture.asset(
        imageUrl,
        width: width,
        height: height,
        fit: fit ?? BoxFit.cover,
        // ignore: deprecated_member_use
        color: color,
      );
    }
    // Determine image source
    if (imageUrl.startsWith('http://') || imageUrl.startsWith('https://')) {
      // Network image
      return CachedNetworkImage(
        imageUrl: imageUrl,
        width: width,
        height: height,
        fit: fit ?? BoxFit.cover,
        progressIndicatorBuilder: (_, __, ___) =>
            loadingBuilder ?? _buildShimmerPlaceholder(),
        // progressIndicatorBuilder: (_, __, ___) => ,
        // placeholder: (context, url) => _buildShimmerPlaceholder(),
        errorWidget: (context, url, error) =>
            const Icon(Icons.error, color: Colors.red),
      );
    } else if (imageUrl.startsWith('assets/')) {
      // Asset image
      return Image.asset(
        imageUrl,
        width: width,
        height: height,
        fit: fit ?? BoxFit.cover,
        color: color,
      );
    } else if (File(imageUrl).existsSync()) {
      // Local file image
      return Image.file(
        File(imageUrl),
        width: width,
        height: height,
        fit: fit ?? BoxFit.cover,
      );
    } else {
      // Invalid image source
      return const Icon(
        Icons.broken_image,
        color: Colors.grey,
        size: 48,
      );
    }
  }

  Widget _buildShimmerPlaceholder() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        color: Colors.white,
      ),
    );
  }
}
