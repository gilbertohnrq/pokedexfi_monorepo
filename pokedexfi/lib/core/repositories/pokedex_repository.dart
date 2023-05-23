import '../domain/models/pokemon/poke_model.dart';

abstract interface class PokedexRepository {
  Future<List<String>> getPokemonNamesByOffset(int offset, int limit);
  Future<Poke> getPokemonByName(String name);
  Future<List<Poke>> getPokemonsByOffset(int offset, int limit);
}
