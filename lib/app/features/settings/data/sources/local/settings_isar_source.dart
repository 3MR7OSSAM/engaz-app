import 'dart:async';
import 'package:engaz_task/app/core/isar/isar_source.dart';
import 'package:engaz_task/app/features/settings/data/sources/local/settings_isar.dart';
import 'package:engaz_task/app/features/settings/domain/models/settings.dart';
import 'package:injectable/injectable.dart';

@singleton
final class SettingsIsarSource extends IsarSource<Settings, SettingsIsar> {
  SettingsIsarSource(super.isarService);

  Future<void> updateSettings(Settings settings) async {
    clear();
    final settingsIsar = SettingsIsar.fromDomain(settings);
    put(settingsIsar);
  }

  Future<Settings> getSettings() async {
    final settingsIsar = await getFirst();
    return settingsIsar?.toDomain() ?? const Settings();
  }

  SettingsIsar fromDomain(Settings dm) => SettingsIsar.fromDomain(dm);
}
