import 'package:floor/floor.dart';
import 'package:garden_app/data/entity/plant.dart';

class PlantTypeConverter extends TypeConverter<PlantType, String> {
  @override
  PlantType decode(String databaseValue) {
    return PlantType.values.firstWhere(
      (element) => element.name == databaseValue,
    );
  }

  @override
  String encode(PlantType value) {
    return value.name;
  }
}
