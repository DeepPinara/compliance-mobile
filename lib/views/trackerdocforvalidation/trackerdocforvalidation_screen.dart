import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'trackerdocforvalidation_controller.dart';
import 'package:compliancenavigator/widgets/app_bar.dart';

const String kTrackerdocforvalidationRoute = '/trackerdocforvalidation';
class TrackerdocforvalidationScreen extends GetWidget<TrackerdocforvalidationController> {
  const TrackerdocforvalidationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DLAppBar(
        title: 'Trackerdocforvalidation title',
        showBackButton: true,
      ),
      body: GetBuilder<TrackerdocforvalidationController>(
        id: TrackerdocforvalidationController.trackerdocforvalidationScreenId,
        builder: (controller) {
          return const Center(
            child: Text('Welcome to Trackerdocforvalidation Screen!'),
          );
        }
      ),
    );
  }
}
