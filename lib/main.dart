import 'package:flutter/material.dart';
import 'package:readit/router/router.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
  );

  await windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.maximize(); // ← fills the screen edge to edge
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(
    MaterialApp.router(
      routerConfig: routerConfig,
      debugShowCheckedModeBanner: false,
    ),
  );
}
