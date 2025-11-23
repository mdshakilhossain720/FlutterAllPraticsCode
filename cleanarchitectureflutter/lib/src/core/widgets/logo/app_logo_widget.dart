import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class AppLogoWidget extends StatelessWidget {
  final double width;
  final double height;
  final Color? color;
  final String? logo;

  const AppLogoWidget({
    super.key,
    this.height = 71,
    this.width = 73,
    this.color,
    this.logo,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      logo ?? Assets.pngs.logo.path,
      height: height.h,
      width: width.w,
      color: color,
    );
  }
}
