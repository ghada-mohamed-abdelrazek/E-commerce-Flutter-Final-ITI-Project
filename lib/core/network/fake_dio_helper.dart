
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'end_points.dart';

class DioHelperFake {

  static Dio? dio;

  static initDio() {
    dio ??= Dio(
        BaseOptions(
          receiveDataWhenStatusError: true,
          baseUrl: AppEndPoints.baseUrlFake,
        )
    );
    dio!.interceptors.add(PrettyDioLogger());
  }

  static Future<Response> getRequest({required String endPoint,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      Response response = await dio!.get(endPoint,queryParameters: queryParameters);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  static Future<Response> postRequest({required String endPoint, required Map<String, dynamic>data}) async {
    try {
      Response response = await dio!.post(endPoint, data: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
