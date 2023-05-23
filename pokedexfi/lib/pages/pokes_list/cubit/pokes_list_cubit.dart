import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedexfi/core/dependencies/service_locator.dart';
import 'package:pokedexfi/core/domain/models/pokemon/poke_model.dart';
import 'package:pokedexfi/core/usecases/get_pokemons_usecase.dart';

part 'pokes_list_state.dart';

class PokesListCubit extends Cubit<PokesListState> {
  final GetPokemonsUseCase _getPokemonsUseCase = getIt<GetPokemonsUseCase>();
  List<Poke> _pokemons = [];
  int _offset = 0;
  final _limit = 20;
  final _lazyLoadLimit = 5;

  PokesListCubit() : super(const Loading()) {
    getPokemons();
  }

  Future<void> getPokemons() async {
    try {
      emit(const Loading());

      final result =
          await _getPokemonsUseCase.call(offset: _offset, limit: _limit);

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

      final additionalPokemons = await _getPokemonsUseCase.call(
          offset: _offset, limit: _lazyLoadLimit);

      _pokemons = [..._pokemons, ...additionalPokemons];
      _offset += _lazyLoadLimit;

      emit(Loaded(_pokemons));
    } catch (e) {
      emit(Error(e.toString()));
    }
  }
}
