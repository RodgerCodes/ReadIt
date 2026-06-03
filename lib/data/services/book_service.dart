import 'dart:io';

import 'package:readit/utils/common.dart';
import 'package:readit/utils/errors.dart';

class BookService {
  Future getAvailableBooksInDir() async {
    try {
      final path = await getFilePath();

      if (path == null) {
        return {
          "error": true,
          "type": ErrorTypes.dirNotFound,
          "message": "Directory not found",
        };
      } else {
        final directory = Directory(path);
        List<FileSystemEntity> entities = directory.listSync(recursive: false);

        List files = entities
            .whereType<File>()
            .where((file) => file.path.toLowerCase().endsWith('.pdf'))
            .toList();

        // read metadata

        // print(files);
        return {
          "error": false,
          // "type": ErrorTypes.dirNotFound,
          "message": "Directory  found",
        };
      }
    } catch (err) {
      print(err);
    }
  }
}
