import 'package:compliancenavigator/data/models/user.dart';
import 'package:compliancenavigator/themes/colors.dart';
import 'package:compliancenavigator/widgets/app_bar.dart';
import 'package:compliancenavigator/widgets/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'profile_controller.dart';

const String kProfileRoute = '/profile';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DLAppBar(
        title: 'My Profile',
        suffixWidget: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: controller.logout,
            ),
          ],
        ),
      ),
      body: GetBuilder<ProfileController>(
        id: ProfileController.profileScreenId,
        builder: (controller) {
          if (controller.isLoading && controller.currentUser == null) {
            return const ProfileScreenWidgetLoading();
          }
          return RefreshIndicator(
            onRefresh: () => controller.getCurrentUser(),
            child: _buildProfileContent(context, controller),
          );
        },
      ),
    );
  }

  Widget _buildProfileContent(
      BuildContext context, ProfileController controller) {
    final user = controller.currentUser;
    if (user == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('No user data available'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: controller.getCurrentUser,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProfileHeader(context, user),
          const SizedBox(height: 24),
          _buildSectionTitle(context, 'Account Information'),
          _buildInfoCard(context, user),
          const SizedBox(height: 16),
          _buildSectionTitle(context, 'Modules Access'),
          _buildModulesList(context, user.modules),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context, User user) {
    return Center(
      child: Column(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primaryColor.withOpacity(0.1),
              border: Border.all(
                color: AppColors.primaryColor,
                width: 2,
              ),
            ),
            child: const Icon(
              Icons.person,
              size: 60,
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            user.userName,
            style: Get.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            user.email,
            style: Get.textTheme.bodyLarge?.copyWith(
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: _getRoleColor(user.role).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              user.role.toUpperCase(),
              style: TextStyle(
                color: _getRoleColor(user.role),
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: Get.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context, User user) {
    final dateFormat = DateFormat('MMM d, yyyy');

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildInfoRow(
                context, 'Member Since', dateFormat.format(user.createdAt)),
            const Divider(height: 24),
            _buildInfoRow(
                context, 'Last Updated', dateFormat.format(user.updatedAt)),
            if (user.lastActivity != null) ...[
              const Divider(height: 24),
              _buildInfoRow(context, 'Last Active',
                  _formatLastActive(user.lastActivity!)),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildModulesList(
      BuildContext context, Map<String, List<String>> modules) {
    if (modules.isEmpty) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Center(child: Text('No modules assigned')),
        ),
      );
    }

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        itemCount: modules.length,
        separatorBuilder: (context, index) => const Divider(height: 24),
        itemBuilder: (context, index) {
          final module = modules.entries.elementAt(index);
          return _buildModuleItem(context, module.key, module.value);
        },
      ),
    );
  }

  Widget _buildModuleItem(
      BuildContext context, String moduleName, List<String> permissions) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          moduleName.replaceAll('_', ' ').toTitleCase(),
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: permissions
              .map((permission) => Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      permission.replaceAll('_', ' ').toTitleCase(),
                      style: const TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 12,
                      ),
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }

  Color _getRoleColor(String role) {
    switch (role.toLowerCase()) {
      case 'admin':
        return Colors.red;
      case 'manager':
        return Colors.blue;
      case 'team_lead':
        return Colors.green;
      case 'doer':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  String _formatLastActive(DateTime lastActive) {
    final now = DateTime.now();
    final difference = now.difference(lastActive);

    if (difference.inDays > 30) {
      return '${(difference.inDays / 30).floor()} months ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minutes ago';
    } else {
      return 'Just now';
    }
  }
}

class ProfileScreenWidgetLoading extends DLShimmerWidget {
  const ProfileScreenWidgetLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Profile header shimmer
          Column(
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: buildShimmerBox(
                  height: 120,
                  width: 120,
                  borderRadius: 60,
                ),
              ),
              const SizedBox(height: 16),
              buildShimmerBox(
                height: 24,
                width: 200,
                borderRadius: 4,
              ),
              const SizedBox(height: 8),
              buildShimmerBox(
                height: 18,
                width: 180,
                borderRadius: 4,
              ),
              const SizedBox(height: 16),
              buildShimmerBox(
                height: 28,
                width: 100,
                borderRadius: 14,
              ),
            ],
          ),
          const SizedBox(height: 32),
          // Section title shimmer
          buildShimmerBox(
            height: 20,
            width: 180,
            borderRadius: 4,
          ),
          const SizedBox(height: 16),
          // Info card shimmer
          _buildShimmerCard(
            children: [
              _buildShimmerInfoRow(),
              const SizedBox(height: 16),
              _buildShimmerDivider(),
              const SizedBox(height: 16),
              _buildShimmerInfoRow(),
            ],
          ),
          const SizedBox(height: 32),
          // Section title shimmer
          buildShimmerBox(
            height: 20,
            width: 150,
            borderRadius: 4,
          ),
          const SizedBox(height: 16),
          // Modules list shimmer
          _buildShimmerCard(
            children: [
              _buildShimmerModuleItem(),
              const SizedBox(height: 16),
              _buildShimmerDivider(),
              const SizedBox(height: 16),
              _buildShimmerModuleItem(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerCard({required List<Widget> children}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: children),
      ),
    );
  }

  Widget _buildShimmerInfoRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildShimmerBox(
          height: 16,
          width: 100,
          borderRadius: 4,
        ),
        buildShimmerBox(
          height: 16,
          width: 120,
          borderRadius: 4,
        ),
      ],
    );
  }

  Widget _buildShimmerModuleItem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildShimmerBox(
          height: 16,
          width: 150,
          borderRadius: 4,
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            buildShimmerBox(
              height: 24,
              width: 80,
              borderRadius: 12,
            ),
            const SizedBox(width: 8),
            buildShimmerBox(
              height: 24,
              width: 100,
              borderRadius: 12,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildShimmerDivider() {
    return Container(
      height: 1,
      color: Colors.grey[200],
    );
  }
}

extension StringExtension on String {
  String toTitleCase() {
    if (isEmpty) return this;
    return split(' ')
        .map((word) => word.isNotEmpty
            ? '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}'
            : '')
        .join(' ');
  }
}
