import 'dart:convert';

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

  factory Plant.fromMap(Map<String, dynamic> map) {
    return Plant(
      id: map['id']?.toInt(),
      name: map['name'] ?? '',
      type: map['type'],
      plantDate: map['plantDate'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'plantDate': plantDate,
      'type': type,
    };
  }

  factory Plant.fromJson(String source) => Plant.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Plant &&
        other.id == id &&
        other.name == name &&
        other.type == type &&
        other.plantDate == plantDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ type.hashCode ^ plantDate.hashCode;
  }
}
