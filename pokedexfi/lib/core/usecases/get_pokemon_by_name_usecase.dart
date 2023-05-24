import '../domain/models/pokemon/poke_model.dart';
import '../repositories/pokedex_repository.dart';

class GetPokemonByNameUseCase {
  final PokedexRepository _pokedexRepository;

  GetPokemonByNameUseCase(this._pokedexRepository);

  Future<Poke> call(String name) async {
    if (name.isEmpty) {
      throw ArgumentError('Pokemon name cannot be empty');
    }

    final pokemon = await _pokedexRepository.getPokemonByName(name);

    return pokemon;
  }
}
