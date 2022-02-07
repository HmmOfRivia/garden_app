import 'package:dartz/dartz.dart';
import 'package:garden_app/data/database/database.dart';
import 'package:garden_app/data/entity/plant.dart';
import 'package:injectable/injectable.dart';

@singleton
class PlantsRepository {
  final PlantDatabase _database;
  PlantsRepository(this._database);

  Future<Either<Exception, List<Plant>>> getPlants(
    int after,
    int quantity,
  ) async {
    try {
      final plants = await _database.plantDao.getPlantsAfterId(after, quantity);
      return right(plants);
    } catch (_) {
      return left(Exception());
    }
  }

  Future<void> insertPlant(Plant plant) async {
    try {
      await _database.plantDao.insertPlant(plant);
    } catch (_) {
      throw Exception();
    }
  }
}
