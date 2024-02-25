import 'package:favorite_books_app/feature/favorite_books/cubit/favorite_books_cubit.dart';
import 'package:favorite_books_app/feature/home/cubit/home_cubit.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

Future<void> init() async {
  locator.registerLazySingleton(() => HomeCubit());
  locator.registerLazySingleton(() => FavoritesCubit());
}
