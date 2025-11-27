import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:rentalmanagement/core/models/common_response.dart';
import 'package:rentalmanagement/core/services/hive_service.dart';
import 'package:rentalmanagement/features/auth/controllers/auth_provider.dart';
import 'package:rentalmanagement/features/auth/models/sign_up_model.dart';

class LoginStateNotifier extends StateNotifier<bool> {
  final Ref ref;
  LoginStateNotifier(this.ref) : super(false);

  Future<CommonResponseModel> login({
    required String email,
    required String password,
  }) async {
    state = true;
    try {
      final response = await ref
          .read(authServiceProvider)
          .login(email: email, password: password);

      if (response.statusCode == 200) {
        await ref
            .read(hiveServiceProvider)
            .saveLoginCredentials(contact: email, password: password);
        final authToken = response.data['data']["access"]['token'];
        final userInfo = response.data['data']["user"];

        await ref
            .read(hiveServiceProvider) 
            .saveUserAuthToken(authToken: authToken);

        await ref.read(hiveServiceProvider).saveUserInfo(userInfo: userInfo);
        state = false;
        return CommonResponseModel(
          isSuccess: true,
          message: response.data['message'],
        );
      }
      state = false;
      return CommonResponseModel(
        isSuccess: false,
        message: response.data['message'],
      );
    } catch (error) {
      state = false;
      debugPrint("login error: ${error.toString()}");
      return CommonResponseModel(isSuccess: false, message: error.toString());
    }
  }
}

class RegistrationStateNotifier extends StateNotifier<bool> {
  final Ref ref;
  RegistrationStateNotifier(this.ref) : super(false);

  Future<CommonResponseModel> registration(SignUpModel signUpModel) async {
    try {
      state = true;
      final response = await ref
          .read(authServiceProvider)
          .registration(signUpModel: signUpModel);

      if (response.statusCode == 200) {
        state = false;
        return CommonResponseModel(
          isSuccess: true,
          message: response.data['message'],
        );
      }
      state = false;
      return CommonResponseModel(
        isSuccess: false,
        message: response.data['message'],
      );
    } catch (error) {
      state = false;
      debugPrint("signup error: ${error.toString()}");
      return CommonResponseModel(isSuccess: false, message: error.toString());
    }
  }
}

class ForgetStateNotifier extends StateNotifier<bool> {
  final Ref ref;
  ForgetStateNotifier(this.ref) : super(false);

  // forgetpassword
  Future<CommonResponseModel> forgetPassword({required String contact}) async {
    try {
      state = true;
      final response = await ref
          .read(authServiceProvider)
          .forgotPassword(contact: contact);
      if (response.statusCode == 200) {
        state = false;
        return CommonResponseModel(
          isSuccess: true,
          message: response.data['message'],
        );
      }
      state = false;
      return CommonResponseModel(
        isSuccess: false,
        message: response.data['message'],
      );
    } catch (error) {
      state = false;
      debugPrint("signup error: ${error.toString()}");
      return CommonResponseModel(isSuccess: false, message: error.toString());
    }
  }
}

class LogOutStateNotifier extends StateNotifier<bool> {
  final Ref ref;
  LogOutStateNotifier(this.ref) : super(false);
  Future<CommonResponseModel> logout() async {
    try {
      state = true;
      final response = await ref.read(authServiceProvider).logout();
      final String message = response.data['message'];
      state = false;
      return CommonResponseModel(isSuccess: true, message: message);
    } catch (error) {
      state = false;
      debugPrint(error.toString());
      return CommonResponseModel(isSuccess: false, message: error.toString());
    }
  }
}

class CreatePasswordStateNotifier extends StateNotifier<bool> {
  final Ref ref;
  CreatePasswordStateNotifier(this.ref) : super(false);
  Future<CommonResponseModel> createPassword({
    required String contact,
    required String password,
    required String confirmpassword,
  }) async {
    try {
      state = true;
      final response = await ref
          .read(authServiceProvider)
          .createPassword(
            contact: contact,
            password: password,
            confirmpassword: confirmpassword,
          );
      if (response.statusCode == 200) {
        state = false;
        return CommonResponseModel(
          isSuccess: true,
          message: response.data['message'],
        );
      }
      state = false;
      return CommonResponseModel(
        isSuccess: false,
        message: response.data['message'],
      );
    } catch (error) {
      state = false;
      debugPrint(error.toString());
      return CommonResponseModel(isSuccess: false, message: error.toString());
    }
  }
}

// class AuthUserInfoStateNotifire extends StateNotifier<AsyncValue<User>> {
//   final Ref ref;

//   AuthUserInfoStateNotifire(this.ref) : super(const AsyncValue.loading()) {
//     getAuthUserInfo();
//   }

//   Future<void> getAuthUserInfo() async {
//     try {
//       final response = await ref.read(authServiceProvider).getUserInfo();
//       final userData = response.data["data"];
//       final authUser = User.fromMap(userData);
//       final user = await ref.read(hiveStorageProvider).getUserInfo();
//       debugPrint("useris: $user");
//       if (user == null) {
//         await ref.read(hiveStorageProvider).saveUserInfo(userInfo: authUser);
//       }
//       state = AsyncValue.data(authUser);
//     } catch (e, stackTrace) {
//       debugPrint(e.toString());
//       debugPrint(stackTrace.toString());
//       final errorMessage = e is DioException
//           ? AddApiInterceptors.handleError(e)
//           : e.toString();

//       state = AsyncValue.error(errorMessage, stackTrace);
//     }
//   }
// }
