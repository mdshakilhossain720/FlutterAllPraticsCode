import 'package:flutter_riverpod/legacy.dart';

import '../services/hive_service.dart';


class LanguageNotifier extends StateNotifier<String> {
  final HiveService hiveService;
  LanguageNotifier(this.hiveService)
    : super(hiveService.getSelectedLanguageSync);

  // change language and save to Hive
  Future<void> changeLanguage(String lang) async {
    await hiveService.saveSelectedLanguage(lang);
    state = lang; 
  }

 
  void reload() {
    state = hiveService.getSelectedLanguageSync;
  }
}

// Provider
final languageProvider = StateNotifierProvider<LanguageNotifier, String>((ref) {
  final hive = ref.read(hiveServiceProvider);
  return LanguageNotifier(hive);
});
