import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedexfi/core/domain/models/pokemon/pokemon_list_model.dart';
import 'package:pokedexfi/core/repositories/pokedex_repository_impl.dart';

import '../services/http/http_service_test.dart';
import '../services/local_storage/local_storage_service_test.dart';

void main() {
  late PokedexRepositoryImpl repository;
  late MockHttpService mockHttpService;
  late MockLocalStorageService mockLocalStorageService;

  setUp(() {
    mockHttpService = MockHttpService();
    mockLocalStorageService = MockLocalStorageService();
    repository =
        PokedexRepositoryImpl(mockHttpService, mockLocalStorageService);
  });

  group('PokedexRepositoryImpl', () {
    test('getAllPokemons returns PokemonList', () async {
      const url = 'https://pokeapi.co/api/v2/pokemon/?limit=151';
      final mockResponse = {
        'count': 151,
        'next': null,
        'previous': null,
        'results': [
          {'name': 'pokemon1'},
          {'name': 'pokemon2'},
        ],
      };
      when(() => mockHttpService.get(url,
              options: any(named: 'options'),
              queryParameters: any(named: 'queryParameters')))
          .thenAnswer((_) async => mockResponse as dynamic);

      final result = await repository.getAllPokemons();

      expect(result, isA<PokemonList>());
    });

    test('getPokemonsByNames throws UnimplementedError', () {
      expect(repository.getPokemonsByNames, throwsUnimplementedError);
    });
  });
}
