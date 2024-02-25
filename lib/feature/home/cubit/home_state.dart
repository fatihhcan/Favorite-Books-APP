part of 'home_cubit.dart';

class HomeCubitState extends Equatable {
  final bool isLoading;
  final BooksListResponseModel? bookListState;
  final String? appDocumentsDirectory;
  final List<VolumeInfo>? favoriteBooks;
  final VolumeInfo? book;
  final bool isFavorited;

  const HomeCubitState(
      {
      this.isLoading = false,
      this.bookListState,
      this.appDocumentsDirectory,
      this.favoriteBooks,
      this.book,
      this.isFavorited = false});

  HomeCubitState copyWith(
      {
      bool? isLoading,
      BooksListResponseModel? bookListState,
      String? appDocumentsDirectory,
      List<VolumeInfo>? favoriteBooks,
      VolumeInfo? book,
      bool? isFavorited}) {
    return HomeCubitState(
        isLoading: isLoading ?? this.isLoading,
        bookListState: bookListState ?? this.bookListState,
        appDocumentsDirectory: appDocumentsDirectory ?? appDocumentsDirectory,
        favoriteBooks: favoriteBooks ?? favoriteBooks,
        book: book ?? book,
        isFavorited: isFavorited ?? this.isFavorited);
  }

  @override
  List<Object?> get props => [
        isLoading,
        bookListState,
        appDocumentsDirectory,
        favoriteBooks,
        book,
        isFavorited
      ];
}
