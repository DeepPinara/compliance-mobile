import 'package:compliancenavigator/data/models/contractor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:compliancenavigator/data/models/user.dart';
import 'package:compliancenavigator/data/services/bottom_sheet.dart';
import 'package:compliancenavigator/utils/constants.dart';

/// Service to handle dialog and alert messages throughout the app
class DialogService {
  /// Show a confirmation dialog with custom message and optional actions
  static Future<bool?> showConfirmationDialog({
    required String title,
    required String message,
    String confirmText = 'OK',
    String cancelText = 'Cancel',
    bool barrierDismissible = true,
  }) async {
    return await Get.dialog<bool>(
      AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: Text(cancelText),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: Text(confirmText),
          ),
        ],
      ),
      barrierDismissible: barrierDismissible,
    );
  }

  /// Show an alert dialog with a single action button
  static Future<void> showAlertDialog({
    required String title,
    required String message,
    String buttonText = 'OK',
    bool barrierDismissible = true,
  }) async {
    return await Get.dialog<void>(
      AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(buttonText),
          ),
        ],
      ),
      barrierDismissible: barrierDismissible,
    );
  }

  /// Show a custom dialog for schedule conflicts
  static Future<void> showScheduleConflictDialog({
    required String message,
    String buttonText = 'OK',
    bool barrierDismissible = true,
  }) async {
    return await Get.dialog<void>(
      AlertDialog(
        title: const Text('Schedule Conflict'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(buttonText),
          ),
        ],
      ),
      barrierDismissible: barrierDismissible,
    );
  }

  /// Show team member details in a bottom sheet with enhanced UI
  static Future<void> showTeamMemberDetails({
    required User user,
    required BuildContext context,
  }) async {
    await DLBaseBottomSheet.show(
      title: 'Team Member Details',
      child: SizedBox(
        height: Get.size.height * 0.8,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.kAppScreenSpacing,
            vertical: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Enhanced Profile Section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade50, Colors.blue.shade200],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.blue.shade200, width: 1),
                ),
                child: Column(
                  children: [
                    // Avatar with enhanced styling
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.shade200,
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 45,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.blue.shade600,
                          child: Text(
                            user.userName.isNotEmpty
                                ? user.userName[0].toUpperCase()
                                : '?',
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Name and status
                    Text(
                      user.userName,
                      style: Get.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      user.email,
                      style: Get.textTheme.bodyMedium?.copyWith(
                        color: Colors.grey.shade600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    // Status chip with enhanced styling
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: _getStatusColor(user),
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: _getStatusColor(user).withOpacity(0.3),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: _getStatusTextColor(user),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            _getStatusText(user),
                            style: TextStyle(
                              color: _getStatusTextColor(user),
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Details Section with cards
              _buildInfoCard(
                'Basic Information',
                [
                  _buildDetailRow(
                      Icons.badge_outlined, 'Role', _formatRole(user.role)),
                  _buildDetailRow(
                    Icons.calendar_today_outlined,
                    'Member Since',
                    _formatDate(user.createdAt),
                  ),
                  _buildDetailRow(
                    Icons.access_time,
                    'Last Active',
                    user.lastActivity != null
                        ? _formatLastActive(user.lastActivity)
                        : 'Never logged in',
                  ),
                  _buildDetailRow(
                    Icons.update,
                    'Last Updated',
                    _formatDate(user.updatedAt),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Permissions Section
              if (user.modules.isNotEmpty)
                _buildInfoCard(
                  'Permissions',
                  [
                    _buildPermissionsGrid(user.modules),
                  ],
                ),

              const SizedBox(height: 16),

              // Contractors Section - Enhanced
              if (user.assignedContractor != null &&
                  user.assignedContractor!.isNotEmpty)
                _buildContractorsSection(user.assignedContractor!),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _buildInfoCard(String title, List<Widget> children) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Get.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800,
            ),
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }

  static Widget _buildContractorsSection(List<Contractor> contractors) {

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange.shade200, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.shade50,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.business,
                  color: Colors.orange.shade700,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Assigned Contractors',
                      style: Get.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    Text(
                      '${contractors.length} contractor${contractors.length == 1 ? '' : 's'} assigned',
                      style: Get.textTheme.bodySmall?.copyWith(
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...contractors
              .map((contractor) => _buildContractorCard(contractor))
              .toList(),
        ],
      ),
    );
  }

  static Widget _buildContractorCard(Contractor contractor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.orange.shade100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.orange.shade100, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.orange.shade200,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.business_center,
                  color: Colors.orange.shade700,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      contractor.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.orange.shade200,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'Code: ${contractor.employeeCode}',
                        style: TextStyle(
                          color: Colors.orange.shade800,
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static Widget _buildPermissionsGrid(Map<String, List<String>> modules) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: modules.entries.map((entry) {
      final moduleName = entry.key;
      final permissions = entry.value;
      Color chipColor = Colors.green.shade100;
      Color textColor = Colors.green.shade800;

      if (permissions.isEmpty) {
        chipColor = Colors.grey.shade200;
        textColor = Colors.grey.shade700;
      }

      return Container(
        margin: const EdgeInsets.only(bottom: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Module header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: chipColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: textColor.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  Icon(
                    _getModuleIcon(moduleName),
                    size: 16,
                    color: textColor,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _formatModuleName(moduleName),
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${permissions.length} permission${permissions.length != 1 ? 's' : ''}',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            
            // Permissions list
            if (permissions.isNotEmpty) ...[
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: permissions.map((permission) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: textColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: textColor.withOpacity(0.3)),
                    ),
                    child: Text(
                      permission,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ] else ...[
              const SizedBox(height: 8),
              Text(
                'No permissions granted',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ],
        ),
      );
    }).toList(),
  );
}

  static IconData _getModuleIcon(String module) {
    switch (module.toLowerCase()) {
      case 'dashboard':
        return Icons.dashboard;
      case 'principals':
        return Icons.supervisor_account;
      case 'contractors':
        return Icons.business;
      case 'workers':
        return Icons.group;
      case 'wage_master':
        return Icons.payments;
      case 'compliance':
        return Icons.verified_user;
      case 'users':
        return Icons.people;
      default:
        return Icons.settings;
    }
  }

  static String _formatModuleName(String module) {
    return module
        .replaceAll('_', ' ')
        .split(' ')
        .map((word) =>
            word.isEmpty ? word : word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }

  static Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 18, color: Colors.blue.shade600),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Get.textTheme.bodySmall?.copyWith(
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: Get.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade800,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static String _formatDate(DateTime? date) {
    if (date == null) return 'N/A';
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  static String _formatRole(String role) {
    return role
        .replaceAll('_', ' ')
        .split(' ')
        .map((word) =>
            word.isEmpty ? word : word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }

  static String _formatLastActive(DateTime? lastActivity) {
    if (lastActivity == null) return 'Never';
    final now = DateTime.now();
    final difference = now.difference(lastActivity);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inDays < 30) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
    } else {
      return _formatDate(lastActivity);
    }
  }

  static String _getStatusText(User user) {
    if (user.lastActivity != null) {
      final now = DateTime.now();
      final diff = now.difference(user.lastActivity!);
      if (diff.inMinutes < 10) return 'Active';
      if (diff.inHours < 24) return 'Recently Active';
      return 'Inactive';
    }
    return 'Never Logged In';
  }

  static Color _getStatusColor(User user) {
    final status = _getStatusText(user);
    switch (status) {
      case 'Active':
        return Colors.green.shade100;
      case 'Recently Active':
        return Colors.orange.shade100;
      case 'Inactive':
        return Colors.red.shade100;
      case 'Never Logged In':
        return Colors.grey.shade200;
      default:
        return Colors.grey.shade200;
    }
  }

  static Color _getStatusTextColor(User user) {
    final status = _getStatusText(user);
    switch (status) {
      case 'Active':
        return Colors.green.shade800;
      case 'Recently Active':
        return Colors.orange.shade800;
      case 'Inactive':
        return Colors.red.shade800;
      case 'Never Logged In':
        return Colors.grey.shade700;
      default:
        return Colors.grey.shade700;
    }
  }
}
