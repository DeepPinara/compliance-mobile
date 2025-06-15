# Flutter Project Scripts

Cross-platform Dart scripts for managing Flutter project tasks.

## Scripts Included

This folder contains the following scripts:

1. **`flutter_clean.dart`** - Cleans and refreshes your Flutter project dependencies
2. **`flutter_build.dart`** - Builds APKs and App Bundles in different configurations

## Setup Instructions

1. Create a folder called `scripts` in your Flutter project root
2. Save both Dart files in the `scripts` folder

## Using the Scripts

### Clean Script

The clean script resets your project dependencies without building:

```bash
flutter run scripts/flutter_clean.dart
```

This script will:
- Clean the Flutter project
- Clear pub cache
- Get packages
- Handle iOS pod deintegration and reinstallation (macOS only)
- Clean Android Gradle builds
- Remove .dart_tool directory

### Build Script

The build script creates APKs or App Bundles with various options:

```bash
flutter run scripts/flutter_build.dart [options]
```

Available options:
- `--debug` - Build in debug mode
- `--profile` - Build in profile mode
- `--release` - Build in release mode (default)
- `--bundle` - Build an Android App Bundle (AAB)
- `--no-apk` - Skip building APK
- `--split` - Build split APKs (per ABI)
- `--help` - Show help message

Examples:
```bash
# Build a release APK (default behavior)
flutter run scripts/flutter_build.dart

# Build a debug APK
flutter run scripts/flutter_build.dart --debug

# Build split APKs for different ABIs in release mode
flutter run scripts/flutter_build.dart --release --split

# Build only an App Bundle (AAB) for Play Store
flutter run scripts/flutter_build.dart --bundle --no-apk
```

## Adding to pubspec.yaml (Optional)

For easier access, you can add script entries to your `pubspec.yaml`:

```yaml
# Add this section at the bottom of your pubspec.yaml
scripts:
  clean: flutter run scripts/flutter_clean.dart
  build: flutter run scripts/flutter_build.dart
  build_debug: flutter run scripts/flutter_build.dart --debug
  build_split: flutter run scripts/flutter_build.dart --split
  build_bundle: flutter run scripts/flutter_build.dart --bundle
```

Then run them with:

```bash
flutter pub run scripts:clean
flutter pub run scripts:build
```

## Requirements

No additional dependencies are required. The scripts use only Dart's standard library.
