import 'package:flutter_test/flutter_test.dart';
import 'package:pokedexfi/core/domain/models/pokemon/official_artwork_model.dart';
import 'package:pokedexfi/core/domain/models/pokemon/other_model.dart';

void main() {
  group('Other', () {
    final officialArtwork = OfficialArtwork(frontDefault: 'www.test.com');
    final otherMap = {
      'official-artwork': {'front_default': 'www.test.com'},
    };

    test('should correctly convert from map', () {
      final other = Other.fromMap(otherMap);
      expect(other.officialArtwork.frontDefault, officialArtwork.frontDefault);
    });

    test('should correctly convert to map', () {
      final other = Other(officialArtwork: officialArtwork);
      final map = other.toMap();
      expect(map['official-artwork']['front_default'], officialArtwork.frontDefault);
    });

    test('should correctly create an empty instance', () {
      final other = Other.empty();
      expect(other.officialArtwork.frontDefault, '');
    });

    test('should correctly compare equal instances', () {
      final other1 = Other(officialArtwork: officialArtwork);
      final other2 = Other(officialArtwork: officialArtwork);
      expect(other1, other2);
    });

    test('should have correct hash code', () {
      final other = Other(officialArtwork: officialArtwork);
      final hashCode = officialArtwork.hashCode;
      expect(other.hashCode, hashCode);
    });
  });
}
