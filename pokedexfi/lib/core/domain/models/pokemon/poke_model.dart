import 'package:pokedexfi/core/domain/models/pokemon/ability_model.dart';
import 'package:pokedexfi/core/domain/models/pokemon/other_model.dart';
import 'package:pokedexfi/core/domain/models/pokemon/stat_model.dart';
import 'package:pokedexfi/core/domain/models/pokemon/type_model.dart';

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

  static Poke fromMap(Map<String, dynamic> map) {
    return Poke(
      abilities:
          List<Ability>.from(map['abilities'].map((x) => Ability.fromMap(x))),
      height: map['height'],
      id: map['id'],
      name: map['name'],
      stats: List<Stat>.from(map['stats'].map((x) => Stat.fromMap(x))),
      types: List<Type>.from(map['types'].map((x) => Type.fromMap(x))),
      weight: map['weight'],
      other: map['sprites']['other'] != null
          ? Other.fromMap(map['sprites']['other'])
          : Other.empty(),
    );
  }
}
