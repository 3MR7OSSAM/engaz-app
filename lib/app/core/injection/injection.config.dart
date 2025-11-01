// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:engaz_task/app/app_bloc_observer.dart' as _i637;
import 'package:engaz_task/app/core/cubits/connectivity/connectivity_cubit.dart'
    as _i619;
import 'package:engaz_task/app/core/injection/logger_module.dart' as _i594;
import 'package:engaz_task/app/core/injection/network_module.dart' as _i411;
import 'package:engaz_task/app/core/isar/isar_service.dart' as _i180;
import 'package:engaz_task/app/core/network/api_consumer.dart' as _i926;
import 'package:engaz_task/app/core/network/dio_consumer.dart' as _i133;
import 'package:engaz_task/app/features/menu/data/datasources/menu_remote_data_source.dart'
    as _i913;
import 'package:engaz_task/app/features/menu/data/repositories/menu_repository_impl.dart'
    as _i646;
import 'package:engaz_task/app/features/menu/domain/repositories/menu_repository.dart'
    as _i735;
import 'package:engaz_task/app/features/menu/domain/usecases/get_menu_usecase.dart'
    as _i467;
import 'package:engaz_task/app/features/menu/presentation/cubit/menu_cubit.dart'
    as _i577;
import 'package:engaz_task/app/features/restaurants/data/datasources/restaurant_remote_data_source.dart'
    as _i868;
import 'package:engaz_task/app/features/restaurants/data/repositories/restaurant_repository_impl.dart'
    as _i288;
import 'package:engaz_task/app/features/restaurants/domain/repositories/restaurant_repository.dart'
    as _i297;
import 'package:engaz_task/app/features/restaurants/domain/usecases/get_restaurants_usecase.dart'
    as _i33;
import 'package:engaz_task/app/features/restaurants/presentation/cubit/restaurant_cubit.dart'
    as _i650;
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
    final networkModule = _$NetworkModule();
    gh.singleton<_i619.ConnectivityCubit>(() => _i619.ConnectivityCubit());
    await gh.singletonAsync<_i180.IsarService>(
      () => _i180.IsarService.create(),
      preResolve: true,
    );
    gh.lazySingleton<_i974.Logger>(() => loggerModule.logger);
    gh.lazySingleton<_i361.Dio>(() => networkModule.dio);
    gh.singleton<_i525.SettingsIsarSource>(
        () => _i525.SettingsIsarSource(gh<_i180.IsarService>()));
    gh.singleton<_i128.SettingsRepository>(
        () => _i128.SettingsRepository(gh<_i525.SettingsIsarSource>()));
    gh.lazySingleton<_i637.AppBlocObserver>(
        () => _i637.AppBlocObserver(gh<_i974.Logger>()));
    gh.lazySingleton<_i926.ApiConsumer>(
        () => _i133.DioConsumer(client: gh<_i361.Dio>()));
    gh.lazySingleton<_i868.RestaurantRemoteDataSource>(() =>
        _i868.RestaurantRemoteDataSourceImpl(
            apiConsumer: gh<_i926.ApiConsumer>()));
    gh.factory<_i443.SettingsBloc>(
        () => _i443.SettingsBloc(gh<_i128.SettingsRepository>()));
    gh.lazySingleton<_i913.MenuRemoteDataSource>(() =>
        _i913.MenuRemoteDataSourceImpl(apiConsumer: gh<_i926.ApiConsumer>()));
    gh.lazySingleton<_i735.MenuRepository>(() => _i646.MenuRepositoryImpl(
        remoteDataSource: gh<_i913.MenuRemoteDataSource>()));
    gh.lazySingleton<_i297.RestaurantRepository>(() =>
        _i288.RestaurantRepositoryImpl(
            remoteDataSource: gh<_i868.RestaurantRemoteDataSource>()));
    gh.lazySingleton<_i467.GetMenuUseCase>(
        () => _i467.GetMenuUseCase(repository: gh<_i735.MenuRepository>()));
    gh.lazySingleton<_i33.GetRestaurantsUseCase>(() =>
        _i33.GetRestaurantsUseCase(
            repository: gh<_i297.RestaurantRepository>()));
    gh.factory<_i650.RestaurantCubit>(() => _i650.RestaurantCubit(
        getRestaurantsUseCase: gh<_i33.GetRestaurantsUseCase>()));
    gh.factory<_i577.MenuCubit>(
        () => _i577.MenuCubit(getMenuUseCase: gh<_i467.GetMenuUseCase>()));
    return this;
  }
}

class _$LoggerModule extends _i594.LoggerModule {}

class _$NetworkModule extends _i411.NetworkModule {}
