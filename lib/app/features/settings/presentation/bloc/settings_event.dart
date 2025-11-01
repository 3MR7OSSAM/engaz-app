part of 'settings_bloc.dart';

sealed class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

final class SettingsFetched extends SettingsEvent {
  const SettingsFetched();
}

final class SettingsLanguageChanged extends SettingsEvent {
  const SettingsLanguageChanged(this.language);
  final Language language;

  @override
  List<Object> get props => [language];
}

final class SettingsThemeChanged extends SettingsEvent {
  const SettingsThemeChanged(this.themeMode);
  final ThemeMode themeMode;

  @override
  List<Object> get props => [themeMode];
}