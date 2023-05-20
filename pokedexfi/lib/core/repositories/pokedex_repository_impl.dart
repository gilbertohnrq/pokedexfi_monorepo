import 'dart:developer';

import 'package:pokedexfi/core/domain/models/pokemon/poke_model.dart';
import 'package:pokedexfi/core/repositories/pokedex_repository.dart';

import '../constants/app_constants.dart';
import '../domain/models/pokemon/pokemon_list_model.dart';
import '../services/http/http_service.dart';

class PokedexRepositoryImpl implements PokedexRepository {
  final HttpService _httpService;

  PokedexRepositoryImpl(this._httpService);

  @override
  Future<List<String>> getAllPokemons() async {
    try {
      const url = '$kBaseUrl/pokemon/?limit=$limit';
      final response = await _httpService.get(url);
      final pokemonList =
          PokemonList.fromJson(Map<String, dynamic>.from(response.data));
      return pokemonList.results.map((pokemon) => pokemon.name).toList();
    } catch (e, s) {
      log(e.toString(), stackTrace: s, error: e);
      throw Exception(e);
    }
  }

  @override
  Future<List<Poke>> getPokemonsByNames() async {
    try {
      final pokemonNames = await getAllPokemons();
      final futurePokes = pokemonNames.map((name) async {
        final url = '$kBaseUrl/pokemon/$name';
        final response = await _httpService.get(url);
        return Poke.fromMap(Map<String, dynamic>.from(response.data));
      }).toList();

      return Future.wait(futurePokes);
    } catch (e, s) {
      log(e.toString(), stackTrace: s, error: e);
      throw Exception(e);
    }
  }
}
