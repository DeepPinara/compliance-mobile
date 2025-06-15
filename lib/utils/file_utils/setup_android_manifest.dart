import 'dart:io';
import 'package:path/path.dart' as path;

/// A utility class to set up Android manifest and styles for image cropper
class AndroidManifestSetup {
  /// Colors for console output
  static const String _red = '\x1B[31m';
  static const String _green = '\x1B[32m';
  static const String _yellow = '\x1B[33m';
  static const String _reset = '\x1B[0m';

  /// Project root directory
  late final String _projectRoot;
  
  /// Android manifest path
  late final String _androidManifest;
  
  /// Values directory path
  late final String _valuesDir;
  
  /// Values-v35 directory path
  late final String _valuesV35Dir;

  /// Constructor
  AndroidManifestSetup() {
    // Get the project root directory (assuming script is in lib/utils/file_utils)
    _projectRoot = _getProjectRoot();
    
    // Set paths
    _androidManifest = path.join(_projectRoot, 'android', 'app', 'src', 'main', 'AndroidManifest.xml');
    _valuesDir = path.join(_projectRoot, 'android', 'app', 'src', 'main', 'res', 'values');
    _valuesV35Dir = path.join(_projectRoot, 'android', 'app', 'src', 'main', 'res', 'values-v35');
  }

  /// Get the project root directory
  String _getProjectRoot() {
    // Get the current file's directory
    final currentDir = Directory.current.path;
    
    // Try to find the project root by looking for pubspec.yaml
    var rootDir = currentDir;
    while (rootDir != '/') {
      if (File(path.join(rootDir, 'pubspec.yaml')).existsSync()) {
        return rootDir;
      }
      rootDir = path.dirname(rootDir);
    }
    
    // If we can't find pubspec.yaml, fall back to the original logic
    return path.normalize(path.join(currentDir, '..', '..', '..', '..'));
  }

  /// Check if a file exists
  void _checkFile(String filePath) {
    if (!File(filePath).existsSync()) {
      _printError('Error: $filePath does not exist');
      exit(1);
    }
  }

  /// Create directory if it doesn't exist
  void _createDir(String dirPath) {
    if (!Directory(dirPath).existsSync()) {
      Directory(dirPath).createSync(recursive: true);
      _printSuccess('Created directory: $dirPath');
    }
  }

  /// Print error message
  void _printError(String message) {
    print('$_red$message$_reset');
  }

  /// Print success message
  void _printSuccess(String message) {
    print('$_green$message$_reset');
  }

  /// Print warning message
  void _printWarning(String message) {
    print('$_yellow$message$_reset');
  }

  /// Create or update styles.xml
  void _createStylesXml() {
    _printWarning('Creating/updating styles.xml...');
    
    final stylesXml = '''
<resources>
    <style name="Ucrop.CropTheme" parent="Theme.AppCompat.Light.NoActionBar"/>
</resources>
''';
    
    File(path.join(_valuesDir, 'styles.xml')).writeAsStringSync(stylesXml);
  }

  /// Create values-v35/styles.xml
  void _createValuesV35StylesXml() {
    _printWarning('Creating values-v35/styles.xml...');
    
    final stylesXml = '''<?xml version="1.0" encoding="utf-8"?>
<resources>
    <style name="Ucrop.CropTheme" parent="Theme.AppCompat.Light.NoActionBar">
        <item name="android:windowOptOutEdgeToEdgeEnforcement">true</item>
    </style>
</resources>
''';
    
    File(path.join(_valuesV35Dir, 'styles.xml')).writeAsStringSync(stylesXml);
  }

  /// Add UCropActivity to AndroidManifest.xml
  void _addUCropActivity() {
    final manifestFile = File(_androidManifest);
    final manifestContent = manifestFile.readAsStringSync();
    
    if (!manifestContent.contains('com.yalantis.ucrop.UCropActivity')) {
      _printWarning('Adding UCropActivity to AndroidManifest.xml...');
      
      // Insert UCropActivity before the closing </application> tag
      final updatedContent = manifestContent.replaceAll(
        '</application>',
        '''    <activity
        android:name="com.yalantis.ucrop.UCropActivity"
        android:screenOrientation="portrait"
        android:theme="@style/Ucrop.CropTheme"/>
</application>''',
      );
      
      manifestFile.writeAsStringSync(updatedContent);
      _printSuccess('Successfully added UCropActivity to AndroidManifest.xml');
    } else {
      _printSuccess('UCropActivity already exists in AndroidManifest.xml');
    }
  }

  /// Run the setup process
  void run() {
    // Check if Android manifest exists
    _checkFile(_androidManifest);
    
    // Create values directories if they don't exist
    _createDir(_valuesDir);
    _createDir(_valuesV35Dir);
    
    // Create or update styles.xml
    _createStylesXml();
    
    // Create values-v35/styles.xml
    _createValuesV35StylesXml();
    
    // Add UCropActivity to AndroidManifest.xml
    _addUCropActivity();
    
    _printSuccess('Setup completed successfully!');
    _printWarning('Please make sure to rebuild your Android project.');
  }
}

/// Main function to run the setup
void main() {
  final setup = AndroidManifestSetup();
  setup.run();
} 


// how to run this script
// 1. Save this script as setup_android_manifest.dart in lib/utils/file_utils
// 2. Open terminal and navigate to the directory where this script is located
// 3. Run the script using the command:
// dart run lib/utils/file_utils/setup_android_manifest.dart 
// 4. Follow the instructions in the terminal