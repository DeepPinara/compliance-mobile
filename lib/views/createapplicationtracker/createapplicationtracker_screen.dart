import 'package:compliancenavigator/data/models/company_name_model.dart';
import 'package:compliancenavigator/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:compliancenavigator/utils/enums.dart';
import 'package:compliancenavigator/widgets/app_bar.dart';
import 'package:compliancenavigator/themes/colors.dart';
import 'package:compliancenavigator/widgets/button.dart';
import 'package:compliancenavigator/widgets/text_field.dart';
import 'package:compliancenavigator/widgets/drop_down.dart';
import 'createapplicationtracker_controller.dart';

const String kCreateapplicationtrackerRoute = '/createapplicationtracker';

class CreateapplicationtrackerScreen
    extends GetWidget<CreateapplicationtrackerController> {
  const CreateapplicationtrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DLAppBar(
        title: 'Create Application',
        showBackButton: true,
      ),
      body: GetBuilder<CreateapplicationtrackerController>(
          id: CreateapplicationtrackerController
              .createapplicationtrackerScreenId,
          builder: (controller) {
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: controller.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _buildSectionHeader('Basic Detail'),
                          const SizedBox(height: 16),
                          _buildBasicDetailsSection(),

                          // Conditional sections based on application type
                          if (controller.selectedApplicationType ==
                                  TrackerApplicationType.clraNew ||
                              controller.selectedApplicationType ==
                                  TrackerApplicationType.clraRenewal)
                            _buildClraNewRenewSection()
                          else if (controller.selectedApplicationType ==
                              TrackerApplicationType.clraAmendment)
                            _buildClraAmendmentSection()
                          else
                            const SizedBox.shrink(),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Get.theme.colorScheme.surface,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 4,
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: AppConstants.kAppScreenSpacing,
                      left: AppConstants.kAppScreenSpacing,
                      right: AppConstants.kAppScreenSpacing,
                    ),
                    child: SafeArea(
                      bottom: true,
                      child: AppButton(
                        label: 'Submit',
                        onPressed: controller.submitForm,
                        buttonType: AppButtonType.primary,
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppColors.primaryColor,
      ),
    );
  }

  Future<void> _selectDate(TextEditingController controller,
      {required bool isStartDate}) async {
    final DateTime? picked = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: isStartDate ? DateTime(2000) : DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      controller.text = '${picked.day}/${picked.month}/${picked.year}';
    }
  }

  Widget _buildBasicDetailsSection() {
    return GetBuilder<CreateapplicationtrackerController>(
      id: CreateapplicationtrackerController.createapplicationtrackerScreenId,
      builder: (controller) => Column(
        children: [
          AppTextField(
            controller: controller.vendorCodeController,
            label: 'Vendor Code',
            hint: 'Enter vendor code',
            validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
          ),
          const SizedBox(height: 12),
          AppTextField(
            controller: controller.clientNameController,
            label: 'Client/Contractor Name',
            hint: 'Enter client/contractor name',
            validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
          ),
          const SizedBox(height: 12),
          DLDropDown<CompanyName>(
            items: controller.principles,
            selectedValue: controller.selectedPrincipalEmployer,
            onChanged: (value) {
              if (value != null) {
                controller.selectedPrincipalEmployer = value;
                controller.update();
              }
            },
            itemBuilder: (type) => type.name,
            label: 'Select Principal Employer Name',
            hint: 'Select principal employer',
            isRequired: true,
          ),
          const SizedBox(height: 12),
          DLDropDown<TrackerApplicationType>(
            items: TrackerApplicationType.values,
            selectedValue: controller.selectedApplicationType,
            onChanged: (value) {
              if (value != null) {
                controller.updateSelectedApplicationType(value);
              }
            },
            itemBuilder: (type) => type.displayName,
            label: 'Application Type',
            hint: 'Select application type',
            isRequired: true,
          ),
          const SizedBox(height: 12),
          AppTextField(
            controller: controller.laborCountController,
            label: 'No. Of Labour',
            hint: 'Enter number of labours',
            type: TextFieldType.number,
          ),
          const SizedBox(height: 12),
          AppTextField(
            controller: controller.contactPersonController,
            label: 'Contact Person Name',
            hint: 'Enter contact person name',
            validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
          ),
          const SizedBox(height: 12),
          AppTextField(
            controller: controller.contactEmailController,
            label: 'Contact Email',
            hint: 'Enter contact email',
            type: TextFieldType.email,
            validator: (value) {
              if (value?.isEmpty ?? true) return 'Required';
              if (!GetUtils.isEmail(value!)) return 'Enter a valid email';
              return null;
            },
          ),
          const SizedBox(height: 12),
          AppTextField(
            controller: controller.contactMobileController,
            label: 'Contact Mobile',
            hint: 'Enter contact mobile',
            type: TextFieldType.phone,
            validator: (value) {
              if (value?.isEmpty ?? true) return 'Required';
              if (!GetUtils.isPhoneNumber(value!))
                return 'Enter a valid mobile number';
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildClraNewRenewSection() {
    return GetBuilder<CreateapplicationtrackerController>(
      id: CreateapplicationtrackerController.createapplicationtrackerScreenId,
      builder: (controller) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          _buildSectionHeader(
              '${controller.selectedApplicationType.displayName} Details'),
          const SizedBox(height: 16),
          AppTextField(
            controller: controller.licenseNumberController,
            label: 'License Number',
            hint: 'Enter license number',
            validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
          ),
          const SizedBox(height: 12),
          AppTextField(
            controller: controller.form5FileController,
            label: 'Form 5',
            hint: 'Upload Form 5',
            type: TextFieldType.text,
            readOnly: true,
            validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
            onTap: () => controller.pickForm5File(),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: AppTextField(
                  controller: controller.periodStartController,
                  label: 'Period Start Date',
                  hint: 'Select start date',
                  readOnly: true,
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Required' : null,
                  onTap: () => controller.selectPeriodDateRange(),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: AppTextField(
                  controller: controller.periodEndController,
                  label: 'Period End Date',
                  hint: 'Select end date',
                  readOnly: true,
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Required' : null,
                  onTap: () => controller.selectPeriodDateRange(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildClraAmendmentSection() {
    return GetBuilder<CreateapplicationtrackerController>(
      builder: (controller) => Builder(
        builder: (context) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            _buildSectionHeader(
                '${controller.selectedApplicationType.displayName} Details'),
            const SizedBox(height: 16),
            AppTextField(
              controller: controller.licenseNumberController,
              label: 'Current License Number',
              hint: 'Enter current license number',
              validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
            ),
            const SizedBox(height: 12),
            AppTextField(
              controller: controller.ifpPortalIdController,
              label: 'IFP Portal ID',
              hint: 'Enter IFP Portal ID',
              validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
            ),
            const SizedBox(height: 12),
            AppTextField(
              controller: controller.ifpPortalPasswordController,
              label: 'IFP Portal Password',
              hint: 'Enter IFP Portal Password',
              type: TextFieldType.password,
              validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: AppTextField(
                    controller: controller.periodStartController,
                    label: 'Period Start',
                    hint: 'DD/MM/YYYY',
                    readOnly: true,
                    validator: (value) =>
                        value?.isEmpty ?? true ? 'Required' : null,
                    onTap: () => controller.selectPeriodDateRange(),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: AppTextField(
                    controller: controller.periodEndController,
                    label: 'Period End',
                    hint: 'DD/MM/YYYY',
                    readOnly: true,
                    validator: (value) =>
                        value?.isEmpty ?? true ? 'Required' : null,
                    onTap: () => controller.selectPeriodDateRange(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            AppTextField(
              controller: controller.headCountController,
              label: 'Current Head Count',
              hint: 'Enter current head count',
              type: TextFieldType.number,
              validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
            ),
          ],
        ),
      ),
    );
  }
}
