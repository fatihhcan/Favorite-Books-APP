import 'package:favorite_books_app/feature/home/model/response/books_list_response_model.dart';

class AppStateManager {
  static AppStateManager? _instance;
  static AppStateManager get instance {
    return _instance ??= AppStateManager.init();
  }
  
  String accessApiKey = '';

    BooksListResponseModel bookList = BooksListResponseModel();
  AppStateManager.init();
}
