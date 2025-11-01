import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:engaz_task/app/core/isar/cache_model.dart';
import 'package:engaz_task/app/core/l10n/language.dart';
import 'package:engaz_task/app/features/settings/domain/models/settings.dart';

part 'settings_isar.g.dart';

@collection
final class SettingsIsar extends CacheModel<Settings> {
  SettingsIsar({
    required this.language,
    required this.themeMode,
    super.id,
  });

  factory SettingsIsar.fromDomain(Settings domain) => SettingsIsar(
        language: domain.language,
        themeMode: domain.themeMode,
      );
  @Enumerated(EnumType.name)
  Language language;

  @Enumerated(EnumType.name)
  ThemeMode themeMode;

  @override
  Settings toDomain() {
    return Settings(
      language: language,
      themeMode: themeMode,
    );
  }
}
