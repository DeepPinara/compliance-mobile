import 'package:compliancenavigator/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmptyState extends StatelessWidget {
  final String message;
  final IconData icon;
  final VoidCallback? onRetry;

  const EmptyState({
    super.key,
    required this.message,
    this.icon = Icons.inbox_outlined,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 70,
            color: AppColors.secondaryTextColor,
          ),
          const SizedBox(height: 20),
          Text(
            message,
            style: Get.textTheme.bodyLarge?.copyWith(
              color: AppColors.secondaryTextColor,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          if (onRetry != null) ...[
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: onRetry,
              child: const Text('Retry'),
            ),
          ],
        ],
      ),
    );
  }
}
