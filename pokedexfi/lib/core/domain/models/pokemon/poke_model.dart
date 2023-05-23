import 'package:pokedexfi/core/domain/models/pokemon/ability_model.dart';
import 'package:pokedexfi/core/domain/models/pokemon/other_model.dart';
import 'package:pokedexfi/core/domain/models/pokemon/stat_model.dart';
import 'package:pokedexfi/core/domain/models/pokemon/type_model.dart';
import 'package:pokedexfi/core/extensions/string_extensions.dart';

class Poke {
  final List<Ability> abilities;
  final int height;
  final int id;
  final String name;
  final List<Stat> stats;
  final List<Type> types;
  final int weight;
  final Other other;

  const Poke({
    required this.abilities,
    required this.height,
    required this.id,
    required this.name,
    required this.stats,
    required this.types,
    required this.weight,
    required this.other,
  });

  String get formattedId {
    if (id < 10) {
      return '#00$id';
    } else if (id < 100) {
      return '#0$id';
    } else {
      return '#$id';
    }
  }

  String get image {
    return other.officialArtwork.frontDefault ?? '';
  }

  String get formattedName {
    return name.capitalize();
  }

  String get formattedHeight {
    return '${height / 10} m';
  }

  String get formattedWeight {
    return '${weight / 10} kg';
  }

  static Poke fromMap(Map<String, dynamic> map) {
    return Poke(
      abilities: map['abilities'] != null
          ? List<Ability>.from(map['abilities'].map((x) => Ability.fromMap(x)))
          : [],
      height: map['height'] ?? 0,
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      stats: map['stats'] != null
          ? List<Stat>.from(map['stats'].map((x) => Stat.fromMap(x)))
          : [],
      types: map['types'] != null
          ? List<Type>.from(map['types'].map((x) => Type.fromMap(x)))
          : [],
      weight: map['weight'] ?? 0,
      other: map['sprites']['other'] != null
          ? Other.fromMap(map['sprites']['other'])
          : Other.empty(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'abilities': abilities.map((x) => x.toMap()).toList(),
      'height': height,
      'id': id,
      'name': name,
      'stats': stats.map((x) => x.toMap()).toList(),
      'types': types.map((x) => x.toMap()).toList(),
      'weight': weight,
      'sprites': {
        'other': other.toMap(),
      },
    };
  }
}
