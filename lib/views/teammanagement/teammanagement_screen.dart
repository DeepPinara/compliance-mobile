import 'package:compliancenavigator/data/services/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:compliancenavigator/data/models/user.dart';
import 'package:compliancenavigator/utils/pagination/pagination_list_view.dart';
import 'package:compliancenavigator/views/teammanagement/teammanagement_controller.dart';
import 'package:compliancenavigator/utils/pagination/infinite_scroll_view.dart'
    as pagination_mode;
import 'package:compliancenavigator/data/services/dialog_service/dialog_service.dart';

const String kTeammanagementRoute = '/teammanagement';

class TeammanagementScreen extends GetWidget<TeammanagementController> {
  const TeammanagementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TeammanagementController>(
      id: TeammanagementController.teammanagementScreenId,
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: const Text('Team Management'),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              tooltip: 'Refresh',
              onPressed: () => controller.refresh(),
            ),
          ],
        ),
        body: controller.isLoading && controller.items.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : PaginatedListView<TeammanagementController, User>(
                controller: controller,
                items: controller.items,
                itemBuilder: (context, user, index) =>
                    _buildUserCard(context, user, index),
                emptyWidget: const Center(
                  child: Text('No team members found'),
                ),
                padding: const EdgeInsets.all(16),
                loadingWidget: const Center(
                  child: CircularProgressIndicator(),
                ),
                initialLoadingWidget: const Center(
                  child: CircularProgressIndicator(),
                ),
                // separatorBuilder: (context, index) => const Divider(height: 1),
                physics: const BouncingScrollPhysics(),
                paginationMode: pagination_mode.PaginationMode.standard,
              ),
      ),
    );
  }

  String _getStatus(User user) {
    if (user.lastActivity != null) {
      final now = DateTime.now();
      final diff = now.difference(user.lastActivity!);
      if (diff.inMinutes < 10) return 'Active';
      return 'Inactive';
    }
    return 'Not-Log-In';
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'Active':
        return Colors.green.shade100;
      case 'Inactive':
        return Colors.orange.shade100;
      case 'Not-Log-In':
        return Colors.grey.shade300;
      default:
        return Colors.grey.shade200;
    }
  }

  Color _statusTextColor(String status) {
    switch (status) {
      case 'Active':
        return Colors.green.shade800;
      case 'Inactive':
        return Colors.orange.shade800;
      case 'Not-Log-In':
        return Colors.grey.shade800;
      default:
        return Colors.black;
    }
  }

  String _lastActiveText(DateTime? lastActivity) {
    if (lastActivity == null) return '-';
    final now = DateTime.now();
    final diff = now.difference(lastActivity);
    if (diff.inMinutes < 1) return 'a moment ago';
    if (diff.inMinutes < 60) return '${diff.inMinutes} minutes ago';
    if (diff.inHours < 24) return '${diff.inHours} hours ago';
    if (diff.inDays < 30) return '${diff.inDays} days ago';
    return '${lastActivity.day}/${lastActivity.month}/${lastActivity.year}';
  }

  // ignore: unused_element
  Widget _infoChip(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Colors.blueGrey),
          const SizedBox(width: 4),
          Text(text,
              style: const TextStyle(fontSize: 13, color: Colors.black87)),
        ],
      ),
    );
  }

  Widget _buildUserCard(BuildContext context, User user, int index) {
    final status = _getStatus(user);
    final statusColor = _statusColor(status);
    final statusTextColor = _statusTextColor(status);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          // Show team member details in bottom sheet
          DialogService.showTeamMemberDetails(
            user: user,
            context: context,
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar with status indicator
              Stack(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.blue.shade50,
                    child: Text(
                      user.userName.isNotEmpty
                          ? user.userName[0].toUpperCase()
                          : '?',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade700,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        color: statusColor,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              // User details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name and Role
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            user.userName,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: statusColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            status,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: statusTextColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    // Email
                    if (user.email.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Row(
                          children: [
                            Icon(Icons.email_outlined,
                                size: 14, color: Colors.grey.shade500),
                            const SizedBox(width: 6),
                            Text(
                              user.email,
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade700,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    // Last Activity
                    if (user.lastActivity != null)
                      Row(
                        children: [
                          Icon(Icons.access_time,
                              size: 14, color: Colors.grey.shade500),
                          const SizedBox(width: 6),
                          Text(
                            _lastActiveText(user.lastActivity),
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              // Action button
              IconButton(
                icon: Icon(Icons.more_vert, color: Colors.grey.shade500),
                onPressed: () {
                  // Show options menu
                  _showUserOptions(context, user);
                },
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                iconSize: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showUserOptions(BuildContext context, User user) {
    OptionBottomSheet.show(
      bottomSheetTitle: "User Options",
      options: [
        OptionItem(
          title: "Edit User",
          icon: Icons.edit,
          onTap: () {
            // Handle edit user
          },
        ),
        OptionItem(
          title: "Remove User",
          icon: Icons.delete,
          onTap: () {
            // Handle remove user
          },
        ),
      ],
    );

    // showModalBottomSheet(
    //   context: context,
    //   shape: const RoundedRectangleBorder(
    //     borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    //   ),
    //   builder: (context) => SafeArea(
    //     child: Column(
    //       mainAxisSize: MainAxisSize.min,
    //       children: [
    //         ListTile(
    //           leading: const Icon(Icons.edit),
    //           title: const Text('Edit User'),
    //           onTap: () {
    //             Navigator.pop(context);
    //             // Handle edit user
    //           },
    //         ),
    //         ListTile(
    //           leading: const Icon(Icons.delete, color: Colors.red),
    //           title: const Text('Remove User', style: TextStyle(color: Colors.red)),
    //           onTap: () {
    //             Navigator.pop(context);
    //             // Handle remove user
    //           },
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
