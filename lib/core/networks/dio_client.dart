import 'package:dio/dio.dart';

class DioClient {
  final _dio = Dio();

  DioClient._private() {
    _dio.options
      ..connectTimeout = const Duration(seconds: 5)
      ..receiveTimeout = const Duration(seconds: 3)
      ..responseType = ResponseType.json
      ..baseUrl = "https://api.escuelajs.co/api/v1";

    // _dio.interceptors.add(LogginInterceptor());
  }

  static final _singletonConstructor = DioClient._private();

  factory DioClient() {
    return _singletonConstructor;
  }

  Future<Response> get({
    required String url,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final response = await _dio.get(
        url,
        queryParameters: queryParams,
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> post({
    required String url,
    required Map<String, dynamic>? data,
  }) async {
    try {
      final response = await _dio.post(url, data: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Future<void> download(String url, String saveDirevtory) async {
  //   final response = await _dio.download(
  //     url,
  //     saveDirevtory,
  //     onReceiveProgress: (count, total) {
  //       print("${(count / total * 100).toStringAsFixed(0)}%");
  //     },
  //   );
  // }
}



// class LogginInterceptor extends Interceptor {
//   @override
//   void onResponse(Response response, ResponseInterceptorHandler handler) {
//     super.onResponse(response, handler);

//     print(response);
//   }

//   @override
//   void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
//     options.headers = {
//       "Authorization": "Bearer ,,.,...",
//       "ContentType": "multipart/form",
//     };
//     print(options.method);
//     options.connectTimeout = Duration(seconds: 5);
//     super.onRequest(options, handler);

//     print(options.connectTimeout);
//   }

//   @override
//   void onError(DioException err, ErrorInterceptorHandler handler) {
//     super.onError(err, handler);

//     print(err);
//   }
// }