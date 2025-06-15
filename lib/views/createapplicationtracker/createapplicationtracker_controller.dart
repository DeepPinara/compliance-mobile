import 'package:compliancenavigator/data/models/company_name_model.dart';
import 'package:compliancenavigator/data/models/create_tracker.dart';
import 'package:compliancenavigator/data/services/date_picker_service.dart';
import 'package:compliancenavigator/modules/principle/principle_repository.dart';
import 'package:compliancenavigator/modules/tracker/tracker_repository.dart';
import 'package:compliancenavigator/utils/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:compliancenavigator/utils/enums.dart';

class CreateapplicationtrackerController extends GetxController {
  static const String createapplicationtrackerScreenId =
      'createapplicationtracker_screen';

  final PrincipleRepository principleRepository;
  final TrackerRepository trackerRepository;

  CreateapplicationtrackerController(
      {required this.principleRepository, required this.trackerRepository});

  // Form key for validation
  final formKey = GlobalKey<FormState>();

  // Form controllers
  final TextEditingController vendorCodeController = TextEditingController();
  final TextEditingController clientNameController = TextEditingController();
  final TextEditingController laborCountController = TextEditingController();
  final TextEditingController contactPersonController = TextEditingController();
  final TextEditingController contactEmailController = TextEditingController();
  final TextEditingController contactMobileController = TextEditingController();
  final TextEditingController periodStartController = TextEditingController();
  DateTime? periodStartDate;
  final TextEditingController periodEndController = TextEditingController();
  DateTime? periodEndDate;
  final TextEditingController licenseNumberController = TextEditingController();
  final TextEditingController headCountController = TextEditingController();
  final TextEditingController ifpPortalIdController = TextEditingController();
  final TextEditingController ifpPortalPasswordController =
      TextEditingController();

  // Dropdown values
  List<CompanyName> principles = [];
  CompanyName? selectedPrincipalEmployer;

  // Application type
  TrackerApplicationType selectedApplicationType = TrackerApplicationType.bocw;

  // File upload
  final form5FileName = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPrinciples();
  }

  @override
  void onClose() {
    // Dispose all controllers
    vendorCodeController.dispose();
    clientNameController.dispose();
    laborCountController.dispose();
    contactPersonController.dispose();
    contactEmailController.dispose();
    contactMobileController.dispose();
    periodStartController.dispose();
    periodEndController.dispose();
    licenseNumberController.dispose();
    headCountController.dispose();
    ifpPortalIdController.dispose();
    ifpPortalPasswordController.dispose();
    super.onClose();
  }

  void fetchPrinciples() {
    principleRepository.getPrinciplesByName().then((value) {
      if (value.success) {
        principles = value.data.data!;
        update([createapplicationtrackerScreenId]);
      }
    });
  }

  // Handle form submission
  Future<void> submitForm() async {
    if (formKey.currentState?.validate() ?? false) {
      // Form is valid, process the data
      try {
        CreateTrackerResponse response =
            await trackerRepository.createTrackerApplication(
          getCreateTrackerRequest(),
        );
        showSnackBar('Application created successfully ${response.id}',
            isSuccess: true);
      } catch (e) {
        // Show error message
        showSnackBar(
          'Failed to create application: ${e.toString()}',
          isSuccess: false,
        );
      }
    }
  }

  CreateTrackerRequest getCreateTrackerRequest() {
    // Basic Details
    final basicDetails = CreateTrackerRequest(
      vendorCode: vendorCodeController.text,
      clientName: clientNameController.text,
      principalId: selectedPrincipalEmployer!.id,
      applicationType: selectedApplicationType,
      noOfLabours: laborCountController.text.isEmpty
          ? null
          : int.parse(laborCountController.text),
      contactPerson: contactPersonController.text,
      contactPersonEmail: contactEmailController.text,
      contactPersonPhone: contactMobileController.text,
    );

    switch (selectedApplicationType) {
      case TrackerApplicationType.bocw:
        return basicDetails;
      case TrackerApplicationType.clraNew:
        return basicDetails.copyWith(
          clraAmendStartDate: periodStartController.text,
          clraAmendEndDate: periodEndController.text,
        );
      case TrackerApplicationType.clraRenewal:
        return basicDetails.copyWith(
          clraAmendStartDate: periodStartController.text,
          clraAmendEndDate: periodEndController.text,
        );
      case TrackerApplicationType.clraAmendment:
        return basicDetails.copyWith(
          clraAmendStartDate: periodStartController.text,
          clraAmendEndDate: periodEndController.text,
        );
    }
  }

  void updateSelectedApplicationType(TrackerApplicationType type) {
    selectedApplicationType = type;
    update([createapplicationtrackerScreenId]);
  }

  // Handle file picker for Form 5
  Future<void> pickForm5File() async {
    // TODO: Implement file picking logic
    // This is a placeholder - you would typically use file_picker or similar package
    form5FileName.value = 'form5_document.pdf'; // Example filename
  }

  // Handle date range selection
  Future<void> selectPeriodDateRange() async {
    final range = await DatePickerService.pickDateRange(
      initialDateRange: _getCurrentDateRange(),
    );

    if (range != null) {
      periodStartController.text = range.start.displayFormat();
      periodEndController.text = range.end.displayFormat();
      update([createapplicationtrackerScreenId]);
    }
  }

  DateTimeRange? _getCurrentDateRange() {
    final start = periodStartDate;
    final end = periodEndDate;

    if (start != null && end != null) {
      return DateTimeRange(start: start, end: end);
    }
    return null;
  }
}
