import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  final String title;
  final String message;
  final String? assetPath;
  final VoidCallback? onRetry;
  final String? buttonText;

  const EmptyState({
    Key? key,
    required this.title,
    required this.message,
    this.assetPath,
    this.onRetry,
    this.buttonText = 'Try Again',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (assetPath != null)
              Image.asset(
                assetPath!,
                height: 120,
                width: 120,
                color: Theme.of(context).hintColor.withOpacity(0.5),
              )
            else
              Icon(
                Icons.inbox_outlined,
                size: 64,
                color: Theme.of(context).hintColor.withOpacity(0.5),
              ),
            const SizedBox(height: 16),
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).hintColor,
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).hintColor,
                  ),
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: onRetry,
                child: Text(buttonText!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
