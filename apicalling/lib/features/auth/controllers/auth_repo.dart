import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rentalmanagement/core/constants/app_constants.dart';
import 'package:rentalmanagement/core/network/api_client.dart';
import 'package:rentalmanagement/features/auth/models/sign_up_model.dart';

abstract class AuthRepo {
  Future<Response> login({required String email, required String password});
  Future<Response> registration({required SignUpModel signUpModel});
  Future<Response> getUserInfo();
  Future<Response> forgotPassword({required String contact});
  Future<Response> createPassword({
    required String contact,
    required String password,
    required String confirmpassword,
  });
  Future<Response> logout();
}

class AuthService implements AuthRepo {
  final Ref ref;
  AuthService(this.ref);

  @override
  Future<Response> registration({required SignUpModel signUpModel}) async {
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    final response = await ref
        .read(apiClientProvider)
        .post(
          AppConstants.registration,
          data: {
            ...signUpModel.toMap(),
            "fcm_token": fcmToken,
            "device_os": Platform.isIOS ? 'ios' : 'android',
          },
        );
    debugPrint('response: ${response.data}');
    debugPrint('responsestatuscode: ${response.statusCode}');
    return response;
  }

  @override
  Future<Response> login({
    required String email,
    required String password,
  }) async {
    String? fcmToken = await FirebaseMessaging.instance.getToken();

    final response = await ref
        .read(apiClientProvider)
        .post(
          AppConstants.login,
          data: {
            "contact": email,
            "password": password,
            "fcm_token": fcmToken,
            "device_os": Platform.isIOS ? 'ios' : 'android',
          },
        );
    return response;
  }

  @override
  Future<Response> getUserInfo() async {
    final response = await ref
        .read(apiClientProvider)
        .get(AppConstants.userInfo);
    return response;
  }

  @override
  Future<Response> forgotPassword({required String contact}) {
    final response = ref
        .read(apiClientProvider)
        .post(AppConstants.forgetpassword, data: {"contact": contact});
    return response;
  }

  @override
  Future<Response> createPassword({
    required String contact,
    required String password,
    required String confirmpassword,
  }) async {
    final response = await ref
        .read(apiClientProvider)
        .post(
          AppConstants.resetPassword,
          data: {
            "password": password,
            "password_confirmation": confirmpassword,
            "contact": contact,
          },
        );
    return response;
  }

  @override
  Future<Response> logout() async {
    final response = await ref
        .read(apiClientProvider)
        .post(AppConstants.logout);

    return response;
  }
}
