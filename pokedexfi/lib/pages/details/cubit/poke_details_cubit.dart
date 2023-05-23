import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedexfi/core/dependencies/service_locator.dart';
import 'package:pokedexfi/core/usecases/get_pokemons_usecase.dart';

import '../../../core/domain/models/pokemon/poke_model.dart';

part 'poke_details_state.dart';

class PokeDetailsCubit extends Cubit<PokeDetailsState> {
  PokeDetailsCubit() : super(const Initial([]));

  final _getPokemonsUsecase = getIt.get<GetPokemonsUseCase>();

  void init(List<Poke> pokesList) {
    emit(Loaded(pokesList));
  }

  Future<void> getMorePokemonsWhenListIsOver(int currentPage) async {
    emit(Loading(state.pokemons));
    final newList =
        await _getPokemonsUsecase.call(limit: 1, offset: currentPage + 1);
    emit(Loaded([...state.pokemons, ...newList]));
  }
}
