import 'package:dartz/dartz.dart';
import 'package:garden_app/data/database/database.dart';
import 'package:garden_app/data/entity/plant.dart';
import 'package:injectable/injectable.dart';

@singleton
class PlantsRepository {
  final PlantDatabase _database;
  PlantsRepository(this._database);

  Future<Either<Exception, List<Plant>>> getPlants({
    int? after,
    int quantity = 10,
  }) async {
    try {
      late List<Plant> plants;
      if (after == null) {
        plants = await _database.plantDao.getFirstPlants(quantity);
      } else {
        plants = await _database.plantDao.getPlantsAfterId(after, quantity);
      }
      return right(plants);
    } catch (_) {
      return left(Exception());
    }
  }

  Future<bool> insertPlant(Plant plant) async {
    try {
      await _database.plantDao.insertPlant(plant);
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<bool> updatePlant(Plant plant) async {
    try {
      await _database.plantDao.updatePlant(plant);
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<Either<Exception, List<Plant>>> getPlantsByText(String text) async {
    try {
      final plants = await _database.plantDao.getPlantsByName('%$text%');
      return right(plants);
    } catch (_) {
      return left(Exception());
    }
  }
}
