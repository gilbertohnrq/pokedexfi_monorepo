enum PokeStats {
  hp,
  attack,
  defense,
  specialAttack,
  specialDefense,
  speed,
  none,
}

extension PokeStatsExtension on PokeStats {
  String get title {
    switch (this) {
      case PokeStats.hp:
        return 'HP';
      case PokeStats.attack:
        return 'ATK';
      case PokeStats.defense:
        return 'DEF';
      case PokeStats.specialAttack:
        return 'SATK';
      case PokeStats.specialDefense:
        return 'SDEF';
      case PokeStats.speed:
        return 'SPD';
      case PokeStats.none:
        return '';
      default:
        return '';
    }
  }
}
