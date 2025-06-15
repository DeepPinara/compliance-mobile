import 'package:compliancenavigator/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:compliancenavigator/themes/colors.dart';
import 'package:get/get.dart';

class DLChips<T> extends StatefulWidget {
  const DLChips({
    super.key,
    required this.items,
    required this.selectedItems,
    required this.onSelectionChanged,
    this.label = '',
    this.isMultiSelect = true,
    this.isRequired = false,
    this.enabled = true,
    this.chipColor,
    this.selectedChipColor,
    this.labelStyle,
    this.borderRadius,
    this.isExpanded = false, // The new parameter for expanded chips
    this.onlyForTwo = false,
    this.padding = const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
  });

  final List<T> items; // List of items to display as chips
  final List<T> selectedItems; // Selected items
  final Function(List<T>) onSelectionChanged; // Callback when selection changes
  final String label;
  final bool isMultiSelect; // Allows multi-selection if true
  final bool isRequired; // Show "*" for required fields
  final bool enabled;
  final Color? chipColor;
  final Color? selectedChipColor;
  final TextStyle? labelStyle;
  final BorderRadius? borderRadius;
  final bool isExpanded; // This flag controls whether chips are expanded or not
  final bool onlyForTwo;
  final EdgeInsetsGeometry padding;

  @override
  State<DLChips<T>> createState() => _DLChipsState<T>();
}

class _DLChipsState<T> extends State<DLChips<T>> {
  List<T> _selectedItems = [];

  @override
  void initState() {
    super.initState();
    _selectedItems = List.from(widget.selectedItems);
  }

  void _onChipSelected(T item) {
    if (!widget.enabled) return;

    setState(() {
      if (widget.isMultiSelect) {
        if (_selectedItems.contains(item)) {
          _selectedItems.remove(item);
        } else {
          _selectedItems.add(item);
        }
      } else {
        _selectedItems = [item];
      }
    });

    widget.onSelectionChanged(_selectedItems);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.only(left: 7, bottom: 7),
            child: Row(
              children: [
                Text(
                  widget.label,
                  style: widget.labelStyle ??
                      Get.textTheme.bodyMedium?.copyWith(
                        color: AppColors.primaryTextColor,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                if (widget.isRequired)
                  Text(
                    ' *',
                    style: Get.textTheme.bodyMedium?.copyWith(
                      color: AppColors.primaryTextColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
              ],
            ),
          ),
        ],
        // Implementing isExpanded functionality
        if (widget.isExpanded)
          SizedBox(
            width: double.infinity, // Chips will occupy available width
            child: Wrap(
              spacing: 10,
              runSpacing: 8,
              children: widget.items.map((item) {
                final bool isSelected = _selectedItems.contains(item);
                return GestureDetector(
                  onTap: () => _onChipSelected(item),
                  child: Container(
                    width: widget.onlyForTwo
                        ? (Get.width - (AppConstants.kAppScreenSpacing * 3)) /
                            widget.items.length
                        : null,
                    padding: widget.padding,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? widget.selectedChipColor ??
                              Get.theme.colorScheme.primary
                          : Colors.transparent,
                      borderRadius:
                          widget.borderRadius ?? BorderRadius.circular(8),
                      border: Border.all(
                        color: isSelected
                            ? Get.theme.colorScheme.primary
                            : AppColors.textFieldBorderColor,
                        width: 1.5,
                      ),
                    ),
                    child: Text(
                      item.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: isSelected
                            ? Colors.white
                            : AppColors.primaryTextColor,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        // Fallback: Chips in a non-expanded manner, if needed
        if (!widget.isExpanded)
          Wrap(
            spacing: 10,
            runSpacing: 8,
            children: widget.items.map((item) {
              final bool isSelected = _selectedItems.contains(item);

              return GestureDetector(
                onTap: () => _onChipSelected(item),
                child: Container(
                  padding: widget.padding,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? widget.selectedChipColor ??
                            Get.theme.colorScheme.primary
                        : Colors.transparent,
                    borderRadius:
                        widget.borderRadius ?? BorderRadius.circular(8),
                    border: Border.all(
                      color: isSelected
                          ? Get.theme.colorScheme.primary
                          : AppColors.textFieldBorderColor,
                      width: 1.5,
                    ),
                  ),
                  child: Text(
                    item.toString(),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: isSelected
                          ? Colors.white
                          : AppColors.primaryTextColor,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
      ],
    );
  }
}
