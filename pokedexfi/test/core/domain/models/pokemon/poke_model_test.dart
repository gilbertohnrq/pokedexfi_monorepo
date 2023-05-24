import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedexfi/core/domain/models/common/common_model.dart';
import 'package:pokedexfi/core/domain/models/pokemon/ability_model.dart';
import 'package:pokedexfi/core/domain/models/pokemon/official_artwork_model.dart';
import 'package:pokedexfi/core/domain/models/pokemon/other_model.dart';
import 'package:pokedexfi/core/domain/models/pokemon/poke_model.dart';
import 'package:pokedexfi/core/domain/models/pokemon/stat_model.dart';
import 'package:pokedexfi/core/domain/models/pokemon/type_model.dart';

void main() {
  group('Poke', () {
    const ability =
        Ability(ability: Common(name: 'Ability', url: 'Ability URL'), slot: 1);
    const stat = Stat(
        baseStat: 100, effort: 1, stat: Common(name: 'Stat', url: 'Stat URL'));
    const type = Type(slot: 1, color: Colors.white, name: 'Type');
    const officialArtwork = OfficialArtwork(frontDefault: 'Artwork URL');
    const other = Other(officialArtwork: officialArtwork);
    final pokeMap = {
      'abilities': [
        {
          'ability': {'name': 'Ability', 'url': 'Ability URL'},
          'slot': 1
        }
      ],
      'height': 10,
      'id': 1,
      'name': 'Poke',
      'stats': [
        {
          'base_stat': 100,
          'effort': 1,
          'stat': {'name': 'Stat', 'url': 'Stat URL'}
        }
      ],
      'types': [
        {
          'slot': 1,
          'type': {'name': 'Type', 'url': 'Type URL'}
        }
      ],
      'weight': 10,
      'sprites': {
        'other': {
          'official-artwork': {'front_default': 'Artwork URL'}
        }
      }
    };

    test('should correctly convert from map', () {
      final poke = Poke.fromMap(pokeMap);
      expect(poke.abilities.length, 1);
      expect(poke.abilities[0].ability.name, ability.ability.name);
      expect(poke.abilities[0].ability.url, ability.ability.url);
      expect(poke.abilities[0].slot, ability.slot);
      expect(poke.height, 10);
      expect(poke.id, 1);
      expect(poke.name, 'Poke');
      expect(poke.stats.length, 1);
      expect(poke.stats[0].baseStat, stat.baseStat);
      expect(poke.stats[0].effort, stat.effort);
      expect(poke.stats[0].stat?.name, stat.stat?.name);
      expect(poke.stats[0].stat?.url, stat.stat?.url);
      expect(poke.types.length, 1);
      expect(poke.types[0].slot, type.slot);
      expect(poke.types[0].name, type.name);
      expect(poke.weight, 10);
      expect(poke.other.officialArtwork.frontDefault,
          officialArtwork.frontDefault);
    });

    test('should correctly convert to map', () {
      const poke = Poke(
        abilities: [ability],
        height: 10,
        id: 1,
        name: 'Poke',
        stats: [stat],
        types: [type],
        weight: 10,
        other: other,
      );
      final map = poke.toMap();
      expect(map['abilities'][0]['ability']['name'], ability.ability.name);
      expect(map['abilities'][0]['ability']['url'], ability.ability.url);
      expect(map['abilities'][0]['slot'], ability.slot);
      expect(map['height'], 10);
      expect(map['id'], 1);
      expect(map['name'], 'Poke');
      expect(map['stats'][0]['base_stat'], stat.baseStat);
      expect(map['stats'][0]['effort'], stat.effort);
      expect(map['stats'][0]['stat']['name'], stat.stat?.name);
      expect(map['stats'][0]['stat']['url'], stat.stat?.url);
      expect(map['types'][0]['slot'], type.slot);
      expect(map['types'][0]['type']['name'], type.name);
      expect(map['weight'], 10);
      expect(map['sprites']['other']['official-artwork']['front_default'],
          officialArtwork.frontDefault);
    });

    test('should return the formatted ID', () {
      const poke1 = Poke(
          abilities: [],
          height: 0,
          id: 1,
          name: '',
          stats: [],
          types: [],
          weight: 0,
          other: other);
      const poke2 = Poke(
          abilities: [],
          height: 0,
          id: 10,
          name: '',
          stats: [],
          types: [],
          weight: 0,
          other: other);
      const poke3 = Poke(
          abilities: [],
          height: 0,
          id: 123,
          name: '',
          stats: [],
          types: [],
          weight: 0,
          other: other);

      expect(poke1.formattedId, '#001');
      expect(poke2.formattedId, '#010');
      expect(poke3.formattedId, '#123');
    });

    test('should return the image URL', () {
      const poke = Poke(
          abilities: [],
          height: 0,
          id: 1,
          name: '',
          stats: [],
          types: [],
          weight: 0,
          other: other);
      expect(poke.image, 'Artwork URL');
    });

    test('should return the formatted name', () {
      const poke = Poke(
          abilities: [],
          height: 0,
          id: 1,
          name: 'poke',
          stats: [],
          types: [],
          weight: 0,
          other: other);
      expect(poke.formattedName, 'Poke');
    });

    test('should return the formatted height', () {
      const poke = Poke(
          abilities: [],
          height: 15,
          id: 1,
          name: '',
          stats: [],
          types: [],
          weight: 0,
          other: other);
      expect(poke.formattedHeight, '1.5 m');
    });

    test('should return the formatted weight', () {
      const poke = Poke(
          abilities: [],
          height: 0,
          id: 1,
          name: '',
          stats: [],
          types: [],
          weight: 55,
          other: other);
      expect(poke.formattedWeight, '5.5 kg');
    });

    test('should correctly compare equal instances', () {
      const poke1 = Poke(
          abilities: [],
          height: 0,
          id: 1,
          name: '',
          stats: [],
          types: [],
          weight: 0,
          other: other);
      const poke2 = Poke(
          abilities: [],
          height: 0,
          id: 1,
          name: '',
          stats: [],
          types: [],
          weight: 0,
          other: other);
      expect(poke1, poke2);
    });

    test('should have correct hash code', () {
      const poke = Poke(
        abilities: [],
        height: 0,
        id: 1,
        name: '',
        stats: [],
        types: [],
        weight: 0,
        other: other,
      );
      final hashCode = poke.id.hashCode ^
          poke.name.hashCode ^
          poke.height.hashCode ^
          poke.weight.hashCode ^
          poke.other.hashCode ^
          poke.types.hashCode ^
          poke.stats.hashCode ^
          poke.abilities.hashCode;
      expect(poke.hashCode, hashCode);
    });
  });
}
