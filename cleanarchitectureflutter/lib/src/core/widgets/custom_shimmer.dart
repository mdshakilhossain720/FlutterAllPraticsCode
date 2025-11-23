import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomShimmerWidget extends StatelessWidget {
  final double? height;
  final double? width;
  final double? borderRadius;
  final Color? baseColor;
  final Color? highlightColor;
  final bool isCircular;

  const CustomShimmerWidget({
    super.key,
    this.height,
    this.width,
    this.borderRadius,
    this.baseColor,
    this.highlightColor,
    this.isCircular = false,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor ?? Colors.grey[300]!,
      highlightColor: highlightColor ?? Colors.grey[100]!,
      child: Container(
        width: width ?? double.infinity,
        height: height ?? 16.h,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: isCircular ? BoxShape.circle : BoxShape.rectangle,
          borderRadius: isCircular
              ? null
              : BorderRadius.circular(borderRadius ?? 8.r),
        ),
      ),
    );
  }
}
