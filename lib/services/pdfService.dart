import 'dart:io';
import 'package:japamala/models/constants.dart';
import 'package:japamala/models/userActivity.dart';
import 'package:japamala/services/helperFunctions.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfService {
  Future<void> generatePdfDocument() async {
    String appDir = (await getExternalStorageDirectory()).path;
    String path = "$appDir/report.pdf";
    //print("appDir :: $appDir");

    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Text("Hello world"),
            );
          }),
    );

    final file = File(path);
    file.writeAsBytesSync(pdf.save());
  }

  Future<String> generatePDF({List<UserActivity> userActivity}) async {
    List<List<String>> report = new List();
    report.add(<String>["Name", "Gotram", "City", "Count"]);
    //print("userActivity : ${userActivity.length}");
    userActivity.forEach((item) {
      List<String> act = <String>[
        item.userName,
        item.gothram,
        item.city,
        item.userTotalCount.toString(),
      ];
      report.add(act);
    });
    final pdf = pw.Document();
    pdf.addPage(
      pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          margin: pw.EdgeInsets.all(20),
          build: (pw.Context context) {
            return <pw.Widget>[
              pw.Center(
                child: pw.Header(
                  level: 0,
                  child: pw.Text(
                    "JapaMaala",
                    style: pw.TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
              pw.Paragraph(
                text:
                    "\n Report Date : ${HelperFunctions.getDateFormat()} \n Group Name : ${userActivity[0].groupName.toUpperCase()}, , ",
              ),
              pw.Table.fromTextArray(
                context: context,
                data: report,
              ),
              pw.Anchor(
                name: "JapaMaala",
                child: pw.Text(
                    "\n\n JapaMaala : Try it from Google PlayStore ${Constants.appShareUrl}"),
              ),
              // pw.Footer(
              //   title: pw.Text("\n\n JapaMaala : Try it from google Playstore"),
              // ),
            ];
          }),
    );
    String path = await savePDF(pdf);
    return path;
  }

  Future<String> savePDF(pw.Document pdf,
      {String fileName = "japaMaala"}) async {
    fileName = fileName + "_" + HelperFunctions.getDateFormat();
    //Directory dir = await getApplicationDocumentsDirectory();
    Directory dir = await getExternalStorageDirectory();
    String pathPDF = dir.path;
    String filePath = "$pathPDF/$fileName.pdf";
    File file = File(filePath);

    file.writeAsBytesSync(pdf.save());
    //print("filePath :: $filePath");
    return filePath;
  }
}

class PdfGrid {}
