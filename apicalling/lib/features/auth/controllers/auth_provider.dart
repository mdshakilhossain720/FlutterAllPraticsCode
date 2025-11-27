import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:rentalmanagement/features/auth/controllers/auth_repo.dart';
import 'package:rentalmanagement/features/auth/controllers/auth_state_notifier.dart';

final authServiceProvider = Provider((ref) => AuthService(ref));

final loginStateProvider = StateNotifierProvider<LoginStateNotifier, bool>((
  ref,
) {
  return LoginStateNotifier(ref);
});

final registrationStateProvider =
    StateNotifierProvider<RegistrationStateNotifier, bool>((ref) {
      return RegistrationStateNotifier(ref);
    });

final forgetPasswordStateProvider =
    StateNotifierProvider<ForgetStateNotifier, bool>((ref) {
      return ForgetStateNotifier(ref);
    });

final logoutStateProvider = StateNotifierProvider<LogOutStateNotifier, bool>((
  ref,
) {
  return LogOutStateNotifier(ref);
});

final createPasswordStateprovider =
    StateNotifierProvider<CreatePasswordStateNotifier, bool>((ref) {
      return CreatePasswordStateNotifier(ref);
    });

// final authUserInfoStateProvider = StateNotifierProvider.autoDispose<
//   AuthUserInfoStateNotifire,
//   AsyncValue<User>
// >((ref) {
//   return AuthUserInfoStateNotifire(ref);
// });
