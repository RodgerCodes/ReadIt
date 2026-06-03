import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:readit/data/models/book.dart';
import 'package:readit/data/services/db_service.dart';
import 'package:readit/utils/common.dart';
import 'package:readit/utils/errors.dart';
import 'package:pdf_render/pdf_render.dart' as pdf_render;
import 'package:syncfusion_flutter_pdf/pdf.dart' as syncfusion;

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
        List books = <Book>[];
        final directory = Directory(path);
        List<FileSystemEntity> entities = directory.listSync(recursive: false);

        List files = entities
            .whereType<File>()
            .where((file) => file.path.toLowerCase().endsWith('.pdf'))
            .toList();

        for (final file in files) {
          Uint8List? cover;
          final fileBytes = await file.readAsBytes();
          final syncfusion.PdfDocument pdfDocument = syncfusion.PdfDocument(
            inputBytes: fileBytes,
          );
          final info = pdfDocument.documentInformation;
          final String? title = (info.title.isNotEmpty == true)
              ? info.title
              : file.path.split('/').last.replaceAll('.pdf', '');
          final String? author = info.author.isNotEmpty == true
              ? info.author
              : null;

          pdfDocument.dispose();

          final pdfDoc = await pdf_render.PdfDocument.openFile(file.path);
          final page = await pdfDoc.getPage(1);
          final pageImage = await page.render(
            width: page.width.toInt() * 2,
            height: page.height.toInt() * 2,
          );
          final image = await pageImage.createImageDetached();
          final byteData = await image.toByteData(
            format: ui.ImageByteFormat.png,
          );
          cover = byteData?.buffer.asUint8List();
          pdfDoc.dispose();
          await DbService().saveBook(
            Book(path: file.path, title: title, author: author, cover: cover),
          );
        }

        return {"error": false, "message": "Done"};
      }
    } catch (err) {
      return {
        "error": true,
        "type": ErrorTypes.generalError,
        "message": "Error",
      };
    }
  }

  // get books
  Future getCachedBooks() async {
    try {
      final books = await DbService().getBooks();
      return {"error": false, "data": books};
    } catch (err) {
      return {
        "error": true,
        "type": ErrorTypes.generalError,
        "message": "Error",
      };
    }
  }
}
