import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'dart:typed_data';

//  Add this package into your  pubspec.yaml
//  dependencies:
// image_picker: ^1.1.2
//   image_cropper: ^9.0.0
//   file_picker: ^9.0.0

enum SourceType { gallery, camera }

enum FileTypeSelect { pdf, doc, audio, image, gif, video, other }

// class DLUploadedFile {
//   const DLUploadedFile({
//     this.name,
//     this.bytes,
//     this.height,
//     this.width,
//     this.blurHash,
//     required this.path,
//   });

//   final String? name;
//   final Uint8List? bytes;
//   final double? height;
//   final double? width;
//   final String? blurHash;
//   final String path;

//   @override
//   String toString() =>
//       'DLUploadedFile(name: $name, bytes: ${bytes?.length ?? 0}, height: $height, width: $width, blurHash: $blurHash,)';

//   String serialize() => jsonEncode(
//         {
//           'name': name,
//           'bytes': bytes,
//           'height': height,
//           'width': width,
//           'blurHash': blurHash,
//           'path': path,
//         },
//       );

//   static DLUploadedFile deserialize(String val) {
//     final serializedData = jsonDecode(val) as Map<String, dynamic>;
//     final data = {
//       'name': serializedData['name'] ?? '',
//       'bytes': serializedData['bytes'] ?? Uint8List.fromList([]),
//       'height': serializedData['height'],
//       'width': serializedData['width'],
//       'blurHash': serializedData['blurHash'],
//       'path': serializedData['path'],
//     };
//     return DLUploadedFile(
//       name: data['name'] as String,
//       bytes: Uint8List.fromList(data['bytes'].cast<int>().toList()),
//       height: data['height'] as double?,
//       width: data['width'] as double?,
//       blurHash: data['blurHash'] as String?,
//       path: data['path'] as String,
//     );
//   }

//   @override
//   int get hashCode => Object.hash(
//         name,
//         bytes,
//         height,
//         width,
//         blurHash,
//         path,
//       );

//   @override
//   bool operator ==(other) =>
//       other is DLUploadedFile &&
//       name == other.name &&
//       bytes == other.bytes &&
//       height == other.height &&
//       width == other.width &&
//       blurHash == other.blurHash &&
//       path == other.path;
// }

class MediaDimensions {
  const MediaDimensions({
    this.height,
    this.width,
  });
  final double? height;
  final double? width;
}

class PickedFile {
  final String? path;
  final String? name;
  final Uint8List? bytes;
  final MediaDimensions? dimensions;
  final File? file;

  PickedFile({
    this.path,
    this.name,
    this.bytes,
    this.dimensions,
    this.file,
  });
}

Future<PickedFile?> pickImageOrFile({
  bool askSourceSelect = true,
  SourceType? selectFrom,
  bool isFileOption = false,
  List<FileTypeSelect> typeOfFileSelect = const [],
  double? maxWidth,
  double? maxHeight,
  int? imageQuality = 80,
  bool includeDimensions = false,
  bool isImageCropper = true,
}) async {
  if (isFileOption) {
    // File picking
    return await _pickFile(typeOfFileSelect);
  } else {
    // Image picking
    ImageSource? source;

    if (askSourceSelect) {
      final selectedSource = await _showImageSourceBottomSheet();
      if (selectedSource == null) {
        return null;
      }
      source = selectedSource == 'Gallery'
          ? ImageSource.gallery
          : ImageSource.camera;
    } else if (selectFrom != null) {
      source = selectFrom == SourceType.gallery
          ? ImageSource.gallery
          : ImageSource.camera;
    } else {
      return null;
    }

    // Pick the image
    final pickedImage = await _pickImage(
      source: source,
      maxWidth: maxWidth,
      maxHeight: maxHeight,
      imageQuality: imageQuality,
      cropImage: false, // Don't crop within _pickImage
      includeDimensions: includeDimensions,
    );

    // If image was picked and cropping is enabled, crop the image
    if (pickedImage != null && isImageCropper) {
      final File originalFile = File(pickedImage.path!);
      final croppedFile = await _cropImage(originalFile.path);

      if (croppedFile != null) {
        // Create a new file from the cropped image
        final File croppedImageFile = File(croppedFile.path);
        final Uint8List croppedBytes = await croppedImageFile.readAsBytes();

        // Get dimensions if requested
        MediaDimensions? dimensions;
        if (includeDimensions) {
          dimensions = await _getImageDimensions(croppedBytes);
        }

        return PickedFile(
          path: croppedFile.path,
          name: croppedFile.path.split('/').last,
          bytes: croppedBytes,
          dimensions: dimensions,
          file: croppedImageFile,
        );
      } else {
        // User cancelled cropping, return the original image
        return pickedImage;
      }
    }

    return pickedImage;
  }
}

Future<PickedFile?> _pickFile(List<FileTypeSelect> typeOfFileSelect) async {
  // Define allowed extensions based on selected file types
  List<String>? allowedExtensions;
  if (typeOfFileSelect.isNotEmpty) {
    allowedExtensions = [];

    for (var fileType in typeOfFileSelect) {
      switch (fileType) {
        case FileTypeSelect.pdf:
          allowedExtensions!.add('pdf');
          break;
        case FileTypeSelect.doc:
          allowedExtensions!.addAll(['doc', 'docx']);
          break;
        case FileTypeSelect.audio:
          allowedExtensions!.addAll(['mp3', 'wav', 'aac', 'm4a']);
          break;
        case FileTypeSelect.gif:
          allowedExtensions!.add('gif');
          break;
        case FileTypeSelect.image:
          allowedExtensions!.addAll(['jpg', 'jpeg', 'png']);
          break;
        case FileTypeSelect.video:
          allowedExtensions!.addAll(['mp4', 'mov', 'avi']);
          break;
        case FileTypeSelect.other:
          // Allow any extension by not specifying
          allowedExtensions = null;
          break;
      }
    }
  }

  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: allowedExtensions != null ? FileType.custom : FileType.any,
    allowedExtensions: allowedExtensions,
    withData: true,
  );

  if (result != null && result.files.isNotEmpty) {
    final pickedFile = result.files.first;

    if (pickedFile.bytes != null) {
      File? fileObj;
      if (pickedFile.path != null) {
        fileObj = File(pickedFile.path!);
      }

      return PickedFile(
        path: pickedFile.path,
        name: pickedFile.name,
        bytes: pickedFile.bytes,
        file: fileObj,
      );
    }
  }

  return null;
}

Future<PickedFile?> _pickImage({
  required ImageSource source,
  double? maxWidth,
  double? maxHeight,
  int? imageQuality,
  bool cropImage = false,
  bool includeDimensions = false,
}) async {
  final ImagePicker picker = ImagePicker();

  try {
    final XFile? pickedImage = await picker.pickImage(
      source: source,
      maxWidth: maxWidth,
      maxHeight: maxHeight,
      imageQuality: imageQuality,
    );

    if (pickedImage == null) {
      return null;
    }

    String path = pickedImage.path;

    // Crop image if requested (now managed at the parent function level)
    if (cropImage) {
      final croppedFile = await _cropImage(path);
      if (croppedFile != null) {
        path = croppedFile.path;
      } else {
        // User cancelled cropping
        return null;
      }
    }

    final File file = File(path);
    final Uint8List bytes = await file.readAsBytes();

    // Get dimensions if requested
    MediaDimensions? dimensions;
    if (includeDimensions) {
      dimensions = await _getImageDimensions(bytes);
    }

    return PickedFile(
      path: path,
      name: path.split('/').last,
      bytes: bytes,
      dimensions: dimensions,
      file: file,
    );
  } catch (e) {
    log('Error picking image: $e');
    return null;
  }
}

Future<String?> _showImageSourceBottomSheet() async {
  String? selectedSource;

  await Get.bottomSheet(
    Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Select Image Source',
            style: Get.textTheme.displaySmall,
          ),
          const SizedBox(height: 20),
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: const Text('Gallery'),
            onTap: () {
              selectedSource = 'Gallery';
              Get.back();
            },
          ),
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text('Camera'),
            onTap: () {
              selectedSource = 'Camera';
              Get.back();
            },
          ),
        ],
      ),
    ),
  );

  return selectedSource;
}

Future<CroppedFile?> _cropImage(String imagePath) async {
  List<CropAspectRatioPresetData> aspectRatioPresets = [
    CropAspectRatioPreset.square,
    CropAspectRatioPreset.ratio3x2,
    CropAspectRatioPreset.original,
    CropAspectRatioPreset.ratio4x3,
    CropAspectRatioPreset.ratio16x9,
  ];
  return await ImageCropper().cropImage(
    sourcePath: imagePath,
    // aspectRatio: CropAspectRatio,
    // aspectRatioPresets: [
    //   CropAspectRatioPreset.square,
    //   CropAspectRatioPreset.ratio3x2,
    //   CropAspectRatioPreset.original,
    //   CropAspectRatioPreset.ratio4x3,
    //   CropAspectRatioPreset.ratio16x9
    // ],
    compressQuality: 90,
    compressFormat: ImageCompressFormat.jpg,
    uiSettings: [
      AndroidUiSettings(
        toolbarTitle: 'Crop Image',
        toolbarColor: Colors.blue,
        toolbarWidgetColor: Colors.white,
        initAspectRatio: CropAspectRatioPreset.original,
        lockAspectRatio: false,
        activeControlsWidgetColor: Colors.blue,
        aspectRatioPresets: aspectRatioPresets,
      ),
      IOSUiSettings(
        title: 'Crop Image',
        minimumAspectRatio: 1.0,
        aspectRatioLockEnabled: false,
        resetAspectRatioEnabled: true,
        aspectRatioPickerButtonHidden: false,
        aspectRatioPresets: aspectRatioPresets,
      ),
    ],
  );
}

Future<MediaDimensions> _getImageDimensions(Uint8List mediaBytes) async {
  final image = await decodeImageFromList(mediaBytes);
  return MediaDimensions(
    width: image.width.toDouble(),
    height: image.height.toDouble(),
  );
}


// Use Guide
// // With cropping
// final pickedFile = await pickImageOrFile(
//   isImageCropper: true,
// );

// // Without cropping
// final pickedFile = await pickImageOrFile(
//   isImageCropper: false,
// );

// // Pick file
// final pickedFile = await pickImageOrFile(
//   isFileOption: true,
//   typeOfFileSelect: [FileTypeSelect.pdf, FileTypeSelect.audio],
// );

// // Pick file without type selection
// final pickedFile = await pickImageOrFile(
//   isFileOption: true,
// );

// // Pick file with all types
// final pickedFile = await pickImageOrFile(
//   isFileOption: true,
//   typeOfFileSelect: [FileTypeSelect.other],
// );

// // Pick file with all types and ask for source
// final pickedFile = await pickImageOrFile(
//   isFileOption: true,
//   typeOfFileSelect: [FileTypeSelect.other],
//   askSourceSelect: true,
// );

// // Pick file with all types and ask for source
// final pickedFile = await pickImageOrFile(
//   isFileOption: true,
//   typeOfFileSelect: [FileTypeSelect.other],
//   askSourceSelect: true,
//   selectFrom: SourceType.gallery,
// );

// // Pick file with all types and ask for source
// final pickedFile = await pickImageOrFile(
//   isFileOption: true,
//   typeOfFileSelect: [FileTypeSelect.other],
//   askSourceSelect: true,
//   selectFrom: SourceType.camera,
// );

// // Pick file with pdf , image and doc
// final pickedFile = await pickImageOrFile(
//   isFileOption: true,
//   typeOfFileSelect: [FileTypeSelect.pdf, FileTypeSelect.image, FileTypeSelect.doc],
// );

