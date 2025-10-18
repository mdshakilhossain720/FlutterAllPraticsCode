import 'package:flutter/material.dart';

class CustomDropdownField extends StatelessWidget {
  final String label;
  final List<String> items;
  final String? value;
  final ValueChanged<String?> onChanged;
  final FormFieldValidator<String>? validator;
  final IconData? icon;
  final EdgeInsetsGeometry? padding;

  const CustomDropdownField({
    super.key,
    required this.label,
    required this.items,
    required this.onChanged,
    this.value,
    this.validator,
    this.icon,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        initialValue: value,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: icon != null ? Icon(icon) : null,
          border: OutlineInputBorder(

            
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          
          ),
          filled: true,
          fillColor: Colors.grey[200],
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
        items: items
            .map((item) => DropdownMenuItem(value: item, child: Text(item)))
            .toList(),
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }
}






/// call this 


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:rentalmanagement/core/constants/app_colors.dart';
import 'package:rentalmanagement/core/utils/custom_appbar.dart';

import '../../../core/notifactions/notification_handler.dart';
import '../../../core/utils/customdropdownfield.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key, required this.title});

  final String title;

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  NotificationServices notificationServices = NotificationServices();

  @override
  void initState() {
    super.initState();

    notificationServices.requestNotificationPermisions();
    notificationServices.forgroundMessage();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    notificationServices.isRefreshToken();
    notificationServices.getDeviceToken().then((value) {
      print(value);
    });
  }

  String? _selectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Notifications'),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Gap(30.h),
            SizedBox(
              height: 65.h,
              width: double.infinity,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Container(
                    height: 65.h,
                    width: 108.w,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: Color(0xffEDF3FF), width: 1.w),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "4",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          "Total",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Gap(10.w);
                },
              ),
            ),
            Gap(10.h),
            Container(
              alignment: Alignment.center,
              height: 44.h,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xffEDF3FF)),
              ),
              child: Text(
                "Mark All as Read",
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            Gap(20.h),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0x33ABBED1),
                    offset: const Offset(0, 8),
                    blurRadius: 16,
                    spreadRadius: 10,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text("Notifications"),
                  CustomDropdownField(
                    label: 'Select an option',
                    icon: Icons.list_alt,
                    items: const ['Option 1', 'Option 2', 'Option 3'],
                    value: _selectedValue,
                    onChanged: (value) =>
                        setState(() => _selectedValue = value),
                    validator: (value) =>
                        value == null ? 'Please select an option' : null,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

