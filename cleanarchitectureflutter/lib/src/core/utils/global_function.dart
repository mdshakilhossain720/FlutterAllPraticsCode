import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../navigation/app_route.dart';


class GlobalFunction {
  GlobalFunction._();

  static final providerContainer = ProviderContainer();

  static final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  static final rootNavigatorKey = AppRouter.rootNavigatorKey;

  static void showCustomSnackbar({
    required String message,
    required bool isSuccess,
    bool isTop = false,
  }) {
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      backgroundColor: isSuccess ? Colors.green : Colors.red,
      dismissDirection: isTop
          ? DismissDirection.startToEnd
          : DismissDirection.down,
      content: Text(message, style: TextStyle(fontSize: 12.sp)),
      margin: isTop
          ? EdgeInsets.only(
              bottom:
                  MediaQuery.of(
                    scaffoldMessengerKey.currentState!.context,
                  ).size.height -
                  160,
              right: 20,
              left: 20,
            )
          : null,
    );
    ScaffoldMessenger.of(rootNavigatorKey.currentContext!)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
    // scaffoldMessengerKey.currentState!
    //   ..hideCurrentSnackBar()
    //   ..showSnackBar(snackBar);
  }

  /*Use this function in case if you are willing to print or debug something. This function will help you to hide your debug print in release mode.*/
  static void logDebug(String message) {
    if (kDebugMode) {
      debugPrint("🦊 $message");
    }
  }

  static Color setBackgroundColor(String status) {
    switch (status.toLowerCase()) {
      case "paid":
        return Colors.green;
      case "unpaid":
        return Colors.orangeAccent;
      case "upcoming":
        return Colors.blueAccent;
      case "overdue":
        return Colors.redAccent;
      case "due":
        return Colors.amber;
      case "cancelled":
        return Colors.grey;
      case "pending":
        return Colors.orange;
      case "high":
        return Colors.redAccent;
      case "completed":
        return Colors.teal;
      default:
        return const Color(0xffF6F7F9);
    }
  }

  static Color? setTextColor(String? status) {
    // white text if status is recognized, else black
    const recognizedStatuses = {
      "paid",
      "unpaid",
      "upcoming",
      "overdue",
      "due",
      "cancelled",
      "pending",
      "high",
      "completed",
    };
    return recognizedStatuses.contains(status) ? Colors.white : null;
  }

  /// Safe way to show a dialog from anywhere
  static Future<void> showSafeDialog({
    required WidgetBuilder builder,
    BuildContext? fallbackContext,
  }) async {
    BuildContext? dialogContext;

    // Priority 1: fallbackContext (direct context from widget)
    if (fallbackContext != null) {
      dialogContext = fallbackContext;
    }

    // Priority 2: fallback to global scaffoldMessengerKey's context
    dialogContext ??= scaffoldMessengerKey.currentContext;

    if (dialogContext == null) {
      logDebug("Unable to find a valid context to show dialog.");
      return;
    }

    // Show dialog
    return showDialog(context: dialogContext, builder: builder);
  }
}
