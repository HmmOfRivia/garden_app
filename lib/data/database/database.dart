import 'package:floor/floor.dart';
import 'package:garden_app/data/converters/date_time_converter.dart';
import 'package:garden_app/data/converters/plant_type_converter.dart';

import 'package:garden_app/data/dao/plant_dao.dart';
import 'package:garden_app/data/entity/plant.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'dart:async';

part 'database.g.dart';

@TypeConverters([DateTimeConverter, PlantTypeConverter])
@Database(version: 1, entities: [Plant])
abstract class PlantDatabase extends FloorDatabase {
  PlantDao get plantDao;
}
