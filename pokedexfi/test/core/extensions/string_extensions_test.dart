import 'package:flutter_test/flutter_test.dart';
import 'package:pokedexfi/core/extensions/string_extensions.dart';

void main() {
  group('StringExtension', () {
    test('should capitalize the first letter of a string', () {
      const lowercaseString = 'hello';
      final capitalizedString = lowercaseString.capitalize();
      expect(capitalizedString, 'Hello');
    });

    test('should convert a string to snake case', () {
      const camelCaseString = 'helloWorld';
      final snakeCaseString = camelCaseString.toSnakeCase();
      expect(snakeCaseString, 'hello_world');
    });
  });
}
