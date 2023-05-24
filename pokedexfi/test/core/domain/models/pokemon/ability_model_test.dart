import 'package:flutter_test/flutter_test.dart';
import 'package:pokedexfi/core/domain/models/common/common_model.dart';
import 'package:pokedexfi/core/domain/models/pokemon/ability_model.dart';

void main() {
  group('Ability', () {
    const common = Common(name: 'Test Name', url: 'www.test.com');
    const abilityMap = {
      'ability': {'name': 'Test Name', 'url': 'www.test.com'},
      'slot': 1,
    };

    test('should correctly convert from map', () {
      final ability = Ability.fromMap(abilityMap);
      expect(ability.ability.name, 'Test Name');
      expect(ability.ability.url, 'www.test.com');
      expect(ability.slot, 1);
    });

    test('should correctly convert to map', () {
      const ability = Ability(ability: common, slot: 1);
      final map = ability.toMap();
      expect(map['ability']['name'], 'Test Name');
      expect(map['ability']['url'], 'www.test.com');
      expect(map['slot'], 1);
    });

    test('should correctly compare equal abilities', () {
      const ability1 = Ability(ability: common, slot: 1);
      const ability2 = Ability(ability: common, slot: 1);
      expect(ability1, ability2);
    });

    test('should have correct hash code', () {
      const ability = Ability(ability: common, slot: 1);
      final hashCode = common.hashCode ^ 1.hashCode;
      expect(ability.hashCode, hashCode);
    });
  });
}
