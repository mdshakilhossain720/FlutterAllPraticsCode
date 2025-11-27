import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentalmanagement/core/constants/app_colors.dart';

class SimpleButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final double height;

  const SimpleButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = AppColors.primaryColor,
    this.height = 48.0, // Standard height for consistency or 36.0
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            10.0.r,
          ), // Adjust this value as needed
        ),
        backgroundColor: backgroundColor,

        minimumSize: Size(
          double.infinity,

          height.h,
        ), // Ensures the height is consistent
      ),
      child: Text(text, style: TextStyle(color: AppColors.white)),
    );
  }
}
