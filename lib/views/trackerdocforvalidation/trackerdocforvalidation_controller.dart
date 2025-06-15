import 'dart:developer';

import 'package:compliancenavigator/data/services/navigation_service/navigation_import.dart';
import 'package:compliancenavigator/modules/tracker/tracker_repository.dart';
import 'package:get/get.dart';

class TrackerdocforvalidationController extends GetxController {
  final TrackerRepository trackerRepository;
  final NavigationService navigationService;
  TrackerdocforvalidationController(
      {required this.trackerRepository, required this.navigationService});

  static const String trackerdocforvalidationScreenId =
      'Trackerdocforvalidation_screen';

  @override
  void onInit() {
    super.onInit();
    fetchTrackerdocforvalidation();
  }

  void fetchTrackerdocforvalidation() {
    trackerRepository
        .fetchTrackerdocforvalidation(
      page: 1,
      limit: 10,
    )
        .then((value) {
      log('message');
    });
  }

  // Add your controller logic here
}
