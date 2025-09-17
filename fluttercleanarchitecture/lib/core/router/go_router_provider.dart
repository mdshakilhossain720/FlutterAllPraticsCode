import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttercleanarchitecture/core/router/go_router.dart';
import 'package:go_router/go_router.dart';

import '../../features/sign_up/presentation/screen/signup_screen.dart';

final goRouterProvider = Provider<GoRouter>(
  (ref) => GoRouter(
    initialLocation: loginRoute,
    routes: [
      GoRoute(
        path: '/login',
        name: loginRoute,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/home',
        name: homeRoute,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        name: registerRoute,
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
    ],
  ),
);
