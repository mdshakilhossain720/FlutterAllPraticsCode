import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentalmanagement/core/utils/theme_extension.dart';

import '../../../../core/constants/app_colors.dart';
import '../sign_up_screen.dart';

class AlreadyHaveAccountWidget extends StatelessWidget {
  const AlreadyHaveAccountWidget({
    super.key,
    required this.title,
    required this.subtitle,
    this.onTap, // 👈 Make it reusable
  });

  final String title;
  final String subtitle;
  final VoidCallback? onTap; // optional callback

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: title,
        style: context.textTheme.bodyMedium?.copyWith(
          color: AppColors.gray,
          fontSize: 16.sp,
        ),
        children: [
          TextSpan(
            text: subtitle,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.info,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap =
                  onTap ??
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignUpScreen(),
                      ),
                    );
                  },
          ),
        ],
      ),
    );
  }
}
