import 'package:compliancenavigator/themes/colors.dart';
import 'package:compliancenavigator/themes/text_field_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class DLDropDown<T> extends StatefulWidget {
  const DLDropDown({
    super.key,
    required this.items,
    this.selectedValue,
    this.selectedValues,
    required this.onChanged,
    this.onMultiChanged,
    this.label = '',
    this.hint = '',
    this.labelStyle,
    this.itemBuilder,
    this.isRequired = false,
    this.enabled = true,
    this.prefixIcon,
    this.fillColor,
    this.borderRadius,
    this.validator,
    this.height,
    this.errorMessage,
    this.isMultiSelect = false,
  });

  final List<T> items;
  final T? selectedValue;
  final List<T>? selectedValues;
  final Function(T?)? onChanged;
  final Function(List<T>)? onMultiChanged;
  final String label;
  final String hint;
  final TextStyle? labelStyle;
  final String Function(T)? itemBuilder;
  final bool isRequired;
  final bool enabled;
  final Widget? prefixIcon;
  final Color? fillColor;
  final BorderRadius? borderRadius;
  final String? Function(T?)? validator;
  final double? height;
  final String? errorMessage;
  final bool isMultiSelect;

  @override
  State<DLDropDown<T>> createState() => _DLDropDownState<T>();
}

class _DLDropDownState<T> extends State<DLDropDown<T>> {
  final FocusNode _focusNode = FocusNode();
  late List<T> _selectedValues;
  T? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.selectedValue;
    _selectedValues =
        widget.selectedValues != null ? List.from(widget.selectedValues!) : [];
  }

  @override
  void didUpdateWidget(DLDropDown<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.errorMessage != widget.errorMessage) {
      // Error state handling here if needed
    }

    if (oldWidget.selectedValue != widget.selectedValue) {
      _selectedValue = widget.selectedValue;
    }

    if (widget.selectedValues != null &&
        oldWidget.selectedValues != widget.selectedValues) {
      _selectedValues = List.from(widget.selectedValues!);
    }
  }

  // Display selected items as text
  String _getDisplayText() {
    if (_selectedValues.isEmpty) return '';

    if (_selectedValues.length <= 2) {
      return _selectedValues
          .map((item) => widget.itemBuilder?.call(item) ?? item.toString())
          .join(', ');
    } else {
      return '${_selectedValues.length} items selected';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.only(left: 5, bottom: 4),
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
        if (!widget.isMultiSelect)
          _buildSingleSelectDropdown()
        else
          _buildMultiSelectDropdown(),
      ],
    );
  }

  Widget _buildSingleSelectDropdown() {
    return DropdownButtonFormField<T>(
      isExpanded: true,
      value: _selectedValue,
      items: widget.items.map((T item) {
        return DropdownMenuItem<T>(
          value: item,
          child: Text(
            widget.itemBuilder?.call(item) ?? item.toString(),
            style: Get.textTheme.bodyMedium?.copyWith(
              fontSize: 13,
            ),
          ),
        );
      }).toList(),
      onChanged: widget.enabled
          ? (value) {
              _selectedValue = value;
              widget.onChanged?.call(value);
            }
          : null,
      focusNode: _focusNode,
      validator: (value) {
        if (widget.isRequired && (value == null)) {
          return 'Please select ${widget.label}';
        }
        return widget.validator?.call(value);
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: Get.textTheme.titleMedium,
      decoration: DLInputDecorationTheme.getDecoration(
        hint: widget.hint,
        // fillColor: widget.fillColor ?? AppColors.backgroundColor,
        // prefixIcon: widget.prefixIcon,
      ),
      icon: Icon(
        Icons.keyboard_arrow_down_rounded,
        color: Get.theme.colorScheme.primary,
      ),
      dropdownColor: AppColors.backgroundColor,
      borderRadius: widget.borderRadius ?? BorderRadius.circular(8),
      menuMaxHeight: 300,
    );
  }

  Widget _buildMultiSelectDropdown() {
    return FormField<List<T>>(
      initialValue: _selectedValues,
      validator: (values) {
        if (widget.isRequired && (values == null || values.isEmpty)) {
          return 'Please select at least one ${widget.label}';
        }
        return null;
      },
      builder: (FormFieldState<List<T>> state) {
        final isError = state.hasError;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: DLInputDecorationTheme.defaultHeight -
                  30, // Account for error text space
              decoration: BoxDecoration(
                color: widget.fillColor ?? AppColors.backgroundColor,
                borderRadius: widget.borderRadius ?? BorderRadius.circular(8),
                border: Border.all(
                  color: isError
                      ? AppColors.errorColor
                      : AppColors.textFieldBorderColor,
                  width: 1.0,
                ),
              ),
              child: DropdownButton2<T>(
                isExpanded: true,
                underline: const SizedBox(), // Remove default underline
                hint: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                  child: Text(
                    _selectedValues.isEmpty ? widget.hint : _getDisplayText(),
                    style: Get.textTheme.bodyMedium?.copyWith(
                      fontSize: 13,
                      color: AppColors.secondaryTextColor,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                items: widget.items.map((item) {
                  return DropdownMenuItem<T>(
                    value: item,
                    // Disable default onClick behavior to prevent menu from closing
                    enabled: false,
                    child: StatefulBuilder(
                      builder: (context, menuSetState) {
                        final isSelected = _selectedValues.contains(item);
                        return InkWell(
                          onTap: widget.enabled
                              ? () {
                                  if (isSelected) {
                                    _selectedValues.remove(item);
                                  } else {
                                    _selectedValues.add(item);
                                  }

                                  // Update the form field state
                                  state.didChange(_selectedValues);

                                  // Trigger validation
                                  state.validate();

                                  // Call the callback
                                  widget.onMultiChanged?.call(_selectedValues);

                                  // Rebuild the menu item
                                  menuSetState(() {});
                                }
                              : null,
                          child: Container(
                            height: 40,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Row(
                              children: [
                                Icon(
                                  isSelected
                                      ? Icons.check_box_outlined
                                      : Icons.check_box_outline_blank,
                                  color: Get.theme.colorScheme.primary,
                                  size: 20,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    widget.itemBuilder?.call(item) ??
                                        item.toString(),
                                    style: Get.textTheme.bodyMedium?.copyWith(
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }).toList(),
                // We provide a dummy onChanged because it's required, but actual changes
                // are handled in the InkWell's onTap
                onChanged: (_) {},
                buttonStyleData: const ButtonStyleData(
                  height: DLInputDecorationTheme.defaultHeight - 30,
                  width: double.infinity,
                  padding: EdgeInsets.only(left: 0, right: 8),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    // border: Border.none,
                  ),
                ),
                iconStyleData: IconStyleData(
                  icon: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: Get.theme.colorScheme.primary,
                  ),
                  iconSize: 24,
                ),
                dropdownStyleData: DropdownStyleData(
                  maxHeight: 300,
                  width: MediaQuery.of(context).size.width -
                      16, // Match the width of the parent
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.backgroundColor,
                    boxShadow: [
                      BoxShadow(
                        // ignore: deprecated_member_use
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  offset: const Offset(0, 0),
                  scrollbarTheme: ScrollbarThemeData(
                    radius: const Radius.circular(8),
                    thickness: WidgetStateProperty.all(6),
                    thumbVisibility: WidgetStateProperty.all(true),
                  ),
                ),
                menuItemStyleData: const MenuItemStyleData(
                  height: 40,
                  padding: EdgeInsets.zero,
                ),
              ),
            ),
            if (isError)
              Padding(
                padding: const EdgeInsets.only(left: 12, top: 6),
                child: Text(
                  state.errorText!,
                  style: Get.textTheme.bodySmall!.copyWith(
                    color: AppColors.errorColor,
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
