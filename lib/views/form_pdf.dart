import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PdfPreviewPage extends StatelessWidget {
  final Map<String, dynamic>? reportData;
  const PdfPreviewPage({required this.reportData, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HRA Report'),
      ),
      body: PdfPreview(
        build: (context) => makePdf(),
      ),
    );
  }

  Future<Uint8List> makePdf() async {
    final pdf = pw.Document();

    final ByteData bytes1 = await rootBundle.load('assets/img1.png');
    final Uint8List byteList1 = bytes1.buffer.asUint8List();

    final ByteData bytes2 = await rootBundle.load('assets/img2.png');
    final Uint8List byteList2 = bytes2.buffer.asUint8List();

    List<dynamic> section = reportData!['sections'];

    pdf.addPage(
      pw.MultiPage(
        margin: const pw.EdgeInsets.all(10),
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return [
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Expanded(
                  flex: 1,
                  child: pw.Image(
                    pw.MemoryImage(byteList2),
                    fit: pw.BoxFit.fitHeight,
                    height: 30,
                  ),
                ),
                pw.Expanded(
                  flex: 1,
                  child: pw.Center(
                    child: pw.Header(
                      text: "Health Risk Assessment",
                      level: 2,
                    ),
                  ),
                ),
                pw.Expanded(
                  flex: 1,
                  child: pw.Image(
                    pw.MemoryImage(byteList1),
                    fit: pw.BoxFit.fitHeight,
                    height: 50,
                  ),
                ),
              ],
            ),
            pw.Divider(borderStyle: pw.BorderStyle.dashed),
            pw.Paragraph(text: "Date and Time: " + reportData!['timestamp']),
            pw.Paragraph(text: "Scores:"),
            pw.Table(
              border: pw.TableBorder.all(
                color: PdfColors.black,
                width: 1.0,
                style: pw.BorderStyle.solid,
              ),
              defaultColumnWidth: const pw.FlexColumnWidth(1.0),
              children: [
                // Table header
                pw.TableRow(
                  children: [
                    pw.Center(
                        child: pw.Text('Type',
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold))),
                    pw.Center(
                        child: pw.Text('Score',
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold))),
                  ],
                ),
                // Table rows
                pw.TableRow(
                  children: [
                    pw.Center(child: pw.Text('Health Score')),
                    pw.Center(
                        child: pw.Text(reportData!['HRA']!.toStringAsFixed(2))),
                  ],
                ),
                pw.TableRow(
                  children: [
                    pw.Center(child: pw.Text('BMI')),
                    pw.Center(
                        child: pw.Text(reportData!['bmi']!.toStringAsFixed(2))),
                  ],
                ),
                pw.TableRow(
                  children: [
                    pw.Center(child: pw.Text('WHR')),
                    pw.Center(
                        child: pw.Text(reportData!['whr']!.toStringAsFixed(2))),
                  ],
                ),
              ],
            ),
            pw.Divider(borderStyle: pw.BorderStyle.dashed),
            pw.Paragraph(text: "Question-wise Scores:"),
            pw.ListView.builder(
              itemCount: section.length,
              itemBuilder: (context, index) {
                final current = section[index];

                return pw.Container(
                  margin: const pw.EdgeInsets.all(10),
                  padding: const pw.EdgeInsets.all(8),
                  decoration: pw.BoxDecoration(
                    color: PdfColors.white,
                    borderRadius: pw.BorderRadius.circular(20),
                    boxShadow: const [
                      pw.BoxShadow(
                        color: PdfColors.grey300,
                        spreadRadius: 5,
                        blurRadius: 7,
                      ),
                    ],
                  ),
                  child: pw.Column(
                    children: [
                      pw.Row(
                        crossAxisAlignment: pw.CrossAxisAlignment.center,
                        children: [
                          pw.Expanded(
                            flex: 3,
                            child: pw.Container(
                              decoration: pw.BoxDecoration(
                                color: PdfColors.grey300,
                                borderRadius: pw.BorderRadius.circular(15),
                              ),
                              padding: const pw.EdgeInsets.all(8),
                              child: pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.SizedBox(height: 10),
                                  pw.Text(
                                    current?['score'].toStringAsFixed(2) +
                                            "%" ??
                                        '',
                                    style: pw.TextStyle(
                                      fontSize: 20,
                                      fontWeight: pw.FontWeight.bold,
                                      color: PdfColors.black,
                                    ),
                                  ),
                                  pw.SizedBox(height: 5),
                                  pw.Text(
                                    current?['sectionName'] ?? '',
                                    style: pw.TextStyle(
                                      fontSize: 20,
                                      fontWeight: pw.FontWeight.bold,
                                      color: PdfColors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          pw.SizedBox(width: 10),
                          pw.Expanded(
                            flex: 7,
                            child: pw.Container(
                              padding: const pw.EdgeInsets.all(8),
                              child: pw.Column(
                                mainAxisAlignment: pw.MainAxisAlignment.center,
                                crossAxisAlignment:
                                    pw.CrossAxisAlignment.center,
                                children: [
                                  pw.Text(
                                    current?['remarkType'] ?? '',
                                    style: pw.TextStyle(
                                      fontSize: 25,
                                      fontWeight: pw.FontWeight.bold,
                                      color: PdfColors.black,
                                    ),
                                    textAlign: pw.TextAlign.center,
                                  ),
                                  pw.Text(current?['remark'] ?? ''),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      pw.Divider(),
                      pw.ListView.builder(
                        itemCount: current['questionRemarks']?.length ?? 0,
                        itemBuilder: (context, index) {
                          final newCurr = current['questionRemarks']?[index];

                          return pw.Container(
                            margin: const pw.EdgeInsets.all(8),
                            padding: const pw.EdgeInsets.all(6),
                            decoration: pw.BoxDecoration(
                              color: PdfColors.white,
                              borderRadius: pw.BorderRadius.circular(10),
                              boxShadow: const [
                                pw.BoxShadow(
                                  color: PdfColors.grey300,
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                            child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.stretch,
                              children: [
                                pw.Text(
                                  newCurr?['question'] ?? '',
                                  style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold),
                                ),
                                pw.SizedBox(height: 5),
                                pw.Text(
                                  'Score: ${newCurr?['score']?.toStringAsFixed(2) ?? ''} ${newCurr?['remark'] ?? ''} ',
                                  style: pw.TextStyle(
                                    color: PdfColors.green,
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      )
                    ],
                  ),
                );
              },
            ),
          ];
        },
      ),
    );

    return pdf.save();
  }
}
