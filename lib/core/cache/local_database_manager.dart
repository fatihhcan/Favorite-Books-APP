import 'package:favorite_books_app/core/cache/local_database_service.dart';
import 'package:favorite_books_app/core/constants/enums/local_database_constants.dart';
import 'package:favorite_books_app/feature/home/model/response/books_volume_info_response_model.dart';

class LocalDatabaseManager {
  static LocalDatabaseManager? _instance;
  static LocalDatabaseManager get instance {
    return _instance ??= LocalDatabaseManager.init();
  }

  LocalDatabaseManager.init();

  late LocalDatabaseService<VolumeInfo>? bookManager =
      LocalDatabaseService(storeName: LocalDatabaseConstants.books.name);
}
