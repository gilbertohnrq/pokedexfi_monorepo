part of 'pokes_list_cubit.dart';

abstract class PokesListState {
  const PokesListState();
}

class Loading extends PokesListState {
  const Loading();
}

class Loaded extends PokesListState {
  const Loaded(this.pokemons);

  final List<Poke> pokemons;
}

class Error extends PokesListState {
  const Error(this.message);

  final String message;
}

class Empty extends PokesListState {
  const Empty();
}
