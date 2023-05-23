import 'dart:convert';

import 'package:pokedexfi/core/services/local_storage/local_storage_service.dart';

import '../domain/models/pokemon/poke_model.dart';
import '../repositories/pokedex_repository.dart';

class GetPokemonsUseCase {
  final PokedexRepository _pokedexRepository;
  final LocalStorageService _localStorageService;

  const GetPokemonsUseCase(this._pokedexRepository, this._localStorageService);

  Future<List<Poke>> call({int limit = 20, int offset = 0}) async {
    final cacheKey = 'pokemon_offset_${offset}_limit_$limit';
    final cachedData = await _localStorageService.read(cacheKey);

    if (cachedData != null) {
      final pokemons = (jsonDecode(cachedData) as List)
          .map((pokemon) => Poke.fromMap(Map<String, dynamic>.from(pokemon)))
          .toList();
      return pokemons;
    } else {
      final pokemonNames =
          await _pokedexRepository.getPokemonNamesByOffset(offset, limit);

      final futurePokes = pokemonNames.map((name) async {
        return await _pokedexRepository.getPokemonByName(name);
      }).toList();

      final result = await Future.wait(futurePokes);

      if (result.length < limit) return [];

      await _localStorageService.write(
          cacheKey, jsonEncode(result.map((poke) => poke.toMap()).toList()));

      return result;
    }
  }
}
