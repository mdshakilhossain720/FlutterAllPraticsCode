import 'package:cleanarchitectureflutter/src/core/theme/theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../constants/app_colors.dart';
import 'buttons/custom_button.dart';
import 'custom_loader_widget.dart';

class CustomConfirmationDialouge extends StatelessWidget {
  final String iconPath;
  final String title;
  final String buttonText;
  final Future<void> Function() onConfirmed;
  final bool isLoading;
  const CustomConfirmationDialouge({
    super.key,
    required this.iconPath,
    required this.title,
    required this.buttonText,
    required this.onConfirmed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),

      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(40.0.r),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Image
                Container(
                  padding: EdgeInsets.all(20.r),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withValues(alpha: .1),
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(iconPath, width: 30.w),
                ),
                Gap(16.h),
                Text(
                  title,
                  style: context.textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 18.sp,
                  ),
                  textAlign: TextAlign.center,
                ),
                Gap(20.h),

                // Button
                isLoading
                    ? CustomLoaderWidget()
                    : CustomButton(
                        width: 219.w,
                        onTap: () async {
                          await onConfirmed();
                          if (context.mounted) {
                            context.pop();
                          }
                        },
                        text: buttonText,
                      ),
              ],
            ),
          ),
          // Close Button
          Positioned(
            top: 10,
            right: 10,
            child: GestureDetector(
              onTap: () {
                context.pop();
              },
              child: const Icon(Icons.close, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
