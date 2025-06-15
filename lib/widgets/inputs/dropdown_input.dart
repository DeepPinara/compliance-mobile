import 'package:flutter/material.dart';

class DropdownInput<T> extends StatelessWidget {
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final String label;
  final String? hint;
  final String? Function(T?)? validator;
  final bool isExpanded;
  final Widget? icon;
  final bool enabled;
  final EdgeInsetsGeometry? contentPadding;
  final Color? dropdownColor;
  final String? errorText;

  const DropdownInput({
    Key? key,
    required this.value,
    required this.items,
    required this.onChanged,
    required this.label,
    this.hint,
    this.validator,
    this.isExpanded = true,
    this.icon,
    this.enabled = true,
    this.contentPadding,
    this.dropdownColor,
    this.errorText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        color: theme.dividerColor,
        width: 1.0,
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
            color: theme.textTheme.bodyMedium?.color?.withOpacity(0.8),
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<T>(
          value: value,
          items: items,
          onChanged: enabled ? onChanged : null,
          isExpanded: isExpanded,
          icon: icon ??
              Icon(
                Icons.arrow_drop_down_rounded,
                color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
              ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: theme.textTheme.bodyMedium?.copyWith(
              color: theme.hintColor.withOpacity(0.7),
            ),
            border: border,
            enabledBorder: border,
            focusedBorder: border.copyWith(
              borderSide: BorderSide(
                color: theme.primaryColor,
                width: 1.5,
              ),
            ),
            errorBorder: border.copyWith(
              borderSide: BorderSide(
                color: theme.colorScheme.error,
                width: 1.5,
              ),
            ),
            focusedErrorBorder: border.copyWith(
              borderSide: BorderSide(
                color: theme.colorScheme.error,
                width: 1.5,
              ),
            ),
            filled: true,
            fillColor: !enabled
                ? theme.colorScheme.surfaceVariant.withOpacity(0.5)
                : theme.colorScheme.surface,
            contentPadding: contentPadding ??
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            errorText: errorText,
            errorMaxLines: 2,
            errorStyle: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.error,
              height: 1.2,
            ),
          ),
          style: theme.textTheme.bodyMedium?.copyWith(
            color: enabled
                ? theme.textTheme.bodyMedium?.color
                : theme.textTheme.bodyMedium?.color?.withOpacity(0.5),
          ),
          dropdownColor: dropdownColor ?? theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(8),
          menuMaxHeight: 300,
          selectedItemBuilder: (BuildContext context) {
            return items.map<Widget>((DropdownMenuItem<T> item) {
              return Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  item.value?.toString() ?? '',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.textTheme.bodyMedium?.color,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              );
            }).toList();
          },
        ),
      ],
    );
  }
}
