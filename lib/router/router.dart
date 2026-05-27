

import 'package:go_router/go_router.dart';
import 'package:readit/screens/splash.dart';

final routerConfig = GoRouter(
  routes: [
    GoRoute(
      name: "splash",
      path: "/",
      builder: (context, state) => Splash(),
    )
  ]
);