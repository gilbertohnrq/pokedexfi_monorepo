import 'dart:convert';

import 'package:pokedexfi/core/services/local_storage/local_storage_service.dart';

import '../constants/app_constants.dart';
import '../domain/models/pokemon/poke_model.dart';
import '../repositories/pokedex_repository.dart';

class GetPokemonsUseCase {
  final PokedexRepository _pokedexRepository;
  final LocalStorageService _localStorageService;

  const GetPokemonsUseCase(this._pokedexRepository, this._localStorageService);

  Future<List<Poke>> call({int limit = 20, int offset = 0}) async {
    final cachedData = await _localStorageService.read(kCacheKey);

    List<Poke> cachedPokes = [];

    if (cachedData != null) {
      cachedPokes = (jsonDecode(cachedData) as List)
          .map((pokemon) => Poke.fromMap(Map<String, dynamic>.from(pokemon)))
          .toList();

      if (cachedPokes.length > offset + limit) {
        return cachedPokes.sublist(offset, offset + limit);
      }
    }

    final pokemonNames =
        await _pokedexRepository.getPokemonNamesByOffset(offset, limit);

    final futurePokes = pokemonNames.map((name) async {
      return await _pokedexRepository.getPokemonByName(name);
    }).toList();

    final result = await Future.wait(futurePokes);

    final combinedResult = [
      ...cachedPokes,
      ...result.where((e) => !cachedPokes.contains(e))
    ];

    final uniqueCombinedResult = combinedResult.toSet().toList();

    await _localStorageService.write(kCacheKey,
        jsonEncode(uniqueCombinedResult.map((poke) => poke.toMap()).toList()));

    return uniqueCombinedResult.sublist(offset, offset + limit);
  }
}
