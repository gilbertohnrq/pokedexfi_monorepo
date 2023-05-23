import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/domain/models/pokemon/poke_model.dart';

part 'poke_details_state.dart';

class PokeDetailsCubit extends Cubit<PokeDetailsState> {
  PokeDetailsCubit() : super(const Initial());

  void init(List<Poke> pokesList) {
    emit(Loaded(pokesList));
  }
}
