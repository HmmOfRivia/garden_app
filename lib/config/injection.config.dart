// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../data/database/database.dart' as _i4;
import '../data/repositories/plants_repository.dart' as _i5;
import '../logic/plants_page/plants_page_cubit.dart' as _i6;
import 'injection.dart' as _i7;
import 'routes.gr.dart' as _i3; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final registerModule = _$RegisterModule();
  gh.singleton<_i3.AppRouter>(registerModule.appRouter);
  gh.singletonAsync<_i4.PlantDatabase>(() => registerModule.database);
  gh.singletonAsync<_i5.PlantsRepository>(() async =>
      _i5.PlantsRepository(await get.getAsync<_i4.PlantDatabase>()));
  gh.singletonAsync<_i6.PlantsPageCubit>(() async =>
      _i6.PlantsPageCubit(await get.getAsync<_i5.PlantsRepository>()));
  return get;
}

class _$RegisterModule extends _i7.RegisterModule {}
