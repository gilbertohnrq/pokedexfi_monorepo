import 'package:pokedexfi/core/domain/models/pokemon/pokemon_model.dart';

import '../pageable/pageable_model.dart';

final class PokemonList extends Pageable<Pokemon> {
  const PokemonList({
    required super.count,
    super.next,
    super.previous,
    required super.results,
  });

  factory PokemonList.empty() => const PokemonList(
        count: 0,
        next: null,
        previous: null,
        results: [],
      );

  factory PokemonList.fromJson(Map<String, dynamic> json) {
    return PokemonList(
      count: json['count'] ?? 0,
      next: json['next'],
      previous: json['previous'],
      results: (json['results'] as List<dynamic>?)
              ?.map((data) => Pokemon.fromJson(data))
              .toList() ??
          [],
    );
  }
}
