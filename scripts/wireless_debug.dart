#!/usr/bin/env dart

import 'dart:io';
import 'dart:async';

void main(List<String> arguments) async {
  print('🚀 Wireless Debugging Setup for Android 🚀\n');
  
  // Check if ADB is available in PATH or common locations
  String? adbPath = await _findAdb();
  if (adbPath == null) {
    print('❌ ADB not found in PATH or common locations.');
    print('   Please do one of the following:');
    print('   1. Add ADB to your PATH');
    print('   2. Place platform-tools in your Downloads folder');
    print('   3. Specify the full path to ADB when prompted');
    print('\n   Download Android Platform Tools from:');
    print('   https://developer.android.com/studio/releases/platform-tools');
    
    stdout.write('\n   Enter the full path to ADB (or press Enter to exit): ');
    final customPath = stdin.readLineSync()?.trim();
    
    if (customPath == null || customPath.isEmpty) {
      exit(1);
    }
    
    if (!await File(customPath).exists()) {
      print('❌ ADB not found at: $customPath');
      exit(1);
    }
    
    adbPath = customPath;
  } else {
    print('✅ Found ADB at: $adbPath');
  }
  
  // Set the full path to ADB for all commands
  adbPath = _getFullAdbPath(adbPath);

  print('✅ ADB is installed');

  // Check for any connected devices (wired or wireless)
  final deviceList = await _runCommand('$adbPath devices');
  final devices = deviceList.split('\n').where((line) => line.contains('\t')).toList();
  
  if (devices.isNotEmpty) {
    print('\n📱 Connected devices:');
    devices.forEach(print);
  }

  print('\n🔍 Starting wireless debugging setup...');
  print('   Make sure you have:');
  print('   1. Developer options enabled on your device');
  print('   2. Wireless debugging enabled in Developer options');
  print('   3. Your phone and computer are on the same Wi-Fi network');

  // Get IP address from user
  stdout.write('\n🌐 Enter your device IP address (e.g., 192.168.1.21): ');
  final ipAddress = stdin.readLineSync()?.trim();
  
  if (ipAddress == null || ipAddress.isEmpty) {
    print('❌ IP address is required');
    exit(1);
  }

  // Set up wireless debugging
  print('\n🔌 Setting up wireless debugging...');
  print('   1. On your device, go to Developer options');
  print('   2. Make sure "Wireless debugging" is enabled');
  print('   3. Tap "Wireless debugging"');
  print('   4. Note the IP address and port shown (e.g., 192.168.1.21:43563)');
  print('   5. Note the pairing code (e.g., 618464)');
  print('\nPlease enter the following details:');

  // Get pairing port and code from user
  stdout.write('\n   Enter the port number from your device (e.g., 43563): ');
  final port = stdin.readLineSync()?.trim() ?? '';
  
  stdout.write('   Enter the pairing code (e.g., 618464): ');
  final code = stdin.readLineSync()?.trim() ?? '';

  if (port.isEmpty || code.isEmpty) {
    print('\n❌ Invalid port or code. Please try again.');
    exit(1);
  }

  // Pair the device
  print('\n🤝 Pairing device...');
  try {
    print('Running: $adbPath pair $ipAddress:$port $code');
    final result = await Process.run(
      adbPath,
      ['pair', '$ipAddress:$port', code],
      runInShell: true,
    );
    
    print('Pairing output:');
    print(result.stdout);
    if (result.stderr != null && result.stderr.toString().isNotEmpty) {
      print('Error: ${result.stderr}');
    }
    
    if (result.exitCode == 0) {
      print('✅ Device paired successfully!');
    } else {
      throw Exception('Pairing failed');
    }
  } catch (e) {
    print('❌ Failed to pair device. Error: $e');
    print('Please check:');
    print('1. The IP address and port are correct');
    print('2. The pairing code is correct');
    print('3. Your phone and computer are on the same Wi-Fi network');
    exit(1);
  }

  // Connect to the device
  print('\n🔗 Connecting to device wirelessly...');
  try {
    await _runCommand('$adbPath connect $ipAddress:5555');
    print('✅ Connected successfully!');
  } catch (e) {
    print('❌ Failed to connect. Make sure your device is on the same network.');
    exit(1);
  }

  print('\n🎉 Wireless debugging is now set up!');
  print('   You can now unplug your device and debug wirelessly.');
  print('   To connect in the future, just run: adb connect $ipAddress:5555');
  print('\nHappy coding! 🚀');
}

Future<String?> _findAdb() async {
  // Check common ADB locations
  final commonPaths = [
    'adb', // Check if in PATH
    '/Users/${Platform.environment['USER']}/Library/Android/sdk/platform-tools/adb',
    '${Platform.environment['HOME']}/Library/Android/sdk/platform-tools/adb',
    '/Users/${Platform.environment['USER']}/Downloads/platform-tools/adb',
    '${Platform.environment['HOME']}/Downloads/platform-tools/adb',
    '/usr/local/bin/adb',
    '/usr/bin/adb',
  ];

  for (final path in commonPaths) {
    try {
      final result = await Process.run('which', [path]);
      if (result.exitCode == 0) {
        return path;
      }
      // Try direct execution
      final result2 = await Process.run(path, ['--version']);
      if (result2.exitCode == 0) {
        return path;
      }
    } catch (e) {
      continue;
    }
  }
  return null;
}

String _getFullAdbPath(String adbPath) {
  // If it's already a full path, return as is
  if (adbPath.startsWith('/')) {
    return adbPath;
  }
  
  // If it's just 'adb', try to find the full path
  if (adbPath == 'adb') {
    final whichResult = Process.runSync('which', ['adb']);
    if (whichResult.exitCode == 0) {
      return whichResult.stdout.toString().trim();
    }
  }
  
  return adbPath;
}

Future<String> _runCommand(String command, {String? customAdbPath}) async {
  // Use custom ADB path if provided
  String executable = command.split(' ')[0];
  List<String> args = command.split(' ').sublist(1);
  
  if (executable == 'adb' && customAdbPath != null) {
    executable = customAdbPath;
  }
  
  final result = await Process.run(
    executable,
    args,
    runInShell: true,
  );

  if (result.exitCode != 0) {
    throw Exception('Command failed: $command\n${result.stderr}');
  }

  return result.stdout.toString().trim();
}
