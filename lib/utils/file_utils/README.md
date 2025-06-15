# File Utils Module

This module provides utilities for handling file operations, image picking, and file picking in the Digilex Mobile application.

## Features

- Image picking from gallery and camera
- Image cropping with customizable aspect ratios
- File picking with multiple format support
- File viewing capabilities
- Android manifest setup automation

## Components

### File Picker (`file_picker.dart`)

Provides functionality for:
- Picking images from gallery or camera
- Cropping images with customizable aspect ratios
- Picking files of various types (PDF, DOC, Audio, Image, GIF, Video)
- Handling file dimensions and metadata

### File Viewer (`file_viewer.dart`)

Provides functionality for:
- Viewing different types of files
- Handling file previews
- Managing file display formats

### Android Manifest Setup (`setup_android_manifest.dart`)

Provides functionality for:
- Automating Android manifest configuration for image cropper
- Creating necessary style files
- Adding UCropActivity to AndroidManifest.xml

## Usage Examples

### Image Picking with Cropping

```dart
import 'package:your_app/utils/file_utils/file_picker.dart';

// Pick and crop an image
final pickedFile = await pickImageOrFile(
  isImageCropper: true,
);

// Access the picked file properties
if (pickedFile != null) {
  final String? path = pickedFile.path;
  final String? name = pickedFile.name;
  final Uint8List? bytes = pickedFile.bytes;
  final MediaDimensions? dimensions = pickedFile.dimensions;
}
```

### File Picking

```dart
// Pick specific file types
final pickedFile = await pickImageOrFile(
  isFileOption: true,
  typeOfFileSelect: [FileTypeSelect.pdf, FileTypeSelect.audio],
);

// Pick any file type
final pickedFile = await pickImageOrFile(
  isFileOption: true,
  typeOfFileSelect: [FileTypeSelect.other],
);
```

### Setting Up Android Manifest

You can use the provided Dart script to automate the Android manifest setup:

```dart
// Run from the command line
dart lib/utils/file_utils/setup_android_manifest.dart

// Or import and use in your code
import 'package:your_app/utils/file_utils/setup_android_manifest.dart';

void setupAndroidManifest() {
  final setup = AndroidManifestSetup();
  setup.run();
}
```

## Platform Configuration

### Android

1. Add the following activity to your `android/app/src/main/AndroidManifest.xml`:

```xml
<activity
    android:name="com.yalantis.ucrop.UCropActivity"
    android:screenOrientation="portrait"
    android:theme="@style/Ucrop.CropTheme"/>
```

2. Create or modify `android/app/src/main/res/values/styles.xml`:

```xml
<resources>
    <style name="Ucrop.CropTheme" parent="Theme.AppCompat.Light.NoActionBar"/>
</resources>
```

3. Create `android/app/src/main/res/values-v35/styles.xml`:

```xml
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <style name="Ucrop.CropTheme" parent="Theme.AppCompat.Light.NoActionBar">
        <item name="android:windowOptOutEdgeToEdgeEnforcement">true</item>
    </style>
</resources>
```

### iOS

No additional configuration required.

### Web

Add the following code inside the `<head>` tag in `web/index.html`:

```html
<!-- cropperjs -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/cropperjs/1.6.2/cropper.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/cropperjs/1.6.2/cropper.min.js"></script>
```

## Dependencies

Add these dependencies to your `pubspec.yaml`:

```yaml
dependencies:
  image_picker: ^1.1.2
  image_cropper: ^9.0.0
  file_picker: ^9.0.0
  path:   # Required for setup_android_manifest.dart
```