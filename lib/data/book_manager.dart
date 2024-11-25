import 'dart:io';

import 'package:file_selector/file_selector.dart';
import 'package:readit/utils/helpers.dart';

class BookManager {
  Future loadBookInDirectory() async {
    try {
      final directory = await getDirectory();
      if (directory == null) {
        return {
          "error": false,
          "books": [],
        };
      } else {
        return {
          "error": false,
          "books": [],
        };
      }
    } catch (err) {
      return {
        "error": true,
        "msg": err.toString(),
      };
    }
  }

  dynamic saveDirectory() async {
    try {
      final String? directoryPath = await getDirectoryPath();
      if (directoryPath != null) {
        final Directory directory = Directory(directoryPath);
        final List<FileSystemEntity> files = directory.listSync();
        print(files);
      } else {
        print("No directory choosen");
      }
    } catch (err) {}
  }
}
