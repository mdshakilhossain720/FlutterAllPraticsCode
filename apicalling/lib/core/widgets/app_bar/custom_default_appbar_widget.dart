import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/app_colors.dart';
import '../../utils/theme_extension.dart';


class DefaultCustomAppbarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final double? leftPadding;
  final bool showBellIcon;

  const DefaultCustomAppbarWidget({
    super.key,
    required this.title,
    this.leftPadding = 16,
    this.showBellIcon = true,
  });

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      backgroundColor: AppColors.gray50,
      elevation: 0,
      titleSpacing: 0.w,
      title: Padding(
        padding: EdgeInsets.only(left: leftPadding ?? 16.w),
        child: Text(
          title,
          style: context.textTheme.titleMedium!.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 18.sp,
          ),
        ),
      ),
      actions: [
        // if (showBellIcon)
        //   GestureDetector(
        //     onTap: () {
        //       // context.push(Routes.notification);
        //     },
        //     child: Padding(
        //       padding: EdgeInsets.only(right: 16.0.w),
        //       child: SvgPicture.asset(
        //         Assets.AssetsIcons.bell,
        //         colorFilter: const ColorFilter.mode(
        //           AppColors.primaryColor,
        //           BlendMode.srcIn,
        //         ),
        //       ),
        //     ),
        //   ),
      ],
    );
  }
}
