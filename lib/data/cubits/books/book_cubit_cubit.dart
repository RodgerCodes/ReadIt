import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:readit/data/services/book_service.dart';

part 'book_cubit_state.dart';

class BookCubitCubit extends Cubit<BookCubitState> {
  final BookService bookService;
  BookCubitCubit({required this.bookService}) : super(BookCubitInitial());
}
