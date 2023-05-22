import 'package:pokedexfi/core/services/local_storage/local_storage_service.dart';

import '../domain/models/pokemon/poke_model.dart';
import '../repositories/pokedex_repository.dart';

class GetPokemonsUseCase {
  final PokedexRepository _pokedexRepository;
  final LocalStorageService _localStorageService;

  const GetPokemonsUseCase(this._pokedexRepository, this._localStorageService);

  Future<List<Poke>> call({int limit = 20, int offset = 0}) async {
    final result = await _pokedexRepository.getPokemonsByOffset(offset, limit);

    if (result.length < limit) return [];

    return result;
  }
}
