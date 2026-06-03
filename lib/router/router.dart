import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:readit/data/cubits/books/book_cubit_cubit.dart';
import 'package:readit/data/cubits/preload/preload_cubit.dart';
import 'package:readit/data/services/book_service.dart';
import 'package:readit/screens/Home/index.dart';
import 'package:readit/screens/Home/pdf_viewer.dart';
import 'package:readit/screens/splash.dart';

final routerConfig = GoRouter(
  routes: [
    GoRoute(
      name: "splash",
      path: "/",
      builder: (context, state) => Splash(),
      routes: [
        GoRoute(
          name: "home",
          path: "home",
          builder: (context, state) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => BookCubitCubit(bookService: BookService()),
              ),
              BlocProvider(
                create: (context) => PreloadCubit(bookService: BookService()),
              ),
            ],
            child: HomePage(),
          ),
          routes: [
            GoRoute(
              name: "view",
              path: "view/:path",
              builder: (context, state) {
                final filePath = Uri.decodeComponent(
                  state.pathParameters['path']!,
                );
                return PdfViewer(filePath: filePath);
              },
            ),
          ],
        ),
      ],
    ),
  ],
);
