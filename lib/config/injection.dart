import 'package:garden_app/config/routes.gr.dart';
import 'package:garden_app/data/database/database.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:garden_app/config/injection.config.dart';

GetIt getIt = GetIt.instance;

@InjectableInit()
void configureInjection(String environment) {
  $initGetIt(getIt, environment: environment);
}

@module
abstract class RegisterModule {
  @singleton
  Future<PlantDatabase> get database async =>
      await $FloorPlantDatabase.databaseBuilder('plant_database.db').build();

  @singleton
  AppRouter get appRouter => AppRouter();
}
