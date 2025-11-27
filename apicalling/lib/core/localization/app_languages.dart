class AppLanguages {
  static const String en = 'en';
  static const String es = 'es';

  static final List<String> languages = [en, es];

  static String getLanguageLabel(String code) {
    switch (code) {
      case en:
        return 'English';
      case es:
        return 'Spanish';

      default:
        return code;
    }
  }
}
