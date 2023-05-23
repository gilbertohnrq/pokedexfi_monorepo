import 'package:pokedexfi/core/domain/models/pokemon/official_artwork_model.dart';

class Other {
  final OfficialArtwork officialArtwork;

  const Other({
    required this.officialArtwork,
  });

  factory Other.empty() {
    return Other(
      officialArtwork: OfficialArtwork.empty(),
    );
  }

  factory Other.fromMap(Map<String, dynamic> map) {
    return Other(
      officialArtwork: OfficialArtwork.fromMap(
          map['official-artwork'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'official-artwork': officialArtwork.toMap(),
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Other && other.officialArtwork == officialArtwork;
  }

  @override
  int get hashCode => officialArtwork.hashCode;
}
