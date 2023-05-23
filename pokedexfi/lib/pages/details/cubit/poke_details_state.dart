part of 'poke_details_cubit.dart';

abstract class PokeDetailsState {
  const PokeDetailsState(this.pokemons);

  final List<Poke> pokemons;
}

class Initial extends PokeDetailsState {
  const Initial(List<Poke> pokemons) : super(pokemons);
}

class Loading extends PokeDetailsState {
  const Loading(List<Poke> pokemons) : super(pokemons);
}

class Loaded extends PokeDetailsState {
  const Loaded(List<Poke> pokemons) : super(pokemons);
}

class NewPokeLoaded extends PokeDetailsState {
  const NewPokeLoaded(List<Poke> pokemons) : super(pokemons);
}

class Error extends PokeDetailsState {
  final String message;

  const Error(this.message, List<Poke> pokemons) : super(pokemons);
}
