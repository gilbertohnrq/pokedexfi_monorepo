import 'package:flutter_test/flutter_test.dart';
import 'package:pokedexfi/core/domain/enums/poke_stats.dart';
import 'package:pokedexfi/core/domain/models/common/common_model.dart';
import 'package:pokedexfi/core/domain/models/pokemon/stat_model.dart';

void main() {
  group('Stat', () {
    const common = Common(name: 'Attack', url: 'Stat URL');
    final statMap = {
      'base_stat': 100,
      'effort': 1,
      'stat': {'name': 'Attack', 'url': 'Stat URL'},
    };

    test('should correctly convert from map', () {
      final stat = Stat.fromMap(statMap);
      expect(stat.baseStat, 100);
      expect(stat.effort, 1);
      expect(stat.stat!.name, common.name);
      expect(stat.stat!.url, common.url);
    });

    test('should correctly convert to map', () {
      const stat = Stat(
        baseStat: 100,
        effort: 1,
        stat: common,
      );
      final map = stat.toMap();
      expect(map, statMap);
    });

    test('should correctly format base stat', () {
      const stat = Stat(
        baseStat: 100,
        effort: 1,
        stat: common,
      );
      expect(stat.baseStatFormatted, '100');
    });

    test('should return PokeStats.none for unknown stat name', () {
      const unknownStat = Common(name: 'unknown', url: 'Unknown URL');
      const stat = Stat(
        baseStat: 100,
        effort: 1,
        stat: unknownStat,
      );
      expect(stat.pokeStat, PokeStats.none);
    });

    test('should correctly compare equal stats', () {
      const stat1 = Stat(
        baseStat: 100,
        effort: 1,
        stat: common,
      );
      const stat2 = Stat(
        baseStat: 100,
        effort: 1,
        stat: common,
      );
      expect(stat1, stat2);
    });

    test('should have correct hash code', () {
      const stat = Stat(
        baseStat: 100,
        effort: 1,
        stat: common,
      );
      final hashCode = 100.hashCode ^ 1.hashCode ^ common.hashCode;
      expect(stat.hashCode, hashCode);
    });
  });
}
