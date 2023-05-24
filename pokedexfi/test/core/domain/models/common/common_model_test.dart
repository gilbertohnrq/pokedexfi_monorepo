import 'package:flutter_test/flutter_test.dart';
import 'package:pokedexfi/core/domain/models/common/common_model.dart';

void main() {
  group('Common', () {
    test('should correctly convert from map', () {
      final map = {
        'name': 'Test Name',
        'url': 'www.test.com',
      };
      final common = Common.fromMap(map);
      expect(common.name, 'Test Name');
      expect(common.url, 'www.test.com');
    });

    test('should correctly convert to map', () {
      const common = Common(name: 'Test Name', url: 'www.test.com');
      final map = common.toMap();
      expect(map['name'], 'Test Name');
      expect(map['url'], 'www.test.com');
    });

    test('should handle null values in fromMap', () {
      final map = {
        'name': null,
        'url': null,
      };
      final common = Common.fromMap(map);
      expect(common.name, '');
      expect(common.url, '');
    });
  });
}
