import 'package:favorite_books_app/core/base/view/base_view.dart';
import 'package:favorite_books_app/core/components/card/book_info_card.dart';
import 'package:favorite_books_app/core/constants/image/image_constants.dart';
import 'package:favorite_books_app/core/constants/strings/strings_constant.dart';
import 'package:favorite_books_app/core/extensions/context_extensions.dart';
import 'package:favorite_books_app/core/init/di/locator.dart';
import 'package:favorite_books_app/feature/favorite_books/cubit/favorite_books_cubit.dart';
import 'package:favorite_books_app/feature/home/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteBooks extends StatelessWidget {
  const FavoriteBooks({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<FavoritesCubit>(
      cubit: FavoritesCubit(),
      onCubitReady: (cubit) {
        cubit.setContext(context);
        cubit.init();
      },
      onPageBuilder: (FavoritesCubit cubit) => Scaffold(
        appBar: buildAppBar(context, cubit),
        body: buildBody(cubit),
      ),
    );
  }

  BlocBuilder<FavoritesCubit, FavoritesState> buildBody(FavoritesCubit cubit) {
    return BlocBuilder<FavoritesCubit, FavoritesState>(
        builder: (context, state) {
          return state.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: context.paddingLowHorizontal,
                        child: ListView.separated(
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onLongPress: () {
                                cubit.removeBookFromFavorite(
                                    state.favoriteBookList![index]);
                                cubit.fetchFavoriteBookList();
                              },
                              child: BookInfoCard(
                                borderColor: context.appColors.violetRed,
                                image: state.favoriteBookList?[index]
                                            .imageLinks?.thumbnail! ==
                                        null
                                    ? Image.asset(
                                        ImageConstants.instance.emptyBook)
                                    : Image.network(
                                        state.favoriteBookList?[index]
                                                .imageLinks?.thumbnail! ??
                                            '',
                                      ),
                                title: state.favoriteBookList?[index].title,
                                publisherVisible: locator<HomeCubit>()
                                    .textControl(state
                                        .favoriteBookList?[index].publisher),
                                publisher:
                                    state.favoriteBookList?[index].publisher,
                                publishedDate: state
                                    .favoriteBookList?[index].publishedDate,
                                publishedDateVisible: locator<HomeCubit>()
                                    .textControl(state
                                        .favoriteBookList?[index]
                                        .publishedDate),
                                pageCount: state
                                    .favoriteBookList?[index].pageCount
                                    .toString(),
                                pageCountVisible: locator<HomeCubit>()
                                    .textControl(state
                                        .favoriteBookList?[index].pageCount
                                        .toString()),
                                authors:
                                    '${state.favoriteBookList?[index].authors ?? ''}',
                                authorsVisible: state.favoriteBookList?[index]
                                    .authors?.isNotEmpty,
                              ),
                            );
                          },
                          separatorBuilder: (context, index) =>
                              context.sizedBoxLowVertical,
                          itemCount: state.favoriteBookList?.length ?? 0,
                        ),
                      ),
                    ),
                  ],
                );
        },
      );
  }

  AppBar buildAppBar(BuildContext context, FavoritesCubit cubit) {
    return AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        iconTheme: IconThemeData(color: context.appColors.mirage),
        title: Text(
          StringConstants.favorites,
          style: context.textTheme.headline1,
        ),
        leading: IconButton(
            onPressed: () => cubit.navigate(),
            icon: Icon(
              Icons.arrow_back_ios,
              color: context.appColors.white,
            )),
      );
  }
}
