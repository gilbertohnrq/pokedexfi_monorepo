import 'package:flutter_test/flutter_test.dart';
import 'package:pokedexfi/core/domain/models/pokemon/pokemon_model.dart';

void main() {
  group('Pokemon', () {
    test('creates Pokemon from JSON', () {
      const mockJson = {'name': 'Pikachu', 'url': 'https://pokeapi.co/api/v2/pokemon/25/'};

      final pokemon = Pokemon.fromJson(mockJson);

      expect(pokemon.name, 'Pikachu');
      expect(pokemon.url, 'https://pokeapi.co/api/v2/pokemon/25/');
    });
  });
}
