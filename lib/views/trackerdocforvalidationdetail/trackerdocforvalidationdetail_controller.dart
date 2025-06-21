import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:compliancenavigator/data/models/tracker_application.dart';

class TrackerdocforvalidationdetailController extends GetxController {
  static const String trackerdocforvalidationdetailScreenId =
      'trackerdocforvalidationdetail_screen';

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
      
      // TODO: Implement approval logic
      await Future.delayed(const Duration(seconds: 1)); // Simulate API call
      Get.back(result: 'approved');
    } catch (e) {
      Get.snackbar('Error', 'Failed to approve document: $e');
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
      Get.back(result: 'rejected');
    } catch (e) {
      Get.snackbar('Error', 'Failed to reject document: $e');
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
