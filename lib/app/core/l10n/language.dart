import 'dart:ui';
import 'package:engaz_task/app/core/l10n/locales.dart';

// Never change the order.
// Original order: 1- arabic, 2- english
enum Language {
  arabic('ar', Locales.arabic, 'العربية'),
  english('en', Locales.english, 'English');

  const Language(this.code, this.locale, this.name);

  final Locale locale;
  final String code;
  final String name;
}

extension LanguageX on Language {
  bool get isArabic => this == Language.arabic;
  bool get isEnglish => this == Language.english;
}
