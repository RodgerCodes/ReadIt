part of 'book_cubit.dart';

@immutable
sealed class BookState {}

final class BookInitial extends BookState {}

final class LoadingBooks extends BookState {}

final class LoadingBooksError extends BookState {
  final String msg;

  LoadingBooksError({required this.msg});
}

// ignore: must_be_immutable
final class LoadingBooksSuccess extends BookState {
  List books;

  LoadingBooksSuccess({required this.books});
}
