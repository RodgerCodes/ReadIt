import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:readit/Theme/colors.dart';
import 'package:readit/data/book_manager.dart';
import 'package:readit/data/cubits/Book/book_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<BookCubit>(context).loadBooks();
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          // header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Your Books",
                style: TextStyle(
                  fontSize: size.width * 0.02,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // TextFormField(
              //   validator: (value) {
              //     if (value == '') {
              //       return 'Please enter your question title';
              //     }

              //     return null;
              //   },

              //   enableSuggestions: true,

              //   decoration: InputDecoration(
              //     isDense: true,
              //     hintText: "Search",
              //     labelText: "Question Title (brief)",
              //     fillColor: Colors.white,
              //     enabledBorder: const OutlineInputBorder(
              //       borderSide: BorderSide(
              //         color: Colors.black,
              //         width: 1.0,
              //       ),
              //     ),
              //     focusedErrorBorder: const OutlineInputBorder(
              //       borderSide: BorderSide(
              //         color: Colors.red,
              //         width: 2,
              //       ),
              //     ),
              //     focusedBorder: OutlineInputBorder(
              //       borderSide: BorderSide(
              //         color: AppColors.loaderColor,
              //         width: 1.0,
              //       ),
              //     ),
              //     errorBorder: const OutlineInputBorder(
              //       borderSide: BorderSide(
              //         color: Colors.red,
              //         width: 2,
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
          // books
          BlocConsumer<BookCubit, BookState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              if (state is LoadingBooksError) {
                return const Center(
                  child: Text("An error occured"),
                );
              } else if (state is LoadingBooksSuccess) {
                if (state.books.isEmpty) {
                  return Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.3,
                      ),
                      const Text(
                        "No Books available",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          BookManager().saveDirectory();
                        },
                        child: const Text(
                          "Load Books",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return const Center(
                    child: Text("Books loaded"),
                  );
                }
              } else {
                return Container(
                  margin: EdgeInsets.only(top: size.height * 0.1),
                  child: Center(
                    child: SpinKitFadingCircle(
                      color: AppColors.loaderColor,
                      size: 60,
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    ));
  }
}
