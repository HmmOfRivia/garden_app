import 'package:floor/floor.dart';

enum PlantType {
  alpines,
  aquatic,
  bulbs,
  succulents,
  carnivorous,
  climbers,
  ferns,
  grasses,
  threes,
}

@entity
class Plant {
  @primaryKey
  final int? id;
  final String name;
  final PlantType type;
  final DateTime plantDate;

  Plant({
    this.id,
    required this.name,
    required this.type,
    required this.plantDate,
  });

  String get plantSignature =>
      name.isNotEmpty ? '${name[0]} ${name[name.length - 1]}' : name;

  Plant copyWith({
    int? id,
    String? name,
    PlantType? type,
    DateTime? plantDate,
  }) {
    return Plant(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      plantDate: plantDate ?? this.plantDate,
    );
  }
}
