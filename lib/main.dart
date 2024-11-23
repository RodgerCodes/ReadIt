import 'package:fluent_ui/fluent_ui.dart';
import 'package:readit/router/index.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    FluentApp.router(
      routerConfig: router,
    ),
  );
}
