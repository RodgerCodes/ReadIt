import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveFilesPath(String filePath) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString("storage_path", filePath);
}

Future<String?> getFilePath() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString("storage_path");
}

// errors