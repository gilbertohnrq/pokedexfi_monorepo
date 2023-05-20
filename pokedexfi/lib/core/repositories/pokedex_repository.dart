import 'package:pokedexfi/core/domain/models/pokemon/poke_model.dart';

abstract interface class PokedexRepository {
  Future<List<String>> getAllPokemons();
  Future<List<Poke>> getPokemonsByNames();
}
