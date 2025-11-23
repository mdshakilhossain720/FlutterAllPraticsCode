import 'package:cleanarchitectureflutter/src/core/theme/theme_extensions.dart';
import 'package:dartz/dartz.dart' as ConnectivityResult;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'src/core/constants/app_constants.dart';
import 'src/core/navigation/app_route.dart';
import 'src/core/network/onnectivity_provider.dart';
import 'src/core/theme/app_theme.dart';
import 'src/core/theme/theme_controller_provider.dart';
import 'src/core/widgets/offline.dart';

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
          locale: Locale(localeCode),
          localizationsDelegates: [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
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