import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:pokedexfi/core/services/local_storage/local_storage_service.dart';

class LocalStorageServiceImpl implements LocalStorageService {
  final SharedPreferences sharedPreferences;

  LocalStorageServiceImpl({required this.sharedPreferences});

  @override
  Future<String?> read(String key) async {
    try {
      return sharedPreferences.getString(key);
    } catch (e, s) {
      log('LocalStorage read error', error: e, stackTrace: s);
      return null;
    }
  }

  @override
  Future<void> write(String key, String value) async {
    try {
      await sharedPreferences.setString(key, value);
    } catch (e, s) {
      log('LocalStorage write error', error: e, stackTrace: s);
    }
  }

  @override
  Future<void> delete(String key) async {
    try {
      await sharedPreferences.remove(key);
    } catch (e, s) {
      log('LocalStorage delete error', error: e, stackTrace: s);
    }
  }
}
