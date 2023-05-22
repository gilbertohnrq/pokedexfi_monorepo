import 'dart:convert';
import 'dart:developer';

import 'package:pokedexfi/core/repositories/pokedex_repository.dart';
import 'package:pokedexfi/core/services/local_storage/local_storage_service.dart';

import '../constants/app_constants.dart';
import '../domain/models/pokemon/poke_model.dart';
import '../domain/models/pokemon/pokemon_list_model.dart';
import '../services/http/http_service.dart';

class PokedexRepositoryImpl implements PokedexRepository {
  final HttpService _httpService;
  final LocalStorageService _localStorageService;

  PokedexRepositoryImpl(this._httpService, this._localStorageService);

  @override
  Future<List<String>> getAllPokemons({int limit = 20, int offset = 0}) async {
    try {
      final cacheKey = 'all_pokemons_${limit}_$offset';
      final cachedData = await _localStorageService.read(cacheKey);

      if (cachedData != null) {
        final pokemonList = PokemonList.fromJson(
            Map<String, dynamic>.from(jsonDecode(cachedData)));
        return pokemonList.results.map((pokemon) => pokemon.name).toList();
      }

      final url = '$kBaseUrl/pokemon/?limit=$limit&offset=$offset';
      final response = await _httpService.get(url);
      final pokemonList =
          PokemonList.fromJson(Map<String, dynamic>.from(response.data));

      await _localStorageService.write(cacheKey, jsonEncode(response.data));

      return pokemonList.results.map((pokemon) => pokemon.name).toList();
    } catch (e, s) {
      log(e.toString(), stackTrace: s, error: e);
      throw Exception(e);
    }
  }

  @override
  Future<List<Poke>> getPokemonsByNames(
      {int limit = 20, int offset = 0}) async {
    try {
      final pokemonNames = await getAllPokemons(limit: limit, offset: offset);
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

  @override
  Future<List<Poke>> getPokemonsByOffset(int offset, int limit) async {
    try {
      final url = '$kBaseUrl/pokemon/?offset=$offset&limit=$limit';
      final response = await _httpService.get(url);
      final pokemonList =
          PokemonList.fromJson(Map<String, dynamic>.from(response.data));
      final pokemonNames =
          pokemonList.results.map((pokemon) => pokemon.name).toList();

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
