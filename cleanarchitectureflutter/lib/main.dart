import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'envirment.dart';
import 'my_app.dart';
import 'src/core/constants/app_constants.dart';
import 'src/core/notifactions/notification_handler.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   await Environment.init();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  NotificationServices notificationServices = NotificationServices();
  String? token = await notificationServices.getDeviceToken();
  debugPrint('Token: $token');
  await Hive.initFlutter();
  await Hive.openBox(AppConstants.authBox);
  await Hive.openBox(AppConstants.appSettingsBox);
  await Hive.openBox(AppConstants.userBox);

  runApp(const ProviderScope(child: MyApp()));
}
