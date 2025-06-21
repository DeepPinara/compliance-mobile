import 'package:compliancenavigator/data/models/company_name_model.dart';
import 'package:compliancenavigator/data/models/create_tracker.dart';
import 'package:compliancenavigator/data/models/tracker_file.dart';
import 'package:compliancenavigator/data/services/date_picker_service.dart';
import 'package:compliancenavigator/modules/principle/principle_repository.dart';
import 'package:compliancenavigator/modules/tracker/tracker_repository.dart';
import 'package:compliancenavigator/utils/file_utils/file_picker.dart';
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
  final TextEditingController form5FileController = TextEditingController();
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
  PickedFile? form5File;

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
          await getCreateTrackerRequest(),
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

  Future<CreateTrackerRequest> getCreateTrackerRequest() async {
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
      case TrackerApplicationType.clraRenewal:
        final files = await _getFiles();
        return basicDetails.copyWith(
          formFiveStartDate: periodStartDate,
          formFiveEndDate: periodEndDate,
          files: files,
        );
      case TrackerApplicationType.clraAmendment:
        return basicDetails.copyWith(
          clraAmendStartDate: periodStartDate,
          clraAmendEndDate: periodEndDate,
          currentLicenceNumber: licenseNumberController.text,
          ifpId: ifpPortalIdController.text,
          ifpPassword: ifpPortalPasswordController.text,
        );
    }
  }

  Future<List<TrackerFile>> _getFiles() async {
    try {
      final fileKey = await trackerRepository.uploadFiles(form5File!);
      return <TrackerFile>[
        TrackerFile(
          fileFieldName: TrackerFilesType.form5,
          fileKey: fileKey,
        ),
      ];
    } catch (e) {
      rethrow;
    }
  }

  void updateSelectedApplicationType(TrackerApplicationType type) {
    selectedApplicationType = type;
    update([createapplicationtrackerScreenId]);
  }

  // Handle file picker for Form 5
  Future<void> pickForm5File() async {
    try {
      final pickedFile = await pickImageOrFile(
        isFileOption: true,
        typeOfFileSelect: [
          FileTypeSelect.pdf,
          FileTypeSelect.image,
          FileTypeSelect.doc,
        ],
      );

      if (pickedFile != null) {
        form5File = pickedFile;
        form5FileController.text = pickedFile.name ?? pickedFile.path ?? '';
      }
      update([createapplicationtrackerScreenId]);
    } catch (e) {
      showSnackBar(e.toString());
    }
  }

  // Handle date range selection
  Future<void> selectPeriodDateRange() async {
    final range = await DatePickerService.pickDateRange(
      initialDateRange: _getCurrentDateRange(),
    );

    if (range != null) {
      periodStartController.text = range.start.displayFormat();
      periodEndController.text = range.end.displayFormat();
      periodStartDate = range.start;
      periodEndDate = range.end;
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
