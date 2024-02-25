
import 'package:dio/dio.dart';

import 'package:favorite_books_app/core/init/app_state/app_state.dart';
import 'package:favorite_books_app/core/utility/api_response.dart';
import 'package:favorite_books_app/feature/home/model/response/books_list_response_model.dart';
import 'package:favorite_books_app/feature/home/service/IHomeService.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HomeService extends IHomeService {
  HomeService(super.client);
  final apiKey = dotenv.env['GOOGLE_BOOKS_API_KEY'];
  @override
  Future<BooksListResponseModel?> getBooks(String query) async{
    try {
        final response = await client.get('volumes?q=intitle:$query&key=$apiKey');
        final result = ResponseParser<BooksListResponseModel>(response: response)
            .fromMap(model: BooksListResponseModel());
            if (result != null) {
              AppStateManager.instance.bookList = result;
                return result;
            }
        
        return result;
   } on DioError catch (e) {
      throw DioException.connectionError( requestOptions: e.requestOptions, reason: e.message!);
    }
  }
  
}