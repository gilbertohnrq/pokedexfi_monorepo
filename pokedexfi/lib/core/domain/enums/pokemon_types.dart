import 'dart:ui';

import 'package:dexfi_ui/dexfi_ui.dart';

enum PokemonTypes {
  bug(DexColors.bug),
  dark(DexColors.dark),
  dragon(DexColors.dragon),
  electric(DexColors.electric),
  fairy(DexColors.fairy),
  fighting(DexColors.fighting),
  fire(DexColors.fire),
  flying(DexColors.flying),
  ghost(DexColors.ghost),
  normal(DexColors.normal),
  grass(DexColors.grass),
  ground(DexColors.ground),
  ice(DexColors.ice),
  psychic(DexColors.psychic),
  rock(DexColors.rock),
  steel(DexColors.steel),
  water(DexColors.water),
  poison(DexColors.poison),
  unknown(DexColors.black);

  const PokemonTypes(this.color);

  final Color color;

  @override
  String toString() => name;
}
