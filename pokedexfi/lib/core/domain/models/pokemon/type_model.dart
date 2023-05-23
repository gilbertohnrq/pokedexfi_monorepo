import 'package:flutter/material.dart';
import 'package:pokedexfi/core/domain/enums/pokemon_types.dart';

class Type {
  final String? name;
  final int? slot;
  final Color? color;

  const Type({this.name, this.color, this.slot});

  static Color _getColor(String type) {
    for (var element in PokemonTypes.values) {
      if (element.toString().toLowerCase() == type.toLowerCase()) {
        return element.color;
      }
    }
    return PokemonTypes.unknown.color;
  }

  factory Type.fromMap(Map<String, dynamic> map) {
    String typeName = map['type']['name'] as String? ?? '';
    int slot = map['slot'] as int? ?? 0;
    return Type(
      name: typeName,
      slot: slot,
      color: _getColor(typeName),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': {
        'name': name,
      },
      'slot': slot,
    };
  }
}
