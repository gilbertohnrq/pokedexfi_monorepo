import 'package:pokedexfi/core/domain/models/common/common_model.dart';

class Stat {
  final int? baseStat;
  final int? effort;
  final Common? stat;

  const Stat({
    required this.baseStat,
    this.effort,
    this.stat,
  });

  factory Stat.fromMap(Map<String, dynamic> map) {
    return Stat(
      baseStat: map['baseStat'] as int?,
      effort: map['effort'] as int?,
      stat: Common.fromMap(map['stat'] as Map<String, dynamic>? ?? {}),
    );
  }
}
