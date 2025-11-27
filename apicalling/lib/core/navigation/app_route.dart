import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rentalmanagement/features/Property/views/property_details_screen.dart';
import 'package:rentalmanagement/features/auth/views/login_screen.dart';
import 'package:rentalmanagement/features/auth/views/reset_password.dart';
import 'package:rentalmanagement/features/auth/views/sign_up_screen.dart';
import 'package:rentalmanagement/features/bottom_nav_bar/views/bottom_nav_bar.dart';
import 'package:rentalmanagement/features/home/models/lease_details_model/lease.dart';
import 'package:rentalmanagement/features/lease/views/lease_details_screen.dart';
import 'package:rentalmanagement/features/lease/views/lease_list_screen.dart';
import 'package:rentalmanagement/features/maintenance/views/add_new_request.dart';
import 'package:rentalmanagement/features/splash/views/splash_screen.dart';

import '../../features/auth/views/create_password.dart';

class Routes {
  Routes._();
  static const splash = '/splash';
  static const onboarding = '/onboarding';
  static const login = '/login';
  static const signup = '/signup';
  static const forgotpass = '/forgotpass';
  static const createpass = '/createpass';
  static const bottomNavbar = '/bottomNavbar';
  static const wallet = '/wallet';
  static const postAd = '/post-ad';
  static const message = '/message';
  static const more = '/more';
  static const propertyDetails = '/property-details';
  static const newMaintenanceRequest = '/new-maintenance-request';
  static const leaseList = '/lease-list';
  static const leaseDetails = '/lease-details';
}

class AppRouter {
  AppRouter._();

  static final routeObserver = RouteObserver<ModalRoute<void>>();

  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> shellNavigatorKey =
      GlobalKey<NavigatorState>();

  static final router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: Routes.splash,
    debugLogDiagnostics: kDebugMode,
    observers: [routeObserver],

    // Uncomment & customize when auth flow is ready
    // redirect: (context, state) {
    //   final authBox = Hive.box(AppConstants.authBox);
    //   final token = authBox.get(AppConstants.authToken);
    //   final loggingIn = state.location == Routes.login;
    //
    //   if (token == null && !loggingIn) return Routes.login;
    //   if (token != null && loggingIn) return Routes.dashboard;
    //   return null;
    // },
    routes: [
      /// Splash
      GoRoute(
        path: Routes.splash,
        pageBuilder: (context, state) =>
            _platformTransitionPage(state: state, child: const SplashScreen()),
      ),

      /// Login
      GoRoute(
        path: Routes.login,
        pageBuilder: (context, state) =>
            _platformTransitionPage(state: state, child: const LoginScreen()),
      ),

      /// Signup
      GoRoute(
        path: Routes.signup,
        pageBuilder: (context, state) =>
            _platformTransitionPage(state: state, child: const SignUpScreen()),
      ),
      GoRoute(
        path: Routes.forgotpass,
        pageBuilder: (context, state) => _platformTransitionPage(
          state: state,
          child: const ForgotPasswordScreen(),
        ),
      ),
      GoRoute(
        path: Routes.bottomNavbar,
        pageBuilder: (context, state) =>
            NoTransitionPage(child: const BottomNavBar()),
      ),
      GoRoute(
        path: Routes.createpass,
        builder: (context, state) {
          final contact = state.extra as String; // ✅ receive value
          return CreatePasswordScreen(contact: contact);
        },
      ),
      GoRoute(
        path: Routes.propertyDetails,
        builder: (context, state) {
          final id = state.extra as int; // ✅ receive value
          return PropertyDetailsScreen(propertyId: id);
        },
      ),
      GoRoute(
        path: Routes.newMaintenanceRequest,
        builder: (context, state) {
          return AddNewRequestScreen();
        },
      ),

      GoRoute(
        path: Routes.leaseList,
        builder: (context, state) {
          return LeaseListScreen();
        },
      ),
      GoRoute(
        path: Routes.leaseDetails,
        builder: (context, state) {
          final lease = state.extra as Lease;
          return LeaseDetailsScreen(lease: lease);
        },
      ),

      // Shell route for BottomNavigationBar
      // ShellRoute(
      //   navigatorKey: _shellNavigatorKey,
      //   builder: (context, state, child) {
      //     return BottomNavBar(child: child);
      //   },
      //   routes: [
      //     GoRoute(
      //       path: Routes.home,
      //       pageBuilder: (context, state) =>
      //           _bottomToTopSlidePage(state: state, child: const HomeScreen()),
      //     ),

      //     GoRoute(
      //       path: Routes.wallet,
      //       pageBuilder: (context, state) => _bottomToTopSlidePage(
      //         state: state,
      //         child: const PropertyScreen(),
      //       ),
      //     ),
      //     GoRoute(
      //       path: Routes.postAd,
      //       pageBuilder: (context, state) => _bottomToTopSlidePage(
      //         state: state,
      //         child: const MaintenanceScreen(),
      //       ),
      //     ),
      //     GoRoute(
      //       path: Routes.message,
      //       pageBuilder: (context, state) => _bottomToTopSlidePage(
      //         state: state,
      //         child: const PaymentsScreen(),
      //       ),
      //     ),
      //   ],
      // ),
    ],
  );

  // PLATFORM AWARE PAGE BUILDER
  static CustomTransitionPage _platformTransitionPage({
    required GoRouterState state,
    required Widget child,
  }) {
    if (Platform.isIOS) {
      return _cupertinoPage(state: state, child: child);
    } else {
      return _fadePage(state: state, child: child);
    }
  }

  /// --- Custom Page Transitions ---

  static CustomTransitionPage _fadePage({
    required GoRouterState state,
    required Widget child,
  }) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }

  static CustomTransitionPage _slidePage({
    required GoRouterState state,
    required Widget child,
  }) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final tween = Tween(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).chain(CurveTween(curve: Curves.easeInOut));
        return SlideTransition(position: animation.drive(tween), child: child);
      },
    );
  }

  // static CustomTransitionPage _bottomToTopSlidePage({
  //   required GoRouterState state,
  //   required Widget child,
  // }) {
  //   return CustomTransitionPage(
  //     key: state.pageKey,
  //     child: child,
  //     transitionDuration: const Duration(milliseconds: 400), // optional
  //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
  //       final tween = Tween<Offset>(
  //         begin: const Offset(0, 1), // starts from bottom
  //         end: Offset.zero, // ends at original position
  //       ).chain(CurveTween(curve: Curves.easeInOut));

  //       return SlideTransition(position: animation.drive(tween), child: child);
  //     },
  //   );
  // }

  static CustomTransitionPage _bottomToTopSlidePage({
    required GoRouterState state,
    required Widget child,
  }) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionDuration: const Duration(milliseconds: 400),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // Slide from bottom
        final slideAnimation = Tween<Offset>(
          begin: const Offset(0, 0.25), // small offset, not full screen
          end: Offset.zero,
        ).chain(CurveTween(curve: Curves.easeOutCubic)).animate(animation);

        // Slight scale
        final scaleAnimation = Tween<double>(
          begin: 0.97,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.easeOutBack)).animate(animation);

        // Fade
        final fadeAnimation = Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(CurvedAnimation(parent: animation, curve: Curves.easeIn));

        return SlideTransition(
          position: slideAnimation,
          child: ScaleTransition(
            scale: scaleAnimation,
            child: FadeTransition(opacity: fadeAnimation, child: child),
          ),
        );
      },
    );
  }

  static CustomTransitionPage _cupertinoPage({
    required GoRouterState state,
    required Widget child,
  }) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
    );
  }
}
