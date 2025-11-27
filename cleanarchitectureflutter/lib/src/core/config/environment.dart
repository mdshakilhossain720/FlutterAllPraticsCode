import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

enum AppEnvironment { development, production }

class Environment {
  static late final AppEnvironment current;
  static String? _apiOverride;

  /// Initialize environment
  static Future<void> init() async {
    if (kReleaseMode) {
      current = AppEnvironment.production;
      await dotenv.load(fileName: "assets/env/.env.production");
    } else {
      current = AppEnvironment.development;
      await dotenv.load(fileName: "assets/env/.env.development");
    }
  }

  /// Allow runtime API override (for debug panel, testers, etc.)
  static void overrideApiBaseUrl(String url) {
    _apiOverride = url;
  }

  /// Main Base URL
  static String get baseUrl {
    if (_apiOverride != null) return _apiOverride!;
    return dotenv.env['API_BASE_URL'] ?? "API_BASE_URL_NOT_FOUND";
  }

  /// API URL (base + /api/)
  static String get apiUrl => "$baseUrl/api/";

  /// Example: Maps Key, Pusher Key, etc.
  static String get apiKey =>
      dotenv.env['API_KEY'] ?? "API_KEY_NOT_FOUND";

  static String get googleMapsKey =>
      dotenv.env['GOOGLE_MAPS_API_KEY'] ?? "GOOGLE_MAPS_API_KEY_NOT_FOUND";

  static String get pusherKey =>
      dotenv.env['PUSHER_API_KEY'] ?? "PUSHER_API_KEY_NOT_FOUND";

  static String get pusherCluster =>
      dotenv.env['PUSHER_CLUSTER'] ?? "PUSHER_CLUSTER_NOT_FOUND";

  /// Debug helper
  static bool get isProd => current == AppEnvironment.production;
  static bool get isDev => current == AppEnvironment.development;
}
