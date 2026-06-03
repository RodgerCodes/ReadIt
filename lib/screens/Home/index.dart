import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:readit/data/cubits/books/book_cubit_cubit.dart';
import 'package:readit/data/cubits/preload/preload_cubit.dart';
import 'package:readit/theme/colors.dart';
import 'package:readit/utils/common.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool noDir = false;
  void selectDirectory() async {
    String? selectedDirectory = await FilePicker.getDirectoryPath();
    if (selectedDirectory == null) {
      print("Please select a directory to watch");
    } else {
      await saveFilesPath(selectedDirectory);
      BlocProvider.of<PreloadCubit>(context).preloadData();
    }
  }

  void processDirInPrefs() async {
    final path = await getFilePath();
    if (path == null) {
      setState(() {
        noDir = true;
      });
    } else {
      BlocProvider.of<BookCubitCubit>(context).loadBooks();
    }
  }

  @override
  void initState() {
    super.initState();
    processDirInPrefs();
  }

  @override
  Widget build(BuildContext context) {
    final homeContext = context;
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: false,
        leading: Text(""),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: CustomScrollView(
          slivers: [
            if (noDir) ...[
              SliverToBoxAdapter(
                child: Center(
                  child: FilledButton(
                    onPressed: () {
                      selectDirectory();
                    },
                    child: Text("Load Books"),
                  ),
                ),
              ),
            ],
            BlocConsumer<PreloadCubit, PreloadState>(
              listener: (context, state) {
                if (state is PreloadingDataDone) {
                  BlocProvider.of<BookCubitCubit>(homeContext).loadBooks();
                }
              },
              builder: (context, state) {
                if (state is PreloadingData) {
                  return SliverToBoxAdapter(
                    child: SizedBox(
                      height: size.height * 0.7,
                      child: Column(
                        children: [
                          Text("Loading books, please wait"),
                          SpinKitFadingCircle(color: AppColors.primaryColour),
                        ],
                      ),
                    ),
                  );
                } else if (state is PreloadingDataFailed) {
                  return SliverToBoxAdapter(
                    child: Text("Failed to preload data"),
                  );
                } else {
                  return SliverToBoxAdapter();
                }
              },
            ),
            BlocBuilder<BookCubitCubit, BookCubitState>(
              builder: (context, state) {
                if (state is FailedToGetAvailableBooks) {
                  return SliverToBoxAdapter(
                    child: Center(child: Text("I am the home")),
                  );
                } else if (state is FetchedBooks) {
                  if (state.books.isEmpty) {
                    return SliverToBoxAdapter(
                      child: SizedBox(
                        height: size.height * 0.7,
                        child: Center(
                          child: Column(
                            spacing: 12,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("No books available"),
                              FilledButton(
                                onPressed: () {
                                  selectDirectory();
                                },
                                child: Text("Load Books"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  } else {
                    return SliverGrid.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 6,
                        crossAxisSpacing: 12.0,
                        mainAxisSpacing: 16.0,
                        childAspectRatio: 0.65,
                      ),
                      itemCount: state.books.length,
                      itemBuilder: (context, index) {
                        final book = state.books[index];
                        return Container(
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              // Cover image
                              book.cover != null
                                  ? Image.memory(
                                      book.cover!,
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) => Container(
                                        color: Colors.grey[900],
                                        child: const Center(
                                          child: Icon(
                                            Icons.book,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container(
                                      color: Colors.grey[900],
                                      child: const Center(
                                        child: Icon(
                                          Icons.book,
                                          size: 48,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),

                              // Gradient overlay + text at bottom
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [
                                        Colors.black.withOpacity(0.85),
                                        Colors.transparent,
                                      ],
                                    ),
                                  ),
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        book.title ?? 'Unknown Title',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        book.author ?? 'Unknown Author',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.white.withOpacity(0.7),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                } else {
                  return SliverToBoxAdapter(
                    child: SizedBox(
                      height: size.height * 0.7,
                      child: Center(
                        child: SpinKitFadingCircle(
                          color: AppColors.primaryColour,
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
