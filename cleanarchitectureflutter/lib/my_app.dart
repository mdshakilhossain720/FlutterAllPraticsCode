import 'package:flutter/material.dart';

import 'src/features/auth/presentation/screens/login_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auth App',
      home: const LoginScreen(),
    );
  }
}
