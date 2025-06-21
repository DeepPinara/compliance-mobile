import 'package:flutter/material.dart';

class ErrorState extends StatelessWidget {
  final String title;
  final String message;
  final String? assetPath;
  final VoidCallback onRetry;
  final String buttonText;

  const ErrorState({
    Key? key,
    required this.title,
    required this.message,
    required this.onRetry,
    this.assetPath,
    this.buttonText = 'Retry',
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
              )
            else
              Icon(
                Icons.error_outline,
                size: 64,
              ),
            const SizedBox(height: 16),
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: Text(buttonText),
              style: ElevatedButton.styleFrom(
                foregroundColor: Theme.of(context).scaffoldBackgroundColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
