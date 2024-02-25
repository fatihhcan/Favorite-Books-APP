import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:favorite_books_app/core/base/cubit/base_cubit.dart';
import 'package:favorite_books_app/core/constants/navigation/navigation_constants.dart';

import 'package:favorite_books_app/feature/home/model/response/books_volume_info_response_model.dart';
import 'package:flutter/material.dart';

part 'favorite_books_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> with BaseCubit {
  FavoritesCubit() : super(const FavoritesState());

  List<VolumeInfo> favoriteBookList = [];
  @override
  void init() async {
    await fetchFavoriteBookList();
  }

  @override
  void setContext(BuildContext context) {}

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
}
