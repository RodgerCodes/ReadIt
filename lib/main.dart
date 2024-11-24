import 'package:fluent_ui/fluent_ui.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readit/router/index.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    FluentApp.router(
      routerConfig: router,
      theme: FluentThemeData(
        fontFamily: GoogleFonts.roboto().fontFamily,
        brightness: Brightness.dark,
      ),
    ),
  );
}
