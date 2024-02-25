import 'dart:async';
import 'package:favorite_books_app/core/base/cubit/base_cubit.dart';
import 'package:favorite_books_app/core/constants/navigation/navigation_constants.dart';

import 'package:favorite_books_app/core/init/app_state/app_state.dart';

import 'package:favorite_books_app/feature/home/model/response/books_list_response_model.dart';
import 'package:favorite_books_app/feature/home/model/response/books_volume_info_response_model.dart';
import 'package:favorite_books_app/feature/home/service/home_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeCubitState> with BaseCubit {
  HomeCubit() : super(const HomeCubitState());
  late final List<Widget> viewList;
  late PageController controller;
  late HomeService homeService;
  late TextEditingController searchTextController;
  BooksListResponseModel bookListCubit = BooksListResponseModel();
  VolumeInfo? selectedBook;
  List<VolumeInfo> favoriteBookList = [];
  @override
  Future<void> init() async {
    searchTextController = TextEditingController();
    initServices();

    getIsFavoriteStatus();
    if (state.book != null) {
      selectedBook = state.book;
    }
  }

  @override
  void setContext(BuildContext context) => this.context = context;

  void initServices() async {
    homeService = HomeService(dioManager.GoogleBooksClient);
  }

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

  bool textControl(String? value) {
    if (value == null || value.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  void navigate() async {
    await navigation.navigateToPageClear(
        path: NavigationConstants.FAVORITES_BOOKS_VIEW);
  }
}
