import 'package:pokedexfi/core/domain/models/pokemon/poke_model.dart';

class PokeDetailsArgs {
  const PokeDetailsArgs({required this.listPokes, required this.index});

  final List<Poke> listPokes;
  final int index;
}
