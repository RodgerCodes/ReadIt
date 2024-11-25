import 'package:shared_preferences/shared_preferences.dart';

Future<String?> getDirectory() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString("directory");
}

void saveDirectory(String path) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("directory", path);
}
