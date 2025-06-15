import 'package:compliancenavigator/themes/colors.dart';
import 'package:compliancenavigator/themes/text_field_theme.dart';
import 'package:compliancenavigator/utils/images.dart';
import 'package:compliancenavigator/utils/validate.dart';
import 'package:compliancenavigator/widgets/image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

enum TextFieldType {
  text,
  email,
  password,
  confirmPassword,
  phone,
  number,
  search,
  date,
}

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    required this.controller,
    this.label = '',
    this.hint = '',
    this.onChanged,
    this.onSubmitted,
    this.onSearch,
    this.onTap,
    this.type = TextFieldType.text,
    this.passwordController,
    this.validator,
    this.maxCharacters,
    this.maxLines = 1,
    this.minLines = 1,
    this.readOnly = false,
    this.enabled = true,
    this.prefixIcon,
    this.suffixIcon,
    this.isRequired = false,
    this.errorMessage,
  });

  final TextEditingController controller;
  final TextEditingController? passwordController;
  final String? label;
  final String hint;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final Function(String)? onSearch;
  final VoidCallback? onTap;
  final TextFieldType type;
  final String? Function(String?)? validator;
  final int? maxCharacters;
  final int maxLines;
  final int minLines;
  final bool readOnly;
  final bool enabled;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool isRequired;
  final String? errorMessage; // Custom error message to display

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _obscureText = true;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(AppTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.errorMessage != widget.errorMessage) {}
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _validateField(String value) {
    final validator = widget.validator ?? _getDefaultValidator();
    if (validator != null) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label != null && widget.label!.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.only(left: 5, bottom: 4),
            child: Row(
              children: [
                Text(
                  widget.label!,
                  style: Get.textTheme.bodyMedium?.copyWith(
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
        TextFormField(
          focusNode: _focusNode,
          controller: widget.controller,
          onChanged: (value) {
            if (widget.type == TextFieldType.search &&
                widget.onSearch != null) {
              widget.onSearch!(value);
            }
            widget.onChanged?.call(value);

            // Validate on change
            _validateField(value);
          },
          onTapOutside: (_) => _focusNode.unfocus(),
          onFieldSubmitted: (value) {
            _validateField(value);
            widget.onSubmitted?.call(value);
          },
          obscureText: _shouldObscureText(),
          validator: (value) {
            final validator = widget.validator ?? _getDefaultValidator();
            final errorMsg = validator != null ? validator(value) : null;
            // Don't set state here as it's called during form validation
            return errorMsg; // Return error message for the form validation
          },
          maxLines: _shouldObscureText() ? 1 : widget.maxLines,
          minLines: widget.minLines,
          readOnly: widget.type == TextFieldType.date ? true : widget.readOnly,
          enabled: widget.enabled,
          keyboardType: _getKeyboardType(),
          inputFormatters: _getInputFormatters(),
          textInputAction: TextInputAction.next,
          onTap: widget.type == TextFieldType.date
              ? widget.onTap ?? _showDatePicker
              : widget.onTap,
          style: Get.textTheme.titleMedium,
          // Use errorStyle: TextStyle(height: 0) to hide the default error
          decoration: DLInputDecorationTheme.getDecoration(
            hint: widget.hint,
            prefixIcon: _getPrefixIcon(),
            suffixIcon: _getSuffixIcon(),
            // errorText: null, // Hide the default error message
            // errorStyle: const TextStyle(height: 0, fontSize: 0), // Hide the default error display
          ),
          autovalidateMode: AutovalidateMode.onUserInteraction,
        ),

        // Display error text below the field
        // if (_errorText != null && _errorText!.isNotEmpty) ...[
        //   Padding(
        //     padding: const EdgeInsets.only(left: 8, top: 0),
        //     child: Text(
        //       _errorText!,
        //       style: TextStyle(
        //         color: AppColors.errorColor,
        //         fontSize: 12,
        //       ),
        //     ),
        //   ),
        // ],
      ],
    );
  }

  bool _shouldObscureText() {
    return (widget.type == TextFieldType.password ||
            widget.type == TextFieldType.confirmPassword) &&
        _obscureText;
  }

  Widget? _getPrefixIcon() {
    if (widget.type == TextFieldType.search) {
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: ImageViewer(
          imageUrl: dSvgsSearch,
          height: 16,
          width: 16,
          color: AppColors.disableButtonColor,
        ).build(),
      );
    }
    return widget.prefixIcon;
  }

  Widget? _getSuffixIcon() {
    if (widget.type == TextFieldType.password ||
        widget.type == TextFieldType.confirmPassword) {
      return IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility_off : Icons.visibility,
          color: Get.theme.colorScheme.primary,
        ),
        onPressed: () => setState(() => _obscureText = !_obscureText),
        splashRadius: 1.0,
      );
    } else if (widget.type == TextFieldType.date) {
      return Icon(
        Icons.calendar_today,
        color: Get.theme.colorScheme.primary,
      );
    }
    return widget.suffixIcon;
  }

  TextInputType _getKeyboardType() {
    switch (widget.type) {
      case TextFieldType.email:
        return TextInputType.emailAddress;
      case TextFieldType.phone:
        return TextInputType.phone;
      case TextFieldType.number:
        return TextInputType.number;
      case TextFieldType.search:
        return TextInputType.text;
      default:
        return TextInputType.text;
    }
  }

  List<TextInputFormatter>? _getInputFormatters() {
    switch (widget.type) {
      case TextFieldType.phone:
        return [FilteringTextInputFormatter.allow(RegExp(r'[0-9+\s-]'))];
      case TextFieldType.number:
        return [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(widget.maxCharacters)
        ];
      case TextFieldType.date:
        return [FilteringTextInputFormatter.allow(RegExp(r'[0-9/]'))];
      default:
        return null;
    }
  }

  String? Function(String?)? _getDefaultValidator() {
    switch (widget.type) {
      case TextFieldType.email:
        return (value) => validateEmail(value ?? '');
      case TextFieldType.password:
        return (value) => validatePassword(value ?? '');
      case TextFieldType.confirmPassword:
        return (value) {
          if (value != widget.passwordController?.text) {
            return 'Passwords do not match';
          }
          return null;
        };
      default:
        return widget.isRequired
            ? (value) =>
                validateRequiredField(value ?? '', widget.label ?? 'Field')
            : null;
    }
  }

  Future<void> _showDatePicker() async {
    final DateTime now = DateTime.now();
    final DateTime eighteenYearsAgo =
        DateTime(now.year - 18, now.month, now.day);

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: eighteenYearsAgo,
      firstDate: DateTime(1900),
      lastDate: eighteenYearsAgo,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Get.theme.colorScheme.primary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      final formattedDate = "${picked.day.toString().padLeft(2, '0')}/"
          "${picked.month.toString().padLeft(2, '0')}/"
          "${picked.year}";
      widget.controller.text = formattedDate;
      widget.onChanged?.call(picked.toString());
      _validateField(formattedDate);
    }
  }
}
