import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:engaz_task/app/core/l10n/language.dart';
import 'package:engaz_task/app/core/models/status.dart';
import 'package:engaz_task/app/features/settings/domain/models/settings.dart';
import 'package:engaz_task/app/features/settings/domain/repository/settings_repository.dart';

part 'settings_event.dart';

@injectable
class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc(this._repository) : super(const Initial(Settings())) {
    on<SettingsLanguageChanged>(_onLanguageChanged);
    on<SettingsThemeChanged>(_onThemeChanged);
    on<SettingsFetched>(_onFetched);

    add(const SettingsFetched());
  }
  final SettingsRepository _repository;

  Future<void> _onFetched(
    SettingsFetched event,
    Emitter<SettingsState> emit,
  ) async {
    emit(state.toLoading());
    final savedSettings = await _repository.getSettings();
    emit(state.toSuccess(savedSettings));
  }

  Future<void> _onLanguageChanged(
    SettingsLanguageChanged event,
    Emitter<SettingsState> emit,
  ) async {
    final newSettings = state.settings.copyWith(language: event.language);
    emit(state.toSuccess(newSettings));
    unawaited(_repository.updateSettings(newSettings));
  }

  Future<void> _onThemeChanged(
    SettingsThemeChanged event,
    Emitter<SettingsState> emit,
  ) async {
    final newSettings = state.settings.copyWith(themeMode: event.themeMode);
    emit(state.toSuccess(newSettings));
    unawaited(_repository.updateSettings(newSettings));
  }
}

typedef SettingsState = Status<Settings>;

extension X on SettingsState {
  Settings get settings => switch (this) {
        Initial<Settings>(initialData: final settings) => settings!,
        Success<Settings>(newData: final settings) => settings,
        Failure<Settings>(oldData: final settings) => settings!,
        Loading<Settings>(currentData: final settings) => settings!,
      };
}
