# Favorite Books App

**Project Summary:** An application where you use the Google Books API to search for books, explore them, and add favorites.

- [API Link](https://developers.google.com/books)

## Video



https://github.com/fatihhcan/Favorite-Books-APP/assets/45641833/1fdc12fb-7a41-4626-8529-f6fe728217ca



## Subject

- **BLoC** was used for State Management.

- **Get It** was used for dependencies injected.

- **Dio** was used for API requests.

- **Screen Util** adapting screen and font size.

- **Sembast** package was used for the local database.

## Flutter Packages Available in the Project

**flutter_screenutil:** A flutter plugin for adapting screen and font size.Guaranteed to look good on different models.

**bloc:** A predictable state management library that helps implement the BLoC (Business Logic Component) design pattern.

**flutter_bloc:** Flutter Widgets that make it easy to implement the BLoC (Business Logic Component) design pattern. Built to be used with the bloc state management package.

**build_runner:** A build system for Dart code generation and modular compilation.

**sembast:** NoSQL persistent embedded file system document-based database for Dart VM and Flutter with encryption support.

**json_annotation:** Classes and helper functions that support JSON code generation via the `json_serializable` package.

**json_serializable:** Automatically generate code for converting to and from JSON by annotating Dart classes.

**get_it:** Simple direct Service Locator that allows to decouple the interface from a concrete implementation and to access the concrete implementation from everywhere in your App

**flutter_dotenv:** Easily configure any flutter application with global variables using a `.env` file.

**equatable:** Easy and Fast internationalizing and localization your Flutter Apps, this package simplify the internationalizing process.

**google_fonts:** A package to include fonts from fonts.google.com in your Flutter app.
## Base

**Base Cubit:**
```dart
 mixin BaseCubit {
  BuildContext? context;
  DioManager dioManager = DioManager.instance;
  NavigationService navigation = NavigationService.instance;
  AppStateManager appStateManager = AppStateManager.instance;
  LocalDatabaseManager localDatabaseManager = LocalDatabaseManager.instance;
  void setContext(BuildContext context);
  void init();
}
```

**Base Model:**
```dart
  abstract class BaseModel<T> {
  int? localId;
  bool? isFavorite;

  BaseModel({
    this.localId,
    this.isFavorite = false,
  });

  Map<String, dynamic> toJson();
  T fromJson(Map<String, dynamic> json);
}
```

**Base View:**
```dart
class BaseView<T extends Cubit> extends StatefulWidget {
  final T cubit;
  final Function(T model) onCubitReady;
  final Function(T value) onPageBuilder;
  final Function(T model)? onDispose;
  final bool isSingleton;
  const BaseView({
    Key? key,
    required this.cubit,
    required this.onCubitReady,
    required this.onPageBuilder,
    this.onDispose,
    this.isSingleton = false,
  }) : super(key: key);

  @override
  _BaseViewState<T> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends Cubit> extends State<BaseView<T>> {
  late T cubit;
  @override
  void initState() {
    cubit = widget.cubit;
    widget.onCubitReady(cubit);
    super.initState();
  }

  @override
  void dispose() {
    if (widget.onDispose != null) widget.onDispose!(cubit);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.isSingleton
        ? BlocProvider.value(
            value: widget.cubit,
            child: widget.onPageBuilder(cubit) as Widget,
          )
        : BlocProvider(
            create: (context) => widget.cubit,
            child: widget.onPageBuilder(cubit) as Widget,
          );
  }
}

```

## Local Database
**Local Database Manager:**
```dart
class LocalDatabaseManager {
  static LocalDatabaseManager? _instance;
  static LocalDatabaseManager get instance {
    return _instance ??= LocalDatabaseManager.init();
  }

  LocalDatabaseManager.init();

  late LocalDatabaseService<VolumeInfo>? bookManager =
      LocalDatabaseService(storeName: LocalDatabaseConstants.books.name);
}
```

**Local Database Service:**
```dart
class LocalDatabaseService<T extends BaseModel?> {
  late StoreRef<int, Map<String, dynamic>> store;
  String? storeName;

  LocalDatabaseService({
    required this.storeName,
  }) {
    store = intMapStoreFactory.store(storeName);
  }

  Future<int> insert(T obj) async {
    return store.add(await LocalDatabase.instance.database, obj!.toJson());
  }

  Future<List<int>> insertAll(List<T> objs) async {
    return store.addAll(await LocalDatabase.instance.database, objs.map((e) => e!.toJson()).toList());
  }

  Future<int> update(T obj) async {
    final finder = Finder(filter: Filter.byKey(obj!.localId));
    return store.update(await LocalDatabase.instance.database, obj.toJson(), finder: finder);
  }

  Future<int> delete(T obj) async {
    final finder = Finder(filter: Filter.byKey(obj!.localId));
    return store.delete(await LocalDatabase.instance.database, finder: finder);
  }

  Future<int> deleteAll() async {
    return store.delete(await LocalDatabase.instance.database);
  }

  Future<List<T>> getCachedData(T obj) async {
    final recordSnapshots = await store.find(await LocalDatabase.instance.database);

    return recordSnapshots.map((snapshot) {
      final requests = obj!.fromJson(snapshot.value) as T;
      requests!.localId = snapshot.key;
      return requests;
    }).toList();
  }
}

```

**Local Database:**
```dart
class LocalDatabase {
  static LocalDatabase? _instance;
  static LocalDatabase get instance {
    return _instance ??= LocalDatabase.init();
  }

  LocalDatabase.init();
  bool isDatabaseOpen = false;
  final String databaseName = 'app.db';
  late Database? _database;

  Future<Database> get database async {
    if (isDatabaseOpen == false) {
      try {
        return _openDatabase();
      } catch (e) {
        throw Exception('the database can not be opened');
      }
    } else {
      return _database!;
    }
  }

  Future clear() async {
    final db = await database;
    await db.close();
    await databaseFactoryIo.deleteDatabase(db.path);
    isDatabaseOpen = false;
  }

  Future<Database> _openDatabase() async {
      final appDocumentDir = await getApplicationDocumentsDirectory();
      final String dbPath = '${appDocumentDir.path}/$databaseName';
      final database = await databaseFactoryIo.openDatabase(dbPath);
      isDatabaseOpen = true;
      return _database = database;
  }
}
```

## Service
**Home Service:**
```dart
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
```
## BLoC/Cubit

**Home Cubit:**
```dart
  void getBooksLoading(bool loading) {
    emit(state.copyWith(isLoading: loading));
  }

  void fetchBooks(String query) async {
    getBooksLoading(true);
    bookListCubit = (await homeService.getBooks(query))!;
    if (bookListCubit.items == null) {
      print('NULL');
    }
    emit(state.copyWith(bookListState: AppStateManager.instance.bookList));
    getBooksLoading(false);
  }

  void setSelectedBook(VolumeInfo? book) {
    emit(state.copyWith(book: book));
    selectedBook = state.book!;
  }

  Future setFavoriteBook() async {
    if (state.isFavorited) {
      selectedBook!.isFavorite = false;
      await localDatabaseManager.bookManager!.delete(selectedBook!);
    } else {
      selectedBook!.isFavorite = true;
      await localDatabaseManager.bookManager!.insert(selectedBook!);
    }
    emit(state.copyWith(isFavorited: !state.isFavorited));
    await getFavoriteBook();
  }

  Future<void> getFavoriteBook() async {
    favoriteBookList =
        await localDatabaseManager.bookManager!.getCachedData(VolumeInfo());
    selectedBook = favoriteBookList.firstWhere(
      (element) => element.localId == selectedBook!.localId,
      orElse: () => selectedBook!,
    );
  }

  void getIsFavoriteStatus() async {
    await getFavoriteBook();
    if (favoriteBookList
        .where((element) => element.localId == selectedBook!.localId)
        .isNotEmpty) {
      emit(state.copyWith(isFavorited: true));
    } else {
      emit(state.copyWith(isFavorited: false));
    }
  }
```

**Favorite Books Cubit:**
```dart
  Future<void> fetchFavoriteBookList() async {
    getBooksCacheLoading(true);
    favoriteBookList =
        await localDatabaseManager.bookManager!.getCachedData(VolumeInfo());

    emit(state.copyWith(favoriteBookList: favoriteBookList));
    getBooksCacheLoading(false);
  }

  void removeBookFromFavorite(VolumeInfo model) {
    localDatabaseManager.bookManager!.delete(model);
    favoriteBookList.remove(model);
    emit(state.copyWith(favoriteBookList: favoriteBookList));
  }

  void navigate() async {
    await navigation.navigateToPageClear(path: NavigationConstants.DEFAULT);
  }

  void getBooksCacheLoading(bool loading) {
    emit(state.copyWith(isLoading: loading));
  }
  ```

  # Folder Structure

```
books_store_app
│   
└───lib
    │
    └───core
    │    │    
    │    └───base
    │    │
    │    └───cache
    │    │ 
    │    └───components
    │    │    
    │    └───constants
    │    │
    │    └───extensions
    │    │
    │    └───init
    │    │
    │    └───utility
    └───features
         └───favorite_books
         └───home
```
