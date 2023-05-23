import '../domain/models/pokemon/poke_model.dart';
import '../repositories/pokedex_repository.dart';

class GetPokemonsUseCase {
  final PokedexRepository _pokedexRepository;

  const GetPokemonsUseCase(this._pokedexRepository);

  Future<List<Poke>> call({int limit = 20, int offset = 0}) async {
    if (offset < 0 || limit < 0) {
      return [];
    }

    List<Poke> newPokes =
        await _pokedexRepository.getPokemonsByOffset(offset, limit);

    return newPokes;
  }
}
