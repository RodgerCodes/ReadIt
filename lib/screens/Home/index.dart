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
            return Center(child: Text("Books are available"));
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
