import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:readit/data/services/book_service.dart';
import 'package:readit/utils/errors.dart';

part 'book_cubit_state.dart';

class BookCubitCubit extends Cubit<BookCubitState> {
  final BookService bookService;
  BookCubitCubit({required this.bookService}) : super(BookCubitInitial());

  void loadBooks() {
    emit(FetchingAvailableBooks());

    bookService.getAvailableBooksInDir().then((response) {
      if (response["error"]) {
        emit(
          FailedToGetAvailableBooks(
            message: response["message"],
            errorType: response["type"],
          ),
        );
      } else {
        // emit(state)
      }
    });
  }
}
