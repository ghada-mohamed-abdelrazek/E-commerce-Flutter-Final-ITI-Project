import 'package:dio/dio.dart';
import 'package:iti_final_project/feature/model/error_model.dart';


class ServerException implements Exception {
  final ErrorModel errorModel;

  ServerException({required this.errorModel});
}

void handelDioException(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      throw ServerException(errorModel: ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.sendTimeout:
      throw ServerException(errorModel: ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.receiveTimeout:
      throw ServerException(errorModel: ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.badCertificate:
      throw ServerException(errorModel: ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.cancel:
      throw ServerException(errorModel: ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.connectionError:
      throw ServerException(errorModel: ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.unknown:
      throw ServerException(errorModel: ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.badResponse:
      switch (e.response!.statusCode) {
        case 400:

        ///empty email or password
        ///

        case 401:

        ///unauthorized
          throw e.response!.data.toString();
        case 403:

        ///forbidden
          throw "Forbidden";

        case 404:

        ///not found-+
        ///
          throw "Not Found";

        case 405:

        ///forbidden operation
          throw ServerException(
              errorModel: ErrorModel.fromJson(e.response!.data));

        case 409:
          throw ServerException(
              errorModel: ErrorModel.fromJson(e.response!.data));
        case 422:
          throw ServerException(
              errorModel: ErrorModel.fromJson(e.response!.data));

        case 504:
          throw ServerException(
              errorModel: ErrorModel.fromJson(e.response!.data));
      }
  }
}