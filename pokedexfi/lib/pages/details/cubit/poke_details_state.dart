part of 'poke_details_cubit.dart';

abstract class PokeDetailsState {
  const PokeDetailsState();
}

class Initial extends PokeDetailsState {
  const Initial();
}

class Loading extends PokeDetailsState {
  const Loading();
}

class Loaded extends PokeDetailsState {
  final List<Poke> pokemon;

  const Loaded(this.pokemon);
}

class Error extends PokeDetailsState {
  final String message;

  const Error(this.message);
}
