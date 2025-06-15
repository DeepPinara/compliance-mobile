import 'package:compliancenavigator/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

void showSnackBar(
  String message, {
  bool isSuccess = false,
  Color textColor = Colors.white,
  Duration duration = const Duration(seconds: 3),
  String title = 'Message',
}) {
  Get.snackbar(
    '',
    message,
    titleText: const SizedBox.shrink(),
    messageText: Text(
      message,
    ),
    snackPosition: SnackPosition.TOP,
    backgroundColor: isSuccess
        // ignore: deprecated_member_use
        ? AppColors.onPrimaryColor//.withOpacity(0.8) //Colors.green.withOpacity(0.2)
        // ignore: deprecated_member_use
        : AppColors.warningColor.withOpacity(0.8), //Colors.grey.withOpacity(0.2)
    colorText: textColor,
    duration: duration,
    margin: const EdgeInsets.all(10),
    borderRadius: 8,
    snackStyle: SnackStyle.FLOATING,
  );

  // final snackBar = SnackBar(
  //   elevation: 0,
  //   behavior: SnackBarBehavior.floating,
  //   backgroundColor: Colors.transparent,
  //   margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
  //   duration: duration,
  //   content: AwesomeSnackbarContent(
  //     title: title,
  //     message: message,
  //     titleTextStyle: TextStyle(
  //       color: Colors.black,
  //       fontSize: 16,
  //       fontWeight: FontWeight.w600,
  //     ),
  //     messageTextStyle: TextStyle(
  //       color: Colors.black,
  //       fontSize: 14,
  //       fontWeight: FontWeight.w400,
  //     ),
  //     contentType: isSuccess ? ContentType.success : ContentType.failure,
  //     color: isSuccess
  //         // ignore: deprecated_member_use
  //         ? DLColors.onPrimaryColor//.withOpacity(0.8) //Colors.green.withOpacity(0.2)
  //         // ignore: deprecated_member_use
  //         : DLColors.warningColor.withOpacity(1), //Colors.grey.withOpacity(0.2)
  //     inMaterialBanner: true,
  //   ),
  // );

  // // Show the snackbar at the top
  // ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
}

// Function to show a material banner at the top
// void showTopBanner(
//   String message, {
//   bool isSuccess = false,
//   Duration duration = const Duration(seconds: 3),
//   String title = 'Message',
// }) {
//   final materialBanner = MaterialBanner(
//     backgroundColor: Colors.transparent,
//     elevation: 0,
//     forceActionsBelow: true,
//     content: AwesomeSnackbarContent(
//       title: title,
//       message: message,
//       contentType: isSuccess ? ContentType.success : ContentType.failure,
//       inMaterialBanner: true,
//     ),
//     actions: [
//       TextButton(
//         onPressed: () {
//           ScaffoldMessenger.of(Get.context!).hideCurrentMaterialBanner();
//         },
//         child: const Text('Dismiss'),
//       ),
//     ],
//   );

//   // Show the banner at the top
//   ScaffoldMessenger.of(Get.context!).showMaterialBanner(materialBanner);
  
//   // Auto-dismiss after duration
//   Future.delayed(duration, () {
//     if (Get.context != null) {
//       ScaffoldMessenger.of(Get.context!).hideCurrentMaterialBanner();
//     }
//   });
// }
