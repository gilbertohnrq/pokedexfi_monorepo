import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedexfi/core/services/local_storage/local_storage_service_impl.dart';

import 'local_storage_service_test.dart';

void main() {
  late LocalStorageServiceImpl service;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    service = LocalStorageServiceImpl(sharedPreferences: mockSharedPreferences);
  });

  group('LocalStorageService', () {
    test('writes a value', () async {
      const key = 'key';
      const value = 'value';

      when(() => mockSharedPreferences.setString(key, value))
          .thenAnswer((_) async => true);

      await service.write(key, value);

      verify(() => mockSharedPreferences.setString(key, value)).called(1);
    });

    test('reads a value', () async {
      const key = 'key';
      const value = 'value';

      when(() => mockSharedPreferences.getString(key)).thenReturn(value);

      final result = await service.read(key);

      expect(result, equals(value));
      verify(() => mockSharedPreferences.getString(key)).called(1);
    });

    test('deletes a value', () async {
      const key = 'key';
      const value = 'value';

      when(() => mockSharedPreferences.getString(key)).thenReturn(value);
      when(() => mockSharedPreferences.remove(key))
          .thenAnswer((_) async => true);

      await service.delete(key);

      verify(() => mockSharedPreferences.remove(key)).called(1);
    });
  });
}
