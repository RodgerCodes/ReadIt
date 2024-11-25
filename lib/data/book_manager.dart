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

  dynamic saveDirectory() async {}
}
