import 'package:cleanarchitectureflutter/src/core/theme/theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';

import '../constants/app_colors.dart';


class CustomTextFieldWithHeading extends StatelessWidget {
  final int? maxLine;
  final String? heading;
  final String textFieldName;
  final String? hintText;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? obscureText;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final String? initialValue;
  final bool? readOnly;
  final TextStyle? hintTextStyle;
  final Color? fillColor;
  final Function(String?)? onChanged;
  final bool? enable;
  final String? labelText;

  const CustomTextFieldWithHeading({
    super.key,
    this.initialValue,
    this.maxLine,
    this.heading,
    required this.textFieldName,
    this.hintText,
    this.keyboardType,
    this.controller,
    this.validator,
    this.suffixIcon,
    this.obscureText,
    this.textInputAction,
    this.focusNode,
    this.readOnly,
    this.hintTextStyle,
    this.prefixIcon,
    this.fillColor,
    this.onChanged,
    this.enable,
    this.labelText,
  });

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
                style: context.textTheme.titleMedium!.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Gap(5.h),
            ],
          ),
        ],

        FormBuilderTextField(
          enabled: enable ?? true,
          onChanged: onChanged,
          readOnly: readOnly ?? false,
          initialValue: initialValue,
          textInputAction: textInputAction ?? TextInputAction.next,
          obscureText: obscureText ?? false,
          name: textFieldName,
          controller: controller,
          maxLines: maxLine ?? 1,
          keyboardType: keyboardType ?? TextInputType.name,
          cursorColor: AppColors.primaryColor,
          style: context.textTheme.titleMedium!.copyWith(
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
            decoration: TextDecoration.none,
            decorationThickness: 0,
          ),
          decoration: textfieldInputDecoration(
            context: context,
            hintText: hintText,
            labelText: labelText,
            hintTextStyle: hintTextStyle,
            suffixIcon: suffixIcon,
            preffixIcon: prefixIcon,
          ),
          validator:
              validator ??
              FormBuilderValidators.compose([FormBuilderValidators.required()]),
        ),
      ],
    );
  }
}

textfieldInputDecoration({
  BuildContext? context,
  String? hintText,
  TextStyle? hintTextStyle,
  String? labelText,
  Widget? suffixIcon,
  Widget? preffixIcon,
  Color? fillColor,
}) {
  return InputDecoration(
    // contentPadding: EdgeInsets.symmetric(horizontal: 10.r, vertical: 12.r),
    labelText: labelText,

    hint: Text(
      hintText ?? "",
      style:
          hintTextStyle ??
          context?.textTheme.bodyMedium!.copyWith(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
    ),
    labelStyle: context?.textTheme.bodyMedium!.copyWith(
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
    ),

    fillColor: fillColor,
    prefixIcon: preffixIcon,
    prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
    suffixIcon: suffixIcon,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.r),
      borderSide: BorderSide(color: AppColors.border, width: 1.5.w),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.r),
      borderSide: BorderSide(color: AppColors.border, width: 1.5.w),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.r),
      borderSide: BorderSide(color: AppColors.primaryColor, width: 1.5.w),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.r),
      borderSide: BorderSide(color: AppColors.error, width: 1.5.w),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.r),
      borderSide: BorderSide(color: AppColors.error, width: 1.5.w),
    ),
  );
}
