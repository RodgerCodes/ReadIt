import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:readit/data/services/book_service.dart';

part 'preload_state.dart';

class PreloadCubit extends Cubit<PreloadState> {
  final BookService bookService;
  PreloadCubit({required this.bookService}) : super(PreloadInitial());

  void preloadData() {
    emit(PreloadingData());
    bookService.getAvailableBooksInDir().then((response) {
      if (response["error"]) {
        emit(PreloadingDataFailed(message: response["message"]));
      } else {
        emit(PreloadingDataDone(message: response["message"]));
      }
    });
  }
}
