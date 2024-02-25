import 'package:favorite_books_app/core/init/network/dio_client.dart';
import 'package:favorite_books_app/feature/home/model/response/books_list_response_model.dart';

abstract class IHomeService {
  final DioClient client;

  IHomeService(this.client);

  Future<BooksListResponseModel?> getBooks(String query);
}