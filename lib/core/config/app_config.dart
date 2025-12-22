/// Application Configuration
class AppConfig {
  AppConfig._();

  static const String appName = 'Flutter Forge App';
  static const String appVersion = '1.0.0';
  static const String buildNumber = '1';

  // Developer Info
  static const String developerName = 'Omar Abokhalel';
  static const String developerGithub = 'https://github.com/omarmoabokhalel';
  static const String developerLinkedIn =
      'https://www.linkedin.com/in/omarmoabokhalel';
  static const String developerEmail = 'omarabokhalel9@gmail.com';

  // Environment
  static const bool isProduction = false;
  static const bool enableLogging = true;

  // API Configuration
  static String get baseUrl {
    return isProduction
        ? 'https://api.production.com'
        : 'https://api.development.com';
  }
}
