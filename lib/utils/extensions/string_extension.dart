import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension StringExtension on String {
  // Capitalize the first letter of the string
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }

  // Check if string is a valid email
  bool get isEmail => RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
      ).hasMatch(this);

  // Check if string is a valid URL
  bool get isUrl => RegExp(
        r'^(https?:\/\/)?' // protocol
        r'((([a-z\d]([a-z\d-]*[a-z\d])*)\.)+[a-z]{2,}|' // domain name
        r'((\d{1,3}\.){3}\d{1,3}))' // OR ip (v4) address
        r'(\:\d+)?(\/[-a-z\d%_.~+]*)*' // port and path
        r'(\?[;&a-z\d%_.~+=-]*)?' // query string
        r'(\#[-a-z\d_]*)?\s*\$', // fragment locator
        caseSensitive: false,
        multiLine: false,
      ).hasMatch(this);

  // Parse string to DateTime
  DateTime? toDateTime() {
    try {
      return DateTime.parse(this).toLocal();
    } catch (e) {
      return null;
    }
  }


  // Format date string
  String formatDate({String format = 'dd MMM yyyy'}) {
    final date = toDateTime();
    if (date == null) return this;
    return DateFormat(format).format(date);
  }

  // Check if string is a valid phone number
  bool get isPhoneNumber {
    final phoneRegExp = RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$');
    return phoneRegExp.hasMatch(this);
  }

  // Convert string to Color
  Color toColor({Color fallback = Colors.black}) {
    try {
      // Handle #RGB or #RRGGBB format
      String hexColor = replaceAll('#', '');
      if (hexColor.length == 6 || hexColor.length == 8) {
        hexColor = 'FF$hexColor';
      } else if (hexColor.length == 3) {
        hexColor = 'FF${hexColor[0]}${hexColor[0]}${hexColor[1]}${hexColor[1]}${hexColor[2]}${hexColor[2]}';
      }
      return Color(int.parse(hexColor, radix: 16));
    } catch (e) {
      return fallback;
    }
  }

  // Truncate string with ellipsis
  String truncate({int maxLength = 50, String ellipsis = '...'}) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength)}$ellipsis';
  }
}
