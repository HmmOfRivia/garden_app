import 'package:floor/floor.dart';
import 'package:garden_app/data/entity/plant.dart';

@dao
abstract class PlantDao {
  @Query('SELECT * FROM Plant WHERE id > :id LIMIT 10')
  Future<List<Plant>> getPlantsAfterId(int id);

  @Insert(onConflict: OnConflictStrategy.ignore)
  Future<void> insertPlant(Plant plant);
}
