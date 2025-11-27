import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

enum AppEnvironment { development, production }

class Environment {
  static late final AppEnvironment current;

  static Future<void> init() async {
    if (kReleaseMode) {
      current = AppEnvironment.production;
      await dotenv.load(fileName: "assets/env/.env.production");
    } else {
      current = AppEnvironment.development;
      await dotenv.load(fileName: "assets/env/.env.development");
    }
  }

  static String get apiKey =>
      dotenv.env['API_KEY'] ?? 'API_KEY not found';

  static String get apiBaseUrl =>
      dotenv.env['API_BASE_URL'] ?? 'API_BASE_URL not found';
}
