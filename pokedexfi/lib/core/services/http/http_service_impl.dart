import 'dart:convert';

import 'package:dio/dio.dart';

import 'http_service.dart';

class HttpServiceImpl implements HttpService {
  const HttpServiceImpl(this.dio);

  final Dio dio;

  @override
  Future get(String? url,
      {Map<String, dynamic>? queryParameters, Options? options}) async {
    if (url == null) return;
    final response =
        await dio.get(url, queryParameters: queryParameters, options: options);

    return response;
  }

  @override
  String errorReason(DioError e, {List requestFields = const []}) {
    final value = {
      'request_path': e.requestOptions.path,
      'response_data':
          e.response != null ? e.response!.data : 'response is null'
    };

    if (['POST', 'PUT'].contains(e.requestOptions.method) &&
        requestFields.isNotEmpty &&
        e.requestOptions.data is String) {
      final data = jsonDecode(e.requestOptions.data as String);

      for (final element in requestFields) {
        value[element as String] = data[element] ?? 'UNDEFINED';
      }
    }

    return jsonEncode(value);
  }
}
