import 'package:apicalling/core/constants/app_colors.dart';
import 'package:apicalling/core/widgets/buttons/custom_button.dart';
import 'package:flutter/material.dart';


Future<void> showLogoutDialog({
  required BuildContext context,
  required VoidCallback onConfirm,
}) async {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Log Out',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        content: Text(
          'Are you sure you want to log out?',
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          CustomButton(
            width: 100,
            borderRadius: 50,

            backgroundColor: Colors.transparent,
            borderWidth: 1,
            borderColor: AppColors.primaryColor,
            onTap: () => Navigator.of(context).pop(),
            text: 'Cancel',
            textColor: AppColors.primaryColor,
          ),
          CustomButton(
            width: 100,
            borderRadius: 50,
            onTap: () {
              Navigator.of(context).pop();
              onConfirm();
            },
            text: 'Logout',
          ),
        ],
      );
    },
  );
}
