import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/login_controller.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(loginControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Login")),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: TextEditingController(), decoration: const InputDecoration(labelText: "Email")),
            TextField(controller: TextEditingController(), decoration: const InputDecoration(labelText: "Password"), obscureText: true),
            const SizedBox(height: 20),

            state.isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () {
                      ref.read(loginControllerProvider.notifier).login("test@test.com", "123456");
                    },
                    child: const Text("Login"),
                  ),

            if (state.hasError)
              Text(state.error.toString(), style: const TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }
}
