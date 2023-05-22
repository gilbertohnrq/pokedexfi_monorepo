import '../domain/models/pokemon/poke_model.dart';

abstract interface class PokedexRepository {
  Future<List<String>> getAllPokemons();
  Future<List<Poke>> getPokemonsByNames();
  Future<List<Poke>> getPokemonsByOffset(int offset, int limit);
}
