import 'package:dio/dio.dart';
import 'package:favorite_books_app/core/constants/app/app_constants.dart';
import 'package:favorite_books_app/core/init/network/dio_client.dart';

class DioManager {
  static DioManager? _instance;
  static DioManager get instance {
    return _instance ??= DioManager.init();
  }

  DioManager.init();

  DioClient GoogleBooksClient = DioClient(
      baseUrl: AppConstants.BASE_URL,
      interceptorsWrapper: InterceptorsWrapper(onRequest: (options, handler) async {
        options.contentType = Headers.formUrlEncodedContentType;
        return handler.next(options);
      }, onResponse: (response, handler) {
        return handler.next(response);
      }, onError: ( e, handler) {
        throw DioException.badResponse(statusCode: e.response!.statusCode ?? 0, requestOptions: e.requestOptions, response: e.response!);
      })
      );
}
