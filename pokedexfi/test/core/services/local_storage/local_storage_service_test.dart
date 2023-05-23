import 'package:mocktail/mocktail.dart';
import 'package:pokedexfi/core/services/local_storage/local_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

class MockLocalStorageService extends Mock implements LocalStorageService {
  void setupMock() {
    when(() => read(any())).thenAnswer(
      (_) async => '{}',
    );
    when(() => write(any(), any())).thenAnswer(
      (_) async => Future.value(),
    );
  }
}
