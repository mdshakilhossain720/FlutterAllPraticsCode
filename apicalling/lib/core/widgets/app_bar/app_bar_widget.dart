// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:rentalmanagement/core/constants/app_colors.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final Color? iconColor;
  final bool centerTitle;
  final bool showBackButton;

  const AppBarWidget({
    super.key,
    this.title,
    this.actions = const [],
    this.backgroundColor = Colors.transparent,
    this.iconColor,
    this.centerTitle = false,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      elevation: 0,
      titleSpacing: 0.0,
      centerTitle: centerTitle,
      title: Text(
        title ?? '',
        // style: context.textTheme.titleMedium!.copyWith(
        //   fontWeight: FontWeight.w600,
        //   fontSize: 20.sp,
        //   color: AppColors.secondaryColor,
        // ),
      ),
      actions: actions,
      backgroundColor: backgroundColor ?? AppColors.gray50,
      iconTheme: IconThemeData(color: iconColor),
      // leading: showBackButton ? CustomBackButton() : null,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
