import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_colors.dart';


class CustomDotIndicator extends StatelessWidget {
  const CustomDotIndicator({
    super.key,
    required this.activeIndex,
    required this.count,
  });
  final int activeIndex;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        //width: 335.w,
        height: 6.h,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: count,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                height: 6.h,
                width: activeIndex == index ? 32.w : 16.w,
                decoration: BoxDecoration(
                  color: activeIndex == index
                      ? AppColors.primaryColor
                      : AppColors.bodyTextColor,
                  borderRadius: BorderRadius.circular(3.h),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
