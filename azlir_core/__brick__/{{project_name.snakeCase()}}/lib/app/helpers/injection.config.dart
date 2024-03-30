// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:{{project_name}}/app/helpers/service_module.dart' as _i9;
import 'package:{{project_name}}/app/observers/app_auto_route_observer.dart'
    as _i7;
import 'package:{{project_name}}/app/observers/app_riverpod_observer.dart'
    as _i6;
import 'package:{{project_name}}/app/routes/app_router.dart' as _i4;
import 'package:{{project_name}}/core/repositories/local_storage_repository.dart'
    as _i8;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:logger/logger.dart' as _i5;
import 'package:shared_preferences/shared_preferences.dart' as _i3;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final serviceModule = _$ServiceModule();
    await gh.factoryAsync<_i3.SharedPreferences>(
      () => serviceModule.sharedPreferences(),
      preResolve: true,
    );
    gh.lazySingleton<_i4.AppRouter>(() => _i4.AppRouter());
    gh.lazySingleton<_i5.Logger>(() => serviceModule.logger);
    gh.lazySingleton<_i6.AppRiverpodObserver>(() => _i6.AppRiverpodObserver());
    gh.lazySingleton<_i7.AppAutoRouteObserver>(
        () => _i7.AppAutoRouteObserver());
    gh.lazySingleton<_i8.LocalStorageRepository>(
        () => _i8.LocalStorageRepository(storage: gh<_i3.SharedPreferences>()));
    return this;
  }
}

class _$ServiceModule extends _i9.ServiceModule {}
