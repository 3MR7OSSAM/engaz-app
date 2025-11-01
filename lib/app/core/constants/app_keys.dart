import 'dart:ui';

class AppKeys {
  // Shared Preferences Keys
  static const String token = 'auth_token';
  static const String user = 'current_user';
  static const String rememberMe = 'remember_me';

  static const String lang = 'passId';
  static const String initialLocationRoute = 'initialLocationRoute';
  static const String expertsType = 'expertsType';
  static const String mainCategory = 'mainCategory';
  static const String isFavorite = 'isFavorite';
  static const String titleScreen = 'titleScreen';
  static const String isSearchMode = 'isSearchMode';
  static const String deviceToken = 'deviceToken';
  static const String accessToken = 'token';
  static const String refreshToken = 'refreshToken';
  static const String guestMail = 'guestMail';

  static const String appName = 'engaz_task';
  static const String localeKey = 'app_locale';
  static const String themeKey = 'app_theme';
  static const List<Locale> supportedLocales = [
    Locale('en'),
    Locale('ar'),
    Locale('fr'),
    Locale('tr'),
  ];
}
