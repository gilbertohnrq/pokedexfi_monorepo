import 'package:pokedexfi/core/domain/enums/poke_stats.dart';
import 'package:pokedexfi/core/domain/models/common/common_model.dart';

class Stat {
  final int? baseStat;
  final int? effort;
  final Common? stat;

  const Stat({
    required this.baseStat,
    this.effort,
    this.stat,
  });

  String get baseStatFormatted {
    return baseStat.toString().padLeft(3, '0');
  }

  PokeStats get pokeStat {
    if (stat == null) return PokeStats.none;

    switch (stat!.name) {
      case 'hp':
        return PokeStats.hp;
      case 'attack':
        return PokeStats.attack;
      case 'defense':
        return PokeStats.defense;
      case 'special-attack':
        return PokeStats.specialAttack;
      case 'special-defense':
        return PokeStats.specialDefense;
      case 'speed':
        return PokeStats.speed;
      default:
        return PokeStats.none;
    }
  }

  factory Stat.fromMap(Map<String, dynamic> map) {
    return Stat(
      baseStat: map['base_stat'] as int?,
      effort: map['effort'] as int?,
      stat: Common.fromMap(map['stat'] as Map<String, dynamic>? ?? {}),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'base_stat': baseStat,
      'effort': effort,
      'stat': stat?.toMap(),
    };
  }

  @override
  bool operator ==(covariant Stat other) {
    if (identical(this, other)) return true;

    return other.baseStat == baseStat &&
        other.effort == effort &&
        other.stat == stat;
  }

  @override
  int get hashCode => baseStat.hashCode ^ effort.hashCode ^ stat.hashCode;
}
