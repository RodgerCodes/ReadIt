import 'package:go_router/go_router.dart';
import 'package:readit/screens/splash_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      name: "splash",
      path: "/",
      builder: (context, state) => const SplashScreen(),
    )
  ],
);
