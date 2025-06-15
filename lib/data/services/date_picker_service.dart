import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DatePickerService {
  static Future<DateTime?> pickDate({
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
  }) async {
    final DateTime? picked = await showDatePicker(
      context: Get.context!,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: firstDate ?? DateTime(2000),
      lastDate: lastDate ?? DateTime(2100),
    );
    return picked;
  }

  static Future<DateTimeRange?> pickDateRange({
    DateTimeRange? initialDateRange,
    DateTime? firstDate,
    DateTime? lastDate,
  }) async {
    DateTime? startDate = initialDateRange?.start;
    DateTime? endDate = initialDateRange?.end;

    final result = await showModalBottomSheet<DateTimeRange?>(
      context: Get.context!,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => SizedBox(
        height: MediaQuery.of(context).size.height * 0.7,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Select Date Range',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      if (startDate != null && endDate != null) {
                        Navigator.pop(context,
                            DateTimeRange(start: startDate!, end: endDate!));
                      }
                    },
                    child: const Text('Done'),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: SfDateRangePicker(
                selectionMode: DateRangePickerSelectionMode.range,
                initialSelectedRange: startDate != null && endDate != null
                    ? PickerDateRange(startDate, endDate)
                    : null,
                onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                  if (args.value is PickerDateRange) {
                    startDate = args.value.startDate;
                    endDate = args.value.endDate ?? args.value.startDate;
                  }
                },
                initialDisplayDate: startDate ?? DateTime.now(),
                minDate: firstDate ?? DateTime(2000),
                maxDate: lastDate ?? DateTime(2100),
                monthViewSettings: const DateRangePickerMonthViewSettings(
                  firstDayOfWeek: 1,
                ),
                selectionShape: DateRangePickerSelectionShape.rectangle,
                selectionColor: Theme.of(context).primaryColor,
                selectionTextStyle: const TextStyle(color: Colors.white),
                todayHighlightColor: Theme.of(context).primaryColor,
                toggleDaySelection: true,
              ),
            ),
          ],
        ),
      ),
    );

    return result;
  }

  static String formatDate(DateTime date, {String format = 'dd/MM/yyyy'}) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }
}

extension DateTimeExtension on DateTime {
  String displayFormat() {
    return DateFormat('dd/MM/yyyy').format(this);
  }
}
