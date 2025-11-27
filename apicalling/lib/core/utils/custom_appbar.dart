import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentalmanagement/core/utils/theme_extension.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBack;

  const CustomAppBar({super.key, required this.title, this.onBack});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
        ),
      ),

      // leading: IconButton(
      //   onPressed: onBack,
      //   icon: Icon(Icons.arrow_back, color: AppColors.black, size: 20.sp),
      // ),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: const Color(0x33ABBED1),
              offset: const Offset(0, 8),
              blurRadius: 16,
              spreadRadius: 10,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
