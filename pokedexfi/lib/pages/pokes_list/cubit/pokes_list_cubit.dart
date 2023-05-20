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

  Future<void> getPokemons() async {
    try {
      emit(const Loading());

      final result = await _repository.getPokemonsByNames();

      emit(Loaded(result));
    } catch (e) {
      emit(Error(e.toString()));
    }
  }
}
