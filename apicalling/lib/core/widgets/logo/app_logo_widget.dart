import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentalmanagement/gen/assets.gen.dart';

class AppLogoWidget extends StatelessWidget {
  final double width;
  final double height;
  final Color? color;
  final String? logo;

  const AppLogoWidget({
    super.key,
    this.height = 120,
    this.width = 260,
    this.color,
    this.logo,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Image.asset(
      logo ??
          (isDarkMode
              ? Assets.pngs.logoDarkMode.path
              : Assets.pngs.logoLightMode.path),
      height: height.h,
      width: width.w,
      color: color,
      fit: BoxFit.cover,
    );
  }
}
