import 'package:dio/dio.dart';

abstract interface class HttpService {
  Future get(String? url,
      {Map<String, dynamic>? queryParameters, Options? options});
  String errorReason(DioError e, {List requestFields = const []});
}
