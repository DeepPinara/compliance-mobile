// ignore_for_file: avoid_print

import 'dart:io';

void main(List<String> args) {
  if (args.isEmpty) {
    print(
        'Please provide a name for the files. Example: dart generate.dart reset_password');
    return;
  }

  final String name = args[0].toLowerCase();
  final String className = toPascalCase(name);

  // Folder path
  final String folderPath = 'lib/views/$name';
  Directory(folderPath).createSync(recursive: true);

  // File paths
  final String controllerPath = '$folderPath/${name}_controller.dart';
  final String bindingPath = '$folderPath/${name}_binding.dart';
  final String screenPath = '$folderPath/${name}_screen.dart';

  // Content generation
  final String controllerContent = '''
import 'package:get/get.dart';

class ${className}Controller extends GetxController {

 static const String ${className.toLowerCase()}ScreenId = '${className}_screen';

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  // Add your controller logic here
}
''';

  final String bindingContent = '''
import 'package:get/get.dart';
import '${name}_controller.dart';

class ${className}Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<${className}Controller>(
      () => ${className}Controller(),
    );
  }
}
''';

  final String screenContent = '''
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '${name}_controller.dart';
import 'package:compliancenavigator/widgets/app_bar.dart';

  GetPage(
        name: k${className}Route,
        page: () => const ${className}Screen(),
        binding: ${className}Binding(),
        transition: AppConstants.kScreenTransitionType,
        transitionDuration: const Duration(milliseconds: AppConstants.kScreenTransitionDuration),
      )

const String k${className}Route = '/${name.replaceAll(r'_', '-')}';
class ${className}Screen extends GetWidget<${className}Controller> {
  const ${className}Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DLAppBar(
        title: '$className title',
      ),
      body: Center(
        child: const Text('Welcome to $className Screen!'),
      ),
    );
  }
}
''';

  // File creation
  writeFile(controllerPath, controllerContent);
  writeFile(bindingPath, bindingContent);
  writeFile(screenPath, screenContent);

  print('Files generated in $folderPath:');
  print('- ${name}_controller.dart');
  print('- ${name}_binding.dart');
  print('- ${name}_screen.dart');
}

void writeFile(String path, String content) {
  final file = File(path);
  file.writeAsStringSync(content);
  print('Created $path');
}

String toPascalCase(String text) {
  return text
      .split('_')
      .map((word) => word[0].toUpperCase() + word.substring(1))
      .join();
}


// How to use this script
// 1. Create a new folder in out side of lib and name as scripts
// 2. Add this file in scripts folder
// 3. Run this command in terminal
// dart scripts/class_gen.dart viewName
