import 'package:animated_segmented_tab_control/animated_segmented_tab_control.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentalmanagement/core/constants/app_colors.dart';

import 'widgets/resuable_app_bar.dart';

class MaintenanceScreen extends StatelessWidget {
  const MaintenanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Stack(
            children: [
              SegmentedTabControl(
                tabTextColor: Colors.black,
                selectedTabTextColor: Colors.white,

                indicatorDecoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(8.r),
                ),

                barDecoration: BoxDecoration(
                  color: Color(0xffEDF3FF),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                height: 40,

                tabs: [
                  SegmentTab(label: "All", color: AppColors.primaryColor),
                  SegmentTab(label: "Pending", color: AppColors.primaryColor),
                  SegmentTab(
                    label: "In Progress",
                    color: AppColors.primaryColor,
                  ),
                  SegmentTab(label: "Completed", color: AppColors.primaryColor),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 70),
                child: TabBarView(
                  children: [
                    Center(child: Text("Upcoming")),
                    Center(child: Text("History")),
                    Center(child: Text("Upcoming")),
                    Center(child: Text("History")),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
