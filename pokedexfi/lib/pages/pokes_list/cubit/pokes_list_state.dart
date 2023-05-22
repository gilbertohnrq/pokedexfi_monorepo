part of 'pokes_list_cubit.dart';

abstract class PokesListState {
  const PokesListState();
}

class Initial extends PokesListState {
  const Initial();
}

class Loading extends PokesListState {
  const Loading();
}

class LoadingMore extends PokesListState {
  const LoadingMore(this.pokemons);

  final List<Poke> pokemons;
}

class Loaded extends PokesListState {
  const Loaded(this.pokemons);

  final List<Poke> pokemons;
}

class Error extends PokesListState {
  const Error(this.message);

  final String message;
}
