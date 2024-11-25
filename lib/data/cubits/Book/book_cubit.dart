import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:readit/data/book_manager.dart';

part 'book_state.dart';

class BookCubit extends Cubit<BookState> {
  final BookManager bookManager;
  BookCubit({required this.bookManager}) : super(BookInitial());

  void loadBooks() {
    emit(LoadingBooks());
    bookManager.loadBookInDirectory().then((response) {
      if (response['error']) {
        emit(LoadingBooksError(msg: response['msg']));
      } else {
        emit(LoadingBooksSuccess(books: response['books']));
      }
    });
  }
}
