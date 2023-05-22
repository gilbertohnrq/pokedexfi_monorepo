import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedexfi/core/dependencies/service_locator.dart';
import 'package:pokedexfi/core/domain/models/pokemon/poke_model.dart';
import 'package:pokedexfi/core/repositories/pokedex_repository.dart';

part 'pokes_list_state.dart';

class PokesListCubit extends Cubit<PokesListState> {
  PokesListCubit() : super(const Loading()) {
    getPokemons();
  }

  final _repository = getIt<PokedexRepository>();
  List<Poke> _pokemons = [];
  int _offset = 0; // we will use this to keep track of our current page
  final _limit = 20; // limit of pokemons per request, adjust as needed

  Future<void> getPokemons() async {
    try {
      emit(const Loading());

      final result = await _repository.getPokemonsByOffset(_offset, _limit);

      _pokemons = result;
      _offset += _limit;

      emit(Loaded(result));
    } catch (e) {
      emit(Error(e.toString()));
    }
  }

  Future<void> fetchMorePokemons() async {
    try {
      emit(LoadingMore(_pokemons));

      final additionalPokemons =
          await _repository.getPokemonsByOffset(_offset, _limit);

      _pokemons = [..._pokemons, ...additionalPokemons];
      _offset += _limit;

      emit(Loaded(_pokemons));
    } catch (e) {
      emit(Error(e.toString()));
    }
  }
}
