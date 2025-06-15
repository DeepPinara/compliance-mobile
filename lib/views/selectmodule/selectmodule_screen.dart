import 'package:compliancenavigator/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:compliancenavigator/views/selectmodule/selectmodule_controller.dart';
import 'package:compliancenavigator/widgets/app_bar.dart';

const String kSelectmoduleRoute = '/selectmodule';

class SelectmoduleScreen extends GetWidget<SelectmoduleController> {
  const SelectmoduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: const DLAppBar(
        title: 'Select Module',
      ),
      body: GetBuilder<SelectmoduleController>(
        builder: (controller) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Choose Your Module',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.primaryColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Select the module you want to access',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[600],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  _buildModuleCard(
                    context: context,
                    icon: Icons.assignment_turned_in_rounded,
                    title: 'Compliance',
                    description: 'Access compliance management tools and track regulatory requirements',
                    onTap: () => controller.onSelectmodule(Selectmodule.compliance),
                  ),
                  const SizedBox(height: 24),
                  _buildModuleCard(
                    context: context,
                    icon: Icons.track_changes_rounded,
                    title: 'Tracker',
                    description: 'Monitor and track compliance activities and progress',
                    onTap: () => controller.onSelectmodule(Selectmodule.tracker),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildModuleCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                theme.cardColor,
                theme.cardColor.withOpacity(0.9),
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.primaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 28,
                  color: theme.primaryColor,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.textTheme.titleLarge?.color,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                  color: theme.primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
