import 'dart:developer';

import 'package:dio/dio.dart';

class DioHttpRequestRetrier extends Interceptor {
  final Dio dio;
  final int retryLimit;

  const DioHttpRequestRetrier({
    required this.dio,
    this.retryLimit = 3,
  });

  Future<Response> requestRetry(RequestOptions requestOptions) async {
    for (var retry = 0; retry < retryLimit; retry++) {
      try {
        log('Request error: retrying ($retry)');
        return await dio.request(
          requestOptions.path,
          cancelToken: requestOptions.cancelToken,
          data: requestOptions.data,
          onReceiveProgress: requestOptions.onReceiveProgress,
          onSendProgress: requestOptions.onSendProgress,
          queryParameters: requestOptions.queryParameters,
          options: Options(
            contentType: requestOptions.contentType,
            headers: requestOptions.headers,
            sendTimeout: requestOptions.sendTimeout,
            receiveTimeout: requestOptions.receiveTimeout,
            extra: requestOptions.extra,
            followRedirects: requestOptions.followRedirects,
            listFormat: requestOptions.listFormat,
            maxRedirects: requestOptions.maxRedirects,
            method: requestOptions.method,
            receiveDataWhenStatusError:
                requestOptions.receiveDataWhenStatusError,
            requestEncoder: requestOptions.requestEncoder,
            responseDecoder: requestOptions.responseDecoder,
            responseType: requestOptions.responseType,
            validateStatus: requestOptions.validateStatus,
          ),
        );
      } catch (e) {
        if (retry == retryLimit - 1) {
          rethrow;
        }
        await Future.delayed(Duration(seconds: retry * 2));
      }
    }
    throw Exception('Request failed after $retryLimit attempts.');
  }
}
