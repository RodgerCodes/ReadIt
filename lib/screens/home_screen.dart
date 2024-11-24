import 'package:flutter/material.dart';
import 'package:readit/Theme/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
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
              //   // keyboardType: TextInputType.,
              //   enableSuggestions: true,
              //   // maxLines: 2,
              //   // controller: questionTitle,
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
          )
        ],
      ),
    ));
  }
}
