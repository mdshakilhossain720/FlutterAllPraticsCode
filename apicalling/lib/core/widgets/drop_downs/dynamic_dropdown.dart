import 'package:rentalmanagement/core/core.dart';
import 'package:rentalmanagement/core/theme/theme_extensions.dart';

class CustomDynamicDropdownField<T> extends StatelessWidget {
  final String? label;
  final String? hint;
  final T? value;
  final ValueChanged<T?> onChanged;
  final FormFieldValidator<T>? validator;
  final List<DropdownMenuItem<T>> items;
  final IconData? icon;
  final EdgeInsetsGeometry? padding;

  const CustomDynamicDropdownField({
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
      child: DropdownButtonFormField<T>(
        isExpanded: true,
        icon: SvgPicture.asset(
          'assets/svgs/angledownsmall.svg',
          height: 16,
          width: 16,
        ),
        initialValue: value,
        style: context.textTheme.titleSmall!.copyWith(fontSize: 12.0.sp),
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          hintStyle: context.textTheme.bodySmall,
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
        items: items,
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }
}
