import 'package:engaz_task/app/features/settings/data/sources/local/settings_isar_source.dart';
import 'package:engaz_task/app/features/settings/domain/models/settings.dart';
import 'package:injectable/injectable.dart';

@singleton
final class SettingsRepository {
  const SettingsRepository(this._localSource);
  final SettingsIsarSource _localSource;

  Future<void> updateSettings(Settings settings) async =>
      _localSource.updateSettings(settings);

  Future<Settings> getSettings() async => _localSource.getSettings();
}
