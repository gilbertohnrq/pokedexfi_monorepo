import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedexfi/core/dependencies/service_locator.dart';
import 'package:pokedexfi/core/domain/models/pokemon/poke_model.dart';
import 'package:pokedexfi/core/helpers/debouncer.dart';
import 'package:pokedexfi/core/usecases/get_pokemon_by_name_usecase.dart';
import 'package:pokedexfi/core/usecases/get_pokemons_usecase.dart';

part 'pokes_list_state.dart';

class PokesListCubit extends Cubit<PokesListState> {
  final GetPokemonsUseCase _getPokemonsUseCase = getIt<GetPokemonsUseCase>();
  final GetPokemonByNameUseCase _byNameUseCase =
      getIt<GetPokemonByNameUseCase>();

  List<Poke> _pokemons = [];
  int _offset = 0;
  final _limit = 20;
  final _lazyLoadLimit = 5;
  bool _isFetching = false;
  final debouncer = Debounce();

  PokesListCubit() : super(const Loading()) {
    getPokemons();
  }

  Future<void> getPokemons() async {
    try {
      emit(const Loading());

      _offset = 0;
      _pokemons = [];

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
    if (_isFetching) {
      return;
    }

    _isFetching = true;

    try {
      emit(LoadingMore(_pokemons));

      final additionalPokemons = await _getPokemonsUseCase.call(
          offset: _offset, limit: _lazyLoadLimit);

      final uniqueAdditionalPokemons = additionalPokemons
          .where((poke) => !_pokemons.contains(poke))
          .toList();

      _pokemons = [..._pokemons, ...uniqueAdditionalPokemons];
      _offset += _lazyLoadLimit;

      emit(Loaded(_pokemons));
    } catch (e) {
      emit(Error(e.toString()));
    } finally {
      _isFetching = false;
    }
  }

  Future<void> searchPokemonByName(String name) async {
    try {
      emit(const Loading());
      final result = await _byNameUseCase.call(name);
      emit(Loaded([result]));
    } catch (e) {
      emit(Error(e.toString()));
    }
  }
}
