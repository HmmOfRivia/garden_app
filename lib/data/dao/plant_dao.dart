import 'package:floor/floor.dart';
import 'package:garden_app/data/entity/plant.dart';

@dao
abstract class PlantDao {
  @Query('SELECT * FROM Plant WHERE id < :id ORDER BY id DESC LIMIT :quantity')
  Future<List<Plant>> getPlantsAfterId(int id, int quantity);

  @Query('SELECT * FROM Plant ORDER BY id DESC LIMIT :quantity')
  Future<List<Plant>> getFirstPlants(int quantity);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertPlant(Plant plant);
}
