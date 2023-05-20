import 'package:flutter_test/flutter_test.dart';
import 'package:pokedexfi/core/domain/models/pokemon/pokemon_list_model.dart';

void main() {
  group('PokemonList', () {
    test('creates PokemonList from JSON', () {
      const mockJson = {
        'count': 2,
        'next': 'https://pokeapi.co/api/v2/pokemon/?offset=2&limit=2',
        'previous': null,
        'results': [
          {'name': 'Pikachu', 'url': 'https://pokeapi.co/api/v2/pokemon/25/'},
          {'name': 'Bulbasaur', 'url': 'https://pokeapi.co/api/v2/pokemon/1/'}
        ],
      };

      final pokemonList = PokemonList.fromJson(mockJson);

      expect(pokemonList.count, 2);
      expect(pokemonList.next,
          'https://pokeapi.co/api/v2/pokemon/?offset=2&limit=2');
      expect(pokemonList.previous, null);
      expect(pokemonList.results.length, 2);
      expect(pokemonList.results[0].name, 'Pikachu');
      expect(
          pokemonList.results[0].url, 'https://pokeapi.co/api/v2/pokemon/25/');
      expect(pokemonList.results[1].name, 'Bulbasaur');
      expect(
          pokemonList.results[1].url, 'https://pokeapi.co/api/v2/pokemon/1/');
    });
  });
}
