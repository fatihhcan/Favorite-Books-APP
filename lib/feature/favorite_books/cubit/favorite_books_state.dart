part of 'favorite_books_cubit.dart';

class FavoritesState extends Equatable {

  final List<VolumeInfo>? favoriteBookList;
  final bool isLoading;
  const FavoritesState({
    this.favoriteBookList,
    this.isLoading = false
  });

  @override
  List<Object?> get props => [favoriteBookList, isLoading];

  FavoritesState copyWith({
    final List<VolumeInfo>? favoriteBookList,
    final bool? isLoading
  }) {
    return FavoritesState(
      favoriteBookList: favoriteBookList ?? this.favoriteBookList,
      isLoading: isLoading ?? this.isLoading
    );
  }
}
