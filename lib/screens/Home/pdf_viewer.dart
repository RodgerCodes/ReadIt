import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:pdf_render/pdf_render.dart' as pdf_render;
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewer extends StatefulWidget {
  final String filePath;
  const PdfViewer({super.key, required this.filePath});

  @override
  State<PdfViewer> createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  final PdfViewerController _controller = PdfViewerController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.filePath.split('/').last.replaceAll('.pdf', '')),
        actions: [
          IconButton(
            icon: const Icon(Icons.first_page),
            onPressed: () => _controller.firstPage(),
          ),
          IconButton(
            icon: const Icon(Icons.navigate_before),
            onPressed: () => _controller.previousPage(),
          ),
          IconButton(
            icon: const Icon(Icons.navigate_next),
            onPressed: () => _controller.nextPage(),
          ),
          IconButton(
            icon: const Icon(Icons.last_page),
            onPressed: () => _controller.lastPage(),
          ),
        ],
      ),
      body: FutureBuilder<pdf_render.PdfDocument>(
        future: pdf_render.PdfDocument.openFile(widget.filePath),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final doc = snapshot.data!;

          return Container(
            color: Colors.grey[300],
            child: PageView.builder(
              itemCount: (doc.pageCount / 2).ceil(),
              itemBuilder: (context, index) {
                final leftPageNum = index * 2 + 1;
                final rightPageNum = index * 2 + 2;

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 0,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: PdfPageWidget(doc: doc, pageNumber: leftPageNum),
                      ),
                      Container(width: 1, color: Colors.grey.withOpacity(0.3)),
                      if (rightPageNum <= doc.pageCount)
                        Expanded(
                          child: PdfPageWidget(
                            doc: doc,
                            pageNumber: rightPageNum,
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class PdfPageWidget extends StatefulWidget {
  final pdf_render.PdfDocument doc;
  final int pageNumber;
  const PdfPageWidget({super.key, required this.doc, required this.pageNumber});

  @override
  State<PdfPageWidget> createState() => _PdfPageWidgetState();
}

class _PdfPageWidgetState extends State<PdfPageWidget> {
  Uint8List? _imageBytes;

  @override
  void initState() {
    super.initState();
    _renderPage();
  }

  Future<void> _renderPage() async {
    final page = await widget.doc.getPage(widget.pageNumber);
    final pageImage = await page.render(
      width: page.width.toInt() * 2,
      height: page.height.toInt() * 2,
    );
    final image = await pageImage.createImageDetached();
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    if (mounted) {
      setState(() => _imageBytes = byteData?.buffer.asUint8List());
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_imageBytes == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return Image.memory(_imageBytes!, fit: BoxFit.contain);
  }
}
