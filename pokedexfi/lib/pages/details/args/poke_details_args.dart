import 'package:pokedexfi/core/domain/models/pokemon/poke_model.dart';

class PokeDetailsArgs {
  const PokeDetailsArgs({required this.pokemon, required this.index});

  final List<Poke> pokemon;
  final int index;
}
