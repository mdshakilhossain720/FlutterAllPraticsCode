import 'package:cleanarchitectureflutter/src/core/theme/theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/app_colors.dart';


class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onTap,
    required this.text,
    this.backgroundColor,
    this.textColor,
    this.fontWeight = FontWeight.bold,
    this.width = double.infinity,
    this.height = 44.0,
    this.fontSize = 16.0,
    this.padding,
    this.icon,
    this.borderRadius = 8.0,
    this.borderColor = Colors.transparent,
    this.borderWidth = 0.0,
    this.iconWidget,
    this.fontFamily,
  });

  final String text;
  final VoidCallback onTap;
  final Color? backgroundColor;
  final Color? textColor;
  final FontWeight? fontWeight;
  final double? width;
  final double height;
  final double fontSize;
  final EdgeInsetsGeometry? padding;
  final IconData? icon;
  final Widget? iconWidget;
  final double borderRadius;
  final Color borderColor;
  final double borderWidth;
  final String? fontFamily;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(borderRadius),
        child: Ink(
          width: width,
          height: height.h,
          decoration: BoxDecoration(
            color: backgroundColor ?? AppColors.primaryColor,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(color: borderColor, width: borderWidth),
          ),
          child: Padding(
            padding: padding ?? EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null || iconWidget != null)
                  Padding(
                    padding: EdgeInsets.only(right: 8.w),
                    child:
                        iconWidget ??
                        Icon(
                          icon,
                          size: 20.w,
                          color: textColor ?? AppColors.white,
                        ),
                  ),
                Text(
                  text,
                  style: context.textTheme.titleMedium!.copyWith(
                    color: textColor ?? AppColors.white,
                    fontWeight: fontWeight,
                    fontSize: fontSize.sp,
                    fontFamily: fontFamily,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
