class AppConstants {
  AppConstants._();

  // App name
  static const String appName = 'Rental Properties Management';
  static const String required = '*required';

  static const String sslPinnigSHA256 =
      '32:58:67:86:EE:44:1A:66:DC:1C:49:C1:84:15:BA:86:49:92:F0:A8:01:D4:96:39:9F:1F:C4:5D:1E:39:35:8D';

  static const String baseUrl = 'https://rental.razinsoft.com/api';

  // master
  static const String master = '$baseUrl/master';

  // Auth
  static const String login = '$baseUrl/tenant/login';
  static const String registration = '$baseUrl/tenant/registration';
  static const String forgetpassword = '$baseUrl/tenant/check-contact';
  static const String resetPassword = '$baseUrl/tenant/reset-password';
  static const String logout = '$baseUrl/tenant/logout';

  // Home
  static const String transactionRentSummary =
      '$baseUrl/tenant/transactions/rent-summary';
  static const String properties = '$baseUrl/tenant/properties';
  static const String propertyDetails = '$baseUrl/tenant/my-property';

  static const String transactions = '$baseUrl/tenant/transactions';
  static const String uploadTransactionProof = '$baseUrl/tenant/transaction/create';
  static const String maintenance = '$baseUrl/tenant/maintenance/tokens';
  static const String createMaintenanceRequest =
      '$baseUrl/tenant/maintenance/create';
  static const String categories = '$baseUrl/tenant/categories';
  static const String leaseDetails = '$baseUrl/tenant/property/lease-details';
  static const String notification = '$baseUrl/tenant/notifications';
  static const String markAsRead = '$baseUrl/tenant/notification/mark-as-read';

  // Profile
  static const String termsAndConditions = '$baseUrl/terms-and-conditions';
  static const String privacyPolicy = '$baseUrl/privacy-policy';

  // Hive boxes
  static const String appSettingsBox = 'appSettings';
  static const String authBox = 'authBox';
  static const String loginBox = 'loginBox';
  static const String cartBox = 'cartBox';
  static const String userBox = 'userBox';

  // Master data key
  static const String masterKey = 'masterKey';

  // Settings Veriable Names
  static const String firstOpen = 'firstOpen';
  static const String appLocal = 'appLocal';
  static const String themeMode = 'themeMode';
  static const String primaryColor = 'primaryColor';
  static const String appLogo = 'appLogo';
  static const String splashLogo = 'splashLogo';

  // Auth Variable Names
  static const String authToken = 'token';
  static const String userInfo = 'userInfo';

  // Dummy image gadget store
  static const String dummyNetworkImage = "https://picsum.photos/200/300";
}
