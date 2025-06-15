// ignore_for_file: avoid_print

import 'dart:io';

/// A cross-platform script to clean and refresh Flutter project dependencies
void main() async {
  final console = ConsoleHelper();
  
  try {
    // Clean Flutter project
    console.printStatus('Cleaning Flutter project');
    await console.runCommand('flutter', ['clean']);

    // Clear pub cache
    console.printStatus('Clearing Dart packages cache');
    await console.runCommand('flutter', ['pub', 'cache', 'clean']);

    // Get packages
    console.printStatus('Getting packages');
    await console.runCommand('flutter', ['pub', 'get']);

    // iOS-specific handling for macOS
    if (Platform.isMacOS) {
      if (await Directory('ios').exists()) {
        console.printStatus('Cleaning iOS build');
        
        // Check if CocoaPods is installed
        final podResult = await Process.run('which', ['pod']);
        if (podResult.exitCode != 0) {
          console.printWarning('CocoaPods is not installed. Skipping pod steps.');
        } else {
          // Run pod deintegrate
          console.printStatus('Deintegrating pods');
          final deintegrateResult = await console.runCommand('pod', ['deintegrate'], workingDirectory: 'ios');
          if (!deintegrateResult) {
            console.printWarning('Pod deintegrate failed, continuing anyway');
          }
          
          // Run pod install
          console.printStatus('Installing pods');
          await console.runCommand('pod', ['install'], workingDirectory: 'ios');
        }
      } else {
        console.printWarning('No iOS directory found, skipping iOS cleanup');
      }
    }

    // Android-specific handling - FIXED THIS PART
    if (await Directory('android').exists()) {
      console.printStatus('Cleaning Android build');
      
      const androidDir = 'android';
      final gradleExecutable = Platform.isWindows ? 'gradlew.bat' : './gradlew';
      
      // Check if the gradlew file exists in the android directory
      final gradlewFile = File('$androidDir/${Platform.isWindows ? 'gradlew.bat' : 'gradlew'}');
      
      if (await gradlewFile.exists()) {
        // Make sure gradlew is executable on Unix systems
        if (!Platform.isWindows) {
          try {
            await Process.run('chmod', ['+x', 'gradlew'], workingDirectory: androidDir);
          } catch (e) {
            console.printWarning('Failed to make gradlew executable: $e');
          }
        }
        
        // Run gradlew clean with the correct working directory
        await console.runCommand(
          gradleExecutable,
          ['clean'],
          workingDirectory: androidDir
        );
      } else {
        console.printWarning('No gradlew found at ${gradlewFile.path}, skipping Android gradle clean');
      }
    } else {
      console.printWarning('No Android directory found, skipping Android cleanup');
    }

    // Delete .dart_tool directory
    final dartToolDir = Directory('.dart_tool');
    if (await dartToolDir.exists()) {
      console.printStatus('Removing .dart_tool directory');
      try {
        await dartToolDir.delete(recursive: true);
      } catch (e) {
        console.printWarning('Failed to remove .dart_tool directory: $e');
      }
    }

    // Run pub get again to ensure everything is set up correctly
    console.printStatus('Running flutter pub get again to ensure setup');
    await console.runCommand('flutter', ['pub', 'get']);

    console.printStatus('Clean completed successfully!');
    console.printStatus('Your project has been cleaned and packages reinstalled.');
  } catch (e) {
    console.printError('An error occurred: $e');
    exit(1);
  }
}

/// Helper class for console operations
class ConsoleHelper {
  // ANSI color codes
  static const String _green = '\x1B[32m';
  static const String _yellow = '\x1B[33m';
  static const String _blue = '\x1B[34m';
  static const String _red = '\x1B[31m';
  static const String _reset = '\x1B[0m';

  /// Print a status message
  void printStatus(String message) {
    print('$_blue==> $_green$message$_reset');
  }

  /// Print a warning message
  void printWarning(String message) {
    print('$_yellow⚠️ WARNING: $message$_reset');
  }

  /// Print an error message
  void printError(String message) {
    print('$_red❌ ERROR: $message$_reset');
  }

  /// Run a command and print output
  Future<bool> runCommand(String executable, List<String> arguments, {String? workingDirectory}) async {
    printStatus('Running: $executable ${arguments.join(' ')}');
    
    try {
      final process = await Process.start(
        executable, 
        arguments,
        workingDirectory: workingDirectory,
        mode: ProcessStartMode.inheritStdio,
      );
      
      final exitCode = await process.exitCode;
      if (exitCode != 0) {
        printWarning('Command exited with code $exitCode');
        return false;
      }
      return true;
    } catch (e) {
      printWarning('Failed to execute command: $e');
      return false;
    }
  }
}

// how to use this script
// 1. Save this script to your Flutter project root directory as flutter_clean.dart
// 2. Open a terminal and navigate to your project directory
// 3. Run the script using the following command:
//    dart flutter_clean.dart // if outside scripts folder
//    dart scripts/flutter_clean.dart // if inside scripts folder
// 4. The script will clean your project and reinstall dependencies
// 5. You can now run your project as usual
// 6. If you encounter any issues, please check the output for error messages

// this file use for 

// 1. Clean Flutter project
// 2. Clear pub cache
// 3. Get packages
// 4. iOS-specific handling for macOS
// 5. Android-specific handling
// 6. Delete .dart_tool directory
// 7. Run pub get again to ensure everything is set up correctly
// 8. Print status, warning, error messages
