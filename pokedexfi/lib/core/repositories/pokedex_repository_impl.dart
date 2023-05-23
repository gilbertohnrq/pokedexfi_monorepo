import 'dart:developer';

import 'package:pokedexfi/core/repositories/pokedex_repository.dart';

import '../constants/app_constants.dart';
import '../domain/models/pokemon/poke_model.dart';
import '../domain/models/pokemon/pokemon_list_model.dart';
import '../services/http/http_service.dart';

class PokedexRepositoryImpl implements PokedexRepository {
  final HttpService _httpService;

  PokedexRepositoryImpl(this._httpService);

  @override
  Future<List<String>> getPokemonNamesByOffset(int offset, int limit) async {
    final url = '$kBaseUrl/pokemon/?offset=$offset&limit=$limit';
    final response = await _httpService.get(url);
    final pokemonList =
        PokemonList.fromJson(Map<String, dynamic>.from(response.data));
    return pokemonList.results.map((pokemon) => pokemon.name).toList();
  }

  @override
  Future<Poke> getPokemonByName(String name) async {
    final url = '$kBaseUrl/pokemon/$name';
    final response = await _httpService.get(url);
    return Poke.fromMap(Map<String, dynamic>.from(response.data));
  }

  @override
  Future<List<Poke>> getPokemonsByOffset(int offset, int limit) async {
    try {
      final pokemonNames = await getPokemonNamesByOffset(offset, limit);
      final futurePokes = pokemonNames.map((name) async {
        return await getPokemonByName(name);
      }).toList();
      return Future.wait(futurePokes);
    } catch (e, s) {
      log(e.toString(), stackTrace: s, error: e);
      throw Exception(e);
    }
  }
}
