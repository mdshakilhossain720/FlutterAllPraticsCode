import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/constants/app_constants.dart';
import 'core/core.dart';
import 'core/localization/localization_provider.dart';
import 'core/navigation/app_route.dart';
import 'core/network/onnectivity_provider.dart';
import 'core/notifactions/notification_handler.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_controller_provider.dart';
import 'core/theme/theme_extensions.dart';
import 'core/widgets/offline.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  NotificationServices notificationServices = NotificationServices();

  // /// Ask permission FIRST
  // notificationServices.requestNotificationPermisions();

  // /// Now get token
  String? token = await notificationServices.getDeviceToken();
  debugPrint('Token: $token');
  // await Firebase.initializeApp();
  // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  // NotificationServices notificationServices = NotificationServices();
  // String? token = await notificationServices.getDeviceToken();
  // debugPrint('Token: $token');
  await Hive.initFlutter();
  await Hive.openBox(AppConstants.authBox);
  await Hive.openBox(AppConstants.appSettingsBox);
  await Hive.openBox(AppConstants.userBox);
  await Hive.openBox(AppConstants.loginBox);

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    context.setStatusBarTheme();
    final themeMode = ref.watch(themeModeProvider);
    debugPrint('Current ThemeMode: $themeMode');
    final localeCode = ref.watch(languageProvider);
    debugPrint('Current Locale: $localeCode');

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,

      builder: (context, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: AppConstants.appName,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: themeMode,
          routerConfig: AppRouter.router,
          // locale: Locale(localeCode),
          // localizationsDelegates: [
          //   S.delegate,
          //   GlobalMaterialLocalizations.delegate,
          //   GlobalWidgetsLocalizations.delegate,
          //   GlobalCupertinoLocalizations.delegate,
          // ],
          // supportedLocales: S.delegate.supportedLocales,
          builder: (context, child) {
            final connectivityAsyncValue = ref.watch(connectivityProvider);
            return connectivityAsyncValue.when(
              data: (connectivityResult) {
                if (connectivityResult == ConnectivityResult.none) {
                  return const Scaffold(body: OfflineScreen());
                }
                return child!;
              },
              loading: () => const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              ),
              error: (error, stack) =>
                  Scaffold(body: Center(child: Text('Error: $error'))),
            );
          },
        );
      },
    );
  }
}
