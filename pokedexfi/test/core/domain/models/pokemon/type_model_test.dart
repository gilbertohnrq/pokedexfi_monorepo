import 'package:flutter_test/flutter_test.dart';
import 'package:pokedexfi/core/domain/enums/pokemon_types.dart';
import 'package:pokedexfi/core/domain/models/pokemon/type_model.dart';

void main() {
  group('Type', () {
    const typeName = 'Fire';
    const slot = 1;
    final typeMap = {
      'type': {'name': typeName},
      'slot': slot,
    };

    test('should correctly convert from map', () {
      final type = Type.fromMap(typeMap);
      expect(type.name, typeName);
      expect(type.slot, slot);
      expect(type.color, PokemonTypes.fire.color);
    });

    test('should correctly convert to map', () {
      final type =
          Type(name: typeName, slot: slot, color: PokemonTypes.fire.color);
      final map = type.toMap();
      expect(map, typeMap);
    });

    test('should correctly compare equal types', () {
      final type1 =
          Type(name: typeName, slot: slot, color: PokemonTypes.fire.color);
      final type2 =
          Type(name: typeName, slot: slot, color: PokemonTypes.fire.color);
      expect(type1, type2);
    });

    test('should have correct hash code', () {
      final type =
          Type(name: typeName, slot: slot, color: PokemonTypes.fire.color);
      final hashCode =
          typeName.hashCode ^ slot.hashCode ^ PokemonTypes.fire.color.hashCode;
      expect(type.hashCode, hashCode);
    });
  });
}
