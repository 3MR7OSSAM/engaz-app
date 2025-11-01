// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:engaz_task/app/app_bloc_observer.dart' as _i637;
import 'package:engaz_task/app/core/cubit/connectivity/connectivity_cubit.dart'
    as _i787;
import 'package:engaz_task/app/core/injection/logger_module.dart' as _i594;
import 'package:engaz_task/app/core/isar/isar_service.dart' as _i180;
import 'package:engaz_task/app/features/settings/data/sources/local/settings_isar_source.dart'
    as _i525;
import 'package:engaz_task/app/features/settings/domain/repository/settings_repository.dart'
    as _i128;
import 'package:engaz_task/app/features/settings/presentation/bloc/settings_bloc.dart'
    as _i443;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:logger/logger.dart' as _i974;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final loggerModule = _$LoggerModule();
    gh.singleton<_i787.ConnectivityCubit>(() => _i787.ConnectivityCubit());
    await gh.singletonAsync<_i180.IsarService>(
      () => _i180.IsarService.create(),
      preResolve: true,
    );
    gh.lazySingleton<_i974.Logger>(() => loggerModule.logger);
    gh.singleton<_i525.SettingsIsarSource>(
        () => _i525.SettingsIsarSource(gh<_i180.IsarService>()));
    gh.singleton<_i128.SettingsRepository>(
        () => _i128.SettingsRepository(gh<_i525.SettingsIsarSource>()));
    gh.lazySingleton<_i637.AppBlocObserver>(
        () => _i637.AppBlocObserver(gh<_i974.Logger>()));
    gh.factory<_i443.SettingsBloc>(
        () => _i443.SettingsBloc(gh<_i128.SettingsRepository>()));
    return this;
  }
}

class _$LoggerModule extends _i594.LoggerModule {}
