import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';


import '../constants/app_constants.dart';

final languageServiceProvider = Provider((ref) => LanguageService());

final currentLanguageProvider = FutureProvider<String>((ref) async {
  final service = ref.watch(languageServiceProvider);
  return await service.getLanguage();
});

class LanguageService {
  static const String _languageKey = AppConstants.appLocal;

  // Save language to Hive
  Future<void> saveLanguage(String languageCode) async {
    final box = Hive.box(AppConstants.appSettingsBox);
    await box.put(_languageKey, languageCode);
  }

  // Get language from Hive
  Future<String> getLanguage() async {
    final box = Hive.box(AppConstants.appSettingsBox);
    return box.get(_languageKey, defaultValue: 'en');
  }

  // Clear language
  Future<void> clearLanguage() async {
    final box = Hive.box(AppConstants.appSettingsBox);
    await box.delete(_languageKey);
  }
}
