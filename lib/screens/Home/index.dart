import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:readit/data/cubits/books/book_cubit_cubit.dart';
import 'package:readit/data/services/book_service.dart';
import 'package:readit/theme/colors.dart';
import 'package:readit/utils/common.dart';
import 'package:readit/utils/errors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void selectDirectory() async {
    String? selectedDirectory = await FilePicker.getDirectoryPath();
    if (selectedDirectory == null) {
      print("Please select a directory to watch");
    } else {
      await saveFilesPath(selectedDirectory);
      BlocProvider.of<BookCubitCubit>(context).loadBooks();
    }
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<BookCubitCubit>(context).loadBooks();
    return Scaffold(
      body: BlocBuilder<BookCubitCubit, BookCubitState>(
        builder: (context, state) {
          print(state);
          if (state is FailedToGetAvailableBooks) {
            if (state.errorType == ErrorTypes.dirNotFound) {
              return Center(
                child: FilledButton(
                  onPressed: () {
                    selectDirectory();
                  },
                  child: Text("Load Books"),
                ),
              );
            } else {
              return Center(child: Text("I am the home"));
            }
          } else if (state is FetchedBooks) {
            return CustomScrollView(
              slivers: [
                SliverGrid.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    crossAxisSpacing: 12.0,
                    mainAxisSpacing: 12.0,
                    childAspectRatio: 0.65,
                  ),
                  itemCount: state.books.length,
                  itemBuilder: (context, index) {
                    final book = state.books[index];
                    return Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: book.cover != null
                                ? Image.memory(
                                    book.cover!,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    errorBuilder: (_, __, ___) =>
                                        const Icon(Icons.book),
                                  )
                                : const Center(
                                    child: Icon(Icons.book, size: 48),
                                  ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  book.title ?? 'Unknown Title',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  book.author ?? 'Unknown Author',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            );
          } else {
            return Center(
              child: SpinKitFadingCircle(color: AppColors.primaryColour),
            );
          }
        },
      ),
    );
  }
}
