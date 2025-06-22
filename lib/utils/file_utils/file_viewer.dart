import 'dart:io';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
// import 'package:http/http.dart' as http;
// import 'package:path_provider/path_provider.dart';

// const String kFileViewerRoute = '/file_viewer';

/// A widget for displaying PDF files and images.
/// Supports both local files and network URLs.
class FileViewer extends StatefulWidget {
  /// The path or URL to the file to be displayed
  final String source;

  /// Whether the source is a network URL
  final bool isNetwork;

  /// Optional loading widget to show while the file is being loaded
  final Widget? loadingWidget;

  /// Optional error widget to show when there's an error loading the file
  final Widget? errorWidget;

  const FileViewer({
    super.key,
    required this.source,
    this.isNetwork = false,
    this.loadingWidget,
    this.errorWidget,
  });

  @override
  State<FileViewer> createState() => _FileViewerState();
}

class _FileViewerState extends State<FileViewer> {
  String? _localPath;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _initializeFile();
  }

  Future<void> _initializeFile() async {
    try {
      if (widget.isNetwork) {
        final response = await http.get(Uri.parse(widget.source));
        if (response.statusCode == 200) {
          final directory = await getTemporaryDirectory();
          final fileName = widget.source.split('/').last;
          final file = File('${directory.path}/$fileName');
          await file.writeAsBytes(response.bodyBytes);
          setState(() {
            _localPath = file.path;
            _isLoading = false;
          });
        } else {
          setState(() {
            _error = 'Failed to download file: ${response.statusCode}';
            _isLoading = false;
          });
        }
      } else {
        _localPath = widget.source;
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  String _getFileExtension(String path) {
    return path.substring(path.lastIndexOf('.')).toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return widget.loadingWidget ??
          const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return widget.errorWidget ?? Center(child: Text('Error: $_error'));
    }

    if (_localPath == null) {
      return const Center(child: Text('No file to display'));
    }

    final extension = _getFileExtension(_localPath!);

    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      child: _buildViewer(extension),
    );
  }

  Widget _buildViewer(String extension) {
    switch (extension) {
      case '.pdf':
        // return  SfPdfViewer.file(
        //   File(_localPath!),
        //   enableDoubleTapZooming: true,
        //   enableTextSelection: true,
        //   pageSpacing: 8,
        //   onDocumentLoadFailed: (details) {
        //     setState(() {
        //       _error = details.description;
        //       _isLoading = false;
        //     });
        //   },
        // );

      case '.jpg':
      case '.jpeg':
      case '.png':
        return Expanded(
          child: PhotoView(
            imageProvider: FileImage(File(_localPath!)),
            minScale: PhotoViewComputedScale.contained * 0.8,
            maxScale: PhotoViewComputedScale.covered * 1.4,
            initialScale: PhotoViewComputedScale.contained,
            basePosition: Alignment.topCenter,
            backgroundDecoration: const BoxDecoration(color: Colors.white),
          ),
        );

      default:
        return const Center(
            child: Text(
                'Unsupported file type. Only PDF and images (jpg, jpeg, png) are supported.'));
    }
  }
}
