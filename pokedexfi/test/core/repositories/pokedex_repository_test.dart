import 'package:mocktail/mocktail.dart';
import 'package:pokedexfi/core/domain/models/pokemon/pokemon_models.dart';
import 'package:pokedexfi/core/repositories/pokedex_repository.dart';

import 'package:flutter/material.dart';
import 'package:pokedexfi/core/domain/models/common/common_model.dart';

class MockPokedexRepository extends Mock implements PokedexRepository {
  void setupMock() {
    when(() => getPokemonNamesByOffset(any(), any())).thenAnswer(
      (_) async => ['Bulbasaur', 'Charmander', 'Squirtle'],
    );

    when(() => getPokemonByName(any())).thenAnswer(
      (_) async => Poke(
        id: 1,
        name: 'Poke',
        height: 123,
        weight: 123,
        other: const Other(
            officialArtwork: OfficialArtwork(frontDefault: 'image')),
        types: List.generate(
          2,
          (index) => Type(
            color: Colors.white,
            name: 'Type$index',
            slot: index,
          ),
        ),
        stats: List.generate(
          2,
          (index) => Stat(
            baseStat: index,
            effort: index,
            stat: Common(name: 'Stat$index', url: 'url'),
          ),
        ),
        abilities: List.generate(
          2,
          (index) => Ability(
            ability: Common(name: 'Ability$index', url: 'url'),
            slot: index,
          ),
        ),
      ),
    );
  }
}
