import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:rentalmanagement/core/constants/app_colors.dart';
import 'package:rentalmanagement/core/utils/theme_extension.dart';
import 'package:rentalmanagement/core/widgets/custom_textfield.dart';

class CustomFormBuilderDropdown extends StatelessWidget {
  const CustomFormBuilderDropdown({
    super.key,
    required this.formKey,
    required this.name,
    required this.items,
    this.initialValue,
    this.labelText,
    this.hintText,
    this.heading,
    this.onChange,
    this.validator,
  });

  final GlobalKey<FormBuilderState> formKey;
  final String name;
  final List<String> items;
  final String? initialValue;
  final String? labelText;
  final String? hintText;
  final String? heading;
  final Function(String?)? onChange;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (heading != null) ...[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                heading ?? "",
                style: context.textTheme.bodyMedium!.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).textTheme.titleLarge!.color,
                ),
              ),
              Gap(5.h),
            ],
          ),
        ],
        FormBuilderDropdown<String>(
          name: name,
          hint: Text(
            hintText ?? "",
            style: context.textTheme.bodyMedium!.copyWith(
              fontSize: 14.sp,
              color: Theme.of(context).hintColor,
            ),
          ),
          initialValue: initialValue,
          dropdownColor: AppColors.white,
          decoration: textfieldInputDecoration(
            context: context,
            labelText: labelText,
            fillColor: AppColors.white,
          ),
          style: context.textTheme.titleMedium!.copyWith(
            fontSize: 14.sp,
            color: Theme.of(context).textTheme.titleLarge!.color,
          ),
          onChanged: onChange,
          validator: validator,

          items: items
              .map(
                (item) => DropdownMenuItem(
                  //  alignment: AlignmentDirectional.center,
                  value: item,
                  child: Text(item),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class CustomDynamicFormBuilderDropdown<T> extends StatelessWidget {
  const CustomDynamicFormBuilderDropdown({
    super.key,
    required this.formKey,
    required this.name,
    required this.items,
    required this.dropdownItems,
    this.initialValue,
    this.labelText,
    this.hintText,
    this.heading,
    this.onChanged,
    this.value,

    this.validator,
  });

  final GlobalKey<FormBuilderState> formKey;
  final String name;

  final String? initialValue;
  final String? labelText;
  final String? hintText;
  final String? heading;
  final List<T> items;
  final List<DropdownMenuItem<T>> dropdownItems;
  final T? value;
  final void Function(T?)? onChanged;
  final String? Function(T?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (heading != null) ...[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                heading ?? "",
                style: context.textTheme.bodyMedium!.copyWith(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Gap(5.h),
            ],
          ),
        ],
        FormBuilderDropdown<T>(
          name: name,
          hint: Text(
            hintText ?? 'Select an option',
            style: context.textTheme.bodyMedium!.copyWith(
              fontSize: 14.sp,
              color: Theme.of(context).hintColor,
            ),
          ),
          // initialValue: initialValue.toString(),
          dropdownColor: AppColors.white,
          decoration: textfieldInputDecoration(
            context: context,
            labelText: labelText,
            fillColor: AppColors.white,
          ),
          onChanged: onChanged,
          validator: validator,

          items: dropdownItems,
        ),
      ],
    );
  }
}

class CustomUI extends StatelessWidget {
  const CustomUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ Password Requirement Row
            const SizedBox(height: 20),

            // ⬜ Terms & Conditions
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Custom Checkbox
                Checkbox(
                  value: false,
                  onChanged: (val) {},
                  shape: const CircleBorder(), // makes it round
                ),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                      children: [
                        const TextSpan(text: "I agree to the "),
                        TextSpan(
                          text: "terms of use",
                          style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const TextSpan(text: " and "),
                        TextSpan(
                          text: "privacy policy.",
                          style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
