// ignore_for_file: avoid_print
import 'dart:io';

/// A cross-platform script to build Flutter APKs in different modes
void main(List<String> arguments) async {
  final console = ConsoleHelper();
  
  try {
    // Parse build type from arguments or default to release
    String buildType = 'release';
    bool buildBundle = false;
    bool buildApk = true;
    bool buildSplit = false;
    
    // Process arguments
    for (final arg in arguments) {
      switch (arg) {
        case '--debug':
          buildType = 'debug';
          break;
        case '--profile':
          buildType = 'profile';
          break;
        case '--release':
          buildType = 'release';
          break;
        case '--bundle':
          buildBundle = true;
          break;
        case '--no-apk':
          buildApk = false;
          break;
        case '--split':
          buildSplit = true;
          break;
        case '--help':
          _printHelp(console);
          return;
        default:
          if (arg.startsWith('--')) {
            console.printWarning('Unknown option: $arg');
          }
      }
    }
    
    // Validate we're building something
    if (!buildApk && !buildBundle) {
      console.printError('Must build at least one of: APK or Bundle (AAB)');
      _printHelp(console);
      exit(1);
    }
    
    // Show what we're building
    console.printStatus('Building Flutter app in $buildType mode');
    
    if (buildApk) {
      if (buildSplit) {
        console.printStatus('Building split APKs');
        await console.runCommand('flutter', [
          'build', 
          'apk', 
          '--$buildType',
          '--split-per-abi',
        ]);
      } else {
        console.printStatus('Building single APK');
        await console.runCommand('flutter', [
          'build', 
          'apk', 
          '--$buildType',
        ]);
      }
      
      console.printStatus('APK build completed successfully!');
      console.printStatus('APK location: ${Directory.current.path}/build/app/outputs/flutter-apk/');
    }
    
    if (buildBundle) {
      console.printStatus('Building App Bundle (AAB)');
      await console.runCommand('flutter', [
        'build', 
        'appbundle', 
        '--$buildType',
      ]);
      
      console.printStatus('App Bundle build completed successfully!');
      console.printStatus('AAB location: ${Directory.current.path}/build/app/outputs/bundle/${buildType}Bundle/');
    }
    
    console.printStatus('Build process completed successfully!');
  } catch (e) {
    console.printError('An error occurred: $e');
    exit(1);
  }
}

/// Print help information
void _printHelp(ConsoleHelper console) {
  console.printStatus('Flutter Build Script - Usage:');
  print('flutter run scripts/flutter_build.dart [options]');
  print('');
  print('Options:');
  print('  --debug      Build in debug mode (default: release)');
  print('  --profile    Build in profile mode (default: release)');
  print('  --release    Build in release mode (default)');
  print('  --bundle     Build an Android App Bundle (AAB)');
  print('  --no-apk     Skip building APK');
  print('  --split      Build split APKs (per ABI)');
  print('  --help       Show this help message');
  print('');
  print('Examples:');
  print('  flutter run scripts/flutter_build.dart');
  print('  flutter run scripts/flutter_build.dart --debug');
  print('  flutter run scripts/flutter_build.dart --release --split');
  print('  flutter run scripts/flutter_build.dart --bundle --no-apk');
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
