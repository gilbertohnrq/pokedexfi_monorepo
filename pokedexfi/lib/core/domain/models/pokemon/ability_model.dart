import 'package:pokedexfi/core/domain/models/common/common_model.dart';

class Ability {
  final Common ability;
  final int slot;

  const Ability({
    required this.ability,
    required this.slot,
  });

  factory Ability.fromMap(Map<String, dynamic> map) {
    return Ability(
      ability: Common.fromMap(map['ability'] as Map<String, dynamic>),
      slot: map['slot'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ability': ability.toMap(),
      'slot': slot,
    };
  }
}
