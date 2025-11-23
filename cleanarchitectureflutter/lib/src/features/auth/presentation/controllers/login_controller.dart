import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../auth_providers.dart';


final loginControllerProvider =
    StateNotifierProvider<LoginController, AsyncValue<void>>((ref) {
  return LoginController(ref);
});

class LoginController extends StateNotifier<AsyncValue<void>> {
  final Ref ref;

  LoginController(this.ref) : super(const AsyncData(null));

  Future<void> login(String email, String password) async {
    state = const AsyncLoading();

    final result =
        await ref.read(loginUsecaseProvider)(email, password);

    result.fold(
      (failure) => state = AsyncError(failure.message, StackTrace.current),
      (user) => state = const AsyncData(null),
    );
  }
}
