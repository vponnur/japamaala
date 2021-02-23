import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';
import 'package:japamala/widgets/commonWidget.dart';

class PdfPreviewScreen extends StatelessWidget {
  final String pdfPath;
  const PdfPreviewScreen({Key key, this.pdfPath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
      appBar: appBarMain(
        context,
        title: "Preview",
        removeBackButton: false,
        filePath: pdfPath,
      ),
      path: pdfPath,
    );
  }
}
