import 'package:favorite_books_app/core/base/view/base_view.dart';
import 'package:favorite_books_app/core/components/card/book_info_card.dart';
import 'package:favorite_books_app/core/constants/image/image_constants.dart';
import 'package:favorite_books_app/core/constants/strings/strings_constant.dart';

import 'package:favorite_books_app/core/extensions/context_extensions.dart';
import 'package:favorite_books_app/feature/home/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeCubit>(
      cubit: HomeCubit(),
      onCubitReady: (cubit) {
        cubit.setContext(context);
        cubit.init();
      },
      onPageBuilder: (HomeCubit cubit) => Scaffold(
        appBar: buildAppBar(context, cubit),
        body: buildBody(cubit),
      ),
    );
  }

  BlocBuilder<HomeCubit, HomeCubitState> buildBody(HomeCubit cubit) {
    return BlocBuilder<HomeCubit, HomeCubitState>(
        builder: (context, state) {
          return state.isLoading
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        context.sizedBoxHighVertical,
                        SizedBox(
                          width: context.width / 1.5,
                          child: TextField(
                            controller: cubit.searchTextController,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: context.appColors.white,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: context.appColors.dodgerBlue,
                                ),
                              ),
                            ),
                            onChanged: (value) {
                              if (value.length > 500) {
                                context.showSnackBar(
                                    StringConstants.invalidTerm);
                              }
                            },
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (cubit.searchTextController.text.isNotEmpty) {
                              cubit.fetchBooks(
                                  cubit.searchTextController.text);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: context.appColors.white,
                            backgroundColor: context.appColors.dodgerBlue,
                          ),
                          child: Text(
                            StringConstants.search,
                            style: context.textTheme.bodyLarge,
                          ),
                        ),
                      ],
                    ),
                    cubit.searchTextController.text.isEmpty
                        ? Expanded(
                            child: Center(
                                child: Image.asset(
                            ImageConstants.instance.emptyBook,
                            height: context.highValue,
                          )))
                        : Expanded(
                            child: Padding(
                              padding: context.paddingLowHorizontal,
                              child: ListView.separated(
                                itemBuilder:
                                    (BuildContext context, int index) {
                                  bool isSelected = cubit.selectedBook ==
                                      state.bookListState?.items![index]
                                          .volumeInfo;
                                  return GestureDetector(
                                    onDoubleTap: () {
                                      cubit.setSelectedBook(state
                                          .bookListState
                                          ?.items![index]
                                          .volumeInfo);
                                      cubit.setFavoriteBook();
                                    },
                                    child: BookInfoCard(
                                      borderColor: isSelected
                                          ? context.appColors.violetRed
                                          : context.appColors.dodgerBlue,
                                      image: state
                                                  .bookListState
                                                  ?.items![index]
                                                  .volumeInfo!
                                                  .imageLinks
                                                  ?.thumbnail! ==
                                              null
                                          ? Image.asset(ImageConstants
                                              .instance.emptyBook)
                                          : Image.network(
                                              state
                                                      .bookListState
                                                      ?.items![index]
                                                      .volumeInfo!
                                                      .imageLinks
                                                      ?.thumbnail! ??
                                                  '',
                                            ),
                                      title: state.bookListState
                                          ?.items![index].volumeInfo!.title,
                                      publisherVisible: cubit.textControl(
                                          state.bookListState?.items![index]
                                              .volumeInfo!.publisher),
                                      publisher: state
                                          .bookListState
                                          ?.items![index]
                                          .volumeInfo!
                                          .publisher,
                                      publishedDate: state
                                          .bookListState
                                          ?.items![index]
                                          .volumeInfo!
                                          .publishedDate,
                                      publishedDateVisible: cubit.textControl(
                                          state.bookListState?.items![index]
                                              .volumeInfo!.publishedDate),
                                      pageCount: state
                                          .bookListState
                                          ?.items![index]
                                          .volumeInfo!
                                          .pageCount
                                          .toString(),
                                      pageCountVisible: cubit.textControl(
                                          state.bookListState?.items![index]
                                              .volumeInfo!.pageCount
                                              .toString()),
                                      authors:
                                          '${state.bookListState?.items![index].volumeInfo!.authors ?? ''}',
                                      authorsVisible: state
                                          .bookListState
                                          ?.items![index]
                                          .volumeInfo!
                                          .authors
                                          ?.isNotEmpty,
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    context.sizedBoxLowVertical,
                                itemCount:
                                    state.bookListState?.items?.length ?? 0,
                              ),
                            ),
                          ),
                  ],
                );
        },
      );
  }

  AppBar buildAppBar(BuildContext context, HomeCubit cubit) {
    return AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: context.appColors.mirage),
        title: Text(
          StringConstants.favoriteBooks,
          style: context.textTheme.headline1,
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () => cubit.navigate(),
            icon: Icon(
              Icons.favorite,
              size: context.highValue / 3,
            ),
          ),
        ],
      );
  }
}
