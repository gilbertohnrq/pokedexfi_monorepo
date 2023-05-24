import 'package:flutter_test/flutter_test.dart';
import 'package:pokedexfi/core/domain/models/pokemon/official_artwork_model.dart';

void main() {
  group('OfficialArtwork', () {
    test('should correctly convert from map', () {
      final map = {
        'front_default': 'www.test.com',
      };
      final artwork = OfficialArtwork.fromMap(map);
      expect(artwork.frontDefault, 'www.test.com');
    });

    test('should correctly convert to map', () {
      const artwork = OfficialArtwork(frontDefault: 'www.test.com');
      final map = artwork.toMap();
      expect(map['front_default'], 'www.test.com');
    });

    test('should handle null values in fromMap', () {
      final map = {
        'front_default': null,
      };
      final artwork = OfficialArtwork.fromMap(map);
      expect(artwork.frontDefault, '');
    });

    test('should correctly create an empty artwork', () {
      final artwork = OfficialArtwork.empty();
      expect(artwork.frontDefault, '');
    });
  });
}
