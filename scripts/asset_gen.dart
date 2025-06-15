// ignore_for_file: avoid_print

import 'dart:io';

void main() async {
  // Define directories to scan
  final directories = ['assets/images', 'assets/svgs','assets/jsons'];
  const outputFile = 'lib/utils/images.dart';

  // Store all asset paths
  final List<String> assetPaths = [];

  // Scan directories for assets
  for (final dir in directories) {
    final directory = Directory(dir);
    if (await directory.exists()) {
      await for (final entity in directory.list(recursive: false)) {
        if (entity is File) {
          final path =
              entity.path.replaceAll('\\', '/'); // Normalize path separators
          assetPaths.add(path);
        }
      }
    }
  }

  // Generate constant declarations
  final StringBuffer code = StringBuffer();

  // Add file header
  code.writeln('// Generated file. Do not edit.');
  code.writeln('// Generated on ${DateTime.now()}');
  code.writeln();

  // Generate constants for each asset
  for (final path in assetPaths.sorted()) {
    final name = _generateConstantName(path);
    code.writeln("const String $name = '$path';");
  }

  // Write to file
  final file = File(outputFile);
  await file.writeAsString(code.toString());

  // Print generated constants
  print('\x1B[32m Generated asset constants in $outputFile');
}

String _generateConstantName(String path) {
  // Remove 'assets/' prefix and file extension
  final name = path
      .replaceFirst('assets/', '')
      .replaceAll(RegExp(r'\.(png|jpg|jpeg|svg|gif|json|lottie)$'), '');

  // Convert path segments to camelCase
  final segments = name.split('/');
  final constantName = segments.map((segment) {
    // Replace spaces with underscores first
    final processedSegment = segment.replaceAll(' ', '_');
    
    // Now split by underscores and convert to camelCase
    final words = processedSegment
        .split('_')
        .where((word) => word.isNotEmpty) // Skip empty segments
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join('');
    return words;
  }).join('');

  // Add 'd' prefix and ensure first character after 'd' is uppercase
  return 'd$constantName';
}

extension on List<String> {
  List<String> sorted() {
    final copy = List<String>.from(this);
    copy.sort();
    return copy;
  }
}

//  assets:
    // - assets/svgs/
    // - assets/images/

// How to use this script
// 1. Create a new folder in out side of lib and name as scripts
// 2. Add this file in scripts folder
// 3. Add code in pubspec.yaml file
// flutter:
//   assets:
//     - assets/svgs/
//     - assets/images/
// 4. Add your all images and svg in respective -> assets folder
// 5. Run this command in terminal
// 6  dart run scripts/asset_gen.dart
// 7. Check the lib/utils/images.dart file for generated code
