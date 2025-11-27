
import 'package:apicalling/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/app_colors.dart';
import '../theme/theme_extensions.dart';
import 'theme_extension.dart';

class CustomDropdownField extends StatelessWidget {
  final String? label;
  final String? hint;
  final List<String> items;
  final String? value;
  final ValueChanged<String?> onChanged;
  final FormFieldValidator<String>? validator;
  final IconData? icon;
  final EdgeInsetsGeometry? padding;

  const CustomDropdownField({
    super.key,
    this.label,
    this.hint,
    required this.items,
    required this.onChanged,
    this.value,
    this.validator,
    this.icon,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        isExpanded: true,
        icon: SvgPicture.asset(
          'assets/svgs/angledownsmall.svg',
          height: 16,
          width: 16,
        ),
        initialValue: value,
       // style: context.textTheme.titleSmall!.copyWith(fontSize: 12.0.sp),
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
         // hintStyle: context.textTheme.bodySmall,
          prefixIcon: icon != null ? Icon(icon) : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: context.isDarkMode
              ? AppColors.gray.withValues(alpha: 0.5)
              : Color(0xffF6F7F9),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
        items: items
            .map((item) => DropdownMenuItem(value: item, child: Text(item)))
            .toList(),
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }
}
