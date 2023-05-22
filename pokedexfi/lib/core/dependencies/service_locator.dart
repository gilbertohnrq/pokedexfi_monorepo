import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedexfi/core/repositories/pokedex_repository.dart';
import 'package:pokedexfi/core/services/http/http_service.dart';
import 'package:pokedexfi/core/services/http/http_service_impl.dart';
import 'package:pokedexfi/core/services/local_storage/local_storage_service.dart';
import 'package:pokedexfi/core/services/local_storage/local_storage_service_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../repositories/pokedex_repository_impl.dart';
import '../services/http/http_interceptors.dart';

GetIt get getIt => GetIt.instance;

late final Dio dio;

class Locator {
  Future<void> initDependencies() async {
    const timeout = Duration(seconds: 30);

    final BaseOptions options = BaseOptions(
      connectTimeout: timeout,
      sendTimeout: timeout,
      receiveTimeout: timeout,
    );

    dio = Dio(options);
    dio.interceptors.add(DioHttpRequestRetrier(dio: dio));
    createDependencies();
  }

  Future<void> createDependencies() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    //Services
    getIt.registerSingleton<HttpService>(HttpServiceImpl(dio));
    getIt.registerSingleton<LocalStorageService>(
        LocalStorageServiceImpl(sharedPreferences: sharedPreferences));

    //Repositories
    getIt.registerFactory<PokedexRepository>(
        () => PokedexRepositoryImpl(getIt()));
  }
}
