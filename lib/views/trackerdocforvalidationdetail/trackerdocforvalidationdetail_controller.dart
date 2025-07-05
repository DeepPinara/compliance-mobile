import 'package:compliancenavigator/data/services/navigation_service/navigation_import.dart';
import 'package:compliancenavigator/modules/tracker/tracker_repository.dart';
import 'package:compliancenavigator/utils/enums.dart';
import 'package:compliancenavigator/utils/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:compliancenavigator/data/models/tracker_application.dart';

class TrackerdocforvalidationdetailController extends GetxController {
  static const String trackerdocforvalidationdetailScreenId =
      'trackerdocforvalidationdetail_screen';
  final TrackerRepository trackerRepository;
  final NavigationService navigationService;

  TrackerdocforvalidationdetailController({
    required this.trackerRepository,
    required this.navigationService,
  });

  late TrackerApplication document;
  bool isLoading = true;
  bool isApproving = false;
  bool isRejecting = false;
  final TextEditingController remarksController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    _loadDocument();
  }

  void _loadDocument() {
    try {
      if (Get.arguments != null && Get.arguments['document'] != null) {
        document = Get.arguments['document'];
      }
    } finally {
      isLoading = false;
      update([trackerdocforvalidationdetailScreenId]);
    }
  }

  Future<void> approveDocument() async {
    try {
      isApproving = true;
      update([trackerdocforvalidationdetailScreenId]);

      final updateTracker = await trackerRepository.updateDocToBeVerified(
        id: document.id,
        applicationStatus: TrackerApplicationStatus.approved,
        remark: 'Approved',
      );
      showSnackBar('Document approved successfully');
      navigationService.goBack();
    } catch (e) {
      showSnackBar(e.toString());
    } finally {
      isApproving = false;
      update([trackerdocforvalidationdetailScreenId]);
    }
  }

  Future<void> rejectDocument() async {
    try {
      isRejecting = true;
      update([trackerdocforvalidationdetailScreenId]);

      // TODO: Implement rejection logic with remarks
      await Future.delayed(const Duration(seconds: 1)); // Simulate API call
      showSnackBar('Document rejected successfully');
      navigationService.goBack();
    } catch (e) {
      showSnackBar(e.toString());
    } finally {
      isRejecting = false;
      update([trackerdocforvalidationdetailScreenId]);
    }
  }

  @override
  void onClose() {
    remarksController.dispose();
    super.onClose();
  }
}
