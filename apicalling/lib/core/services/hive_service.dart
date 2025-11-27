import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../features/auth/models/user_model.dart';
import '../constants/app_constants.dart';

class HiveService {
  final Ref ref;
  HiveService(this.ref);

  // save data to the local storage

  // save access token
  Future saveUserAuthToken({required String authToken}) async {
    final authBox = Hive.box(AppConstants.authBox);
    await authBox.put(AppConstants.authToken, authToken);
  }

  // // remove access token
  // Future removeUserAuthToken() async {
  //   final authBox = Hive.box(AppConstants.authBox);
  //   await authBox.delete(AppConstants.authToken);
  // }

  Future saveUserInfo({required Map<String, dynamic> userInfo}) async {
    final userBox = Hive.box(AppConstants.userBox);
    final userModel = UserModel.fromMap(userInfo);

    // Save as Map instead of UserModel
    await userBox.put(AppConstants.userInfo, userModel.toMap());
    debugPrint("user info saved ${userModel.toMap()}");
  }

  Future<UserModel?> getUserInfo() async {
    final userBox = Hive.box(AppConstants.userBox);
    final userInfo = userBox.get(AppConstants.userInfo);

    // Convert Map back to UserModel
    if (userInfo != null && userInfo is Map) {
      return UserModel.fromMap(userInfo.cast<String, dynamic>());
    }
    return null;
  }

  // remove user data
  Future removeUserData() async {
    final userBox = Hive.box(AppConstants.userBox);
    userBox.clear();
  }

  // get user auth token
  Future<String?> getAuthToken() async {
    final authBox = Hive.box(AppConstants.authBox);
    final authToken = await authBox.get(AppConstants.authToken);
    if (authToken != null) {
      return authToken;
    }
    return null;
  }

  bool userIsLoggedIn() {
    final userAuthToken = Hive.box(
      AppConstants.authBox,
    ).get(AppConstants.authToken);
    return userAuthToken == null ? false : true;
  }

  // Save master data







  // Save selected language
  Future<void> saveSelectedLanguage(String language) async {
    final box = Hive.box(AppConstants.appSettingsBox);
    await box.put(AppConstants.appLocal, language);
    debugPrint("Language saved: $language");
  }

  // Get selected language
  Future<String> getSelectedLanguage() async {
    final box = Hive.box(AppConstants.appSettingsBox);
    final lang = box.get(AppConstants.appLocal, defaultValue: 'en');
    return lang;
  }

  // Sync getter for language (useful if already loaded)
  String get getSelectedLanguageSync {
    final box = Hive.box(AppConstants.appSettingsBox);
    return box.get(AppConstants.appLocal, defaultValue: 'en');
  }

  Future<void> saveLoginCredentials({
    required String contact,
    required String password,
  }) async {
    final box = Hive.box(AppConstants.loginBox);
    await box.put('contact', contact);
    await box.put('password', password);
  }

  Future<Map<String, String?>> getLoginCredentials() async {
    final box = Hive.box(AppConstants.loginBox);
    return {'contact': box.get('contact'), 'password': box.get('password')};
  }

  Future<bool> removeAllData() async {
    try {
      // ref.invalidate(selectedIndexBottomNavProvider);
      final authBox = Hive.box(AppConstants.authBox);
      final userBox = Hive.box(AppConstants.userBox);
      await userBox.clear();
      await authBox.clear(); // Clear all data in the authBox
      debugPrint('All data removed from authBox');
      return true;
    } catch (e) {
      debugPrint('Error clearing authBox: $e');
      return false;
    }
  }
}

final hiveServiceProvider = Provider((ref) => HiveService(ref));

final userControllerProvider = FutureProvider<UserModel?>((ref) async {
  final storage = ref.read(hiveServiceProvider);
  return storage.getUserInfo();
});
