part of 'book_cubit_cubit.dart';

@immutable
sealed class BookCubitState {}

final class BookCubitInitial extends BookCubitState {}

final class FetchingAvailableBooks extends BookCubitState {}

final class FailedToGetAvailableBooks extends BookCubitState {
  final String message;

  FailedToGetAvailableBooks({required this.message});
}

final class FetchedBooks extends BookCubitState {
  final List books;
  FetchedBooks({required this.books});
}
