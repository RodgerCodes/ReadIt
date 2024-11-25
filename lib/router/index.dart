import 'package:go_router/go_router.dart';
import 'package:readit/data/book_manager.dart';
import 'package:readit/data/cubits/Book/book_cubit.dart';
import 'package:readit/screens/home_screen.dart';
import 'package:readit/screens/splash_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final router = GoRouter(
  routes: [
    // temporary splash screen
    GoRoute(
      name: "splash",
      path: "/",
      builder: (context, state) => const SplashScreen(),
      routes: [
        GoRoute(
          name: "home",
          path: "home",
          builder: (context, state) => BlocProvider(
            create: (context) => BookCubit(
              bookManager: BookManager(),
            ),
            child: const HomeScreen(),
          ),
        )
      ],
    )
  ],
);
