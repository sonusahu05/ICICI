import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:ui';
import 'package:flutter_charts/flutter_charts.dart';
import 'package:flutter/rendering.dart';
import 'package:image/image.dart' as img;
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share/share.dart';
import 'package:dyhra/constants/routes.dart';

GlobalKey globalKey = GlobalKey();

// import 'package:charts_flutter/flutter.dart' as charts;

class ReportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('REPORT'),
        actions: [
          IconButton(
            icon: Icon(Icons.picture_as_pdf),
            onPressed: _printToPdf,
          ),
        ],
      ),
      body: RepaintBoundary(
        key: globalKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Trend Graph
              Container(
                height: 200,
                child: AnimatedGraph(),
              ),

              // Summary Section
              Container(
                margin: EdgeInsets.all(16),
                child: Text(
                  'Summary',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),

              // BMI Numerical Value with Meter Indicator
              Container(
                margin: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Text(
                      'BMI:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 8),
                    AnimatedMeterIndicator(value: 25),
                  ],
                ),
              ),

              // Waist to Hip Ratio Numerical Value with Meter Indicator
              Container(
                margin: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Text(
                      'Waist to Hip Ratio:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 8),
                    AnimatedMeterIndicator(value: 0.8),
                  ],
                ),
              ),

              // Wellness Score Numerical Value
              Container(
                margin: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Text(
                      'Wellness Score:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 8),
                    Text(
                      '80',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),

              // Nutrition Index Numerical Value
              Container(
                margin: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Text(
                      'Nutrition Index:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 8),
                    Text(
                      '75',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),

              // Lifestyle Index Numerical Value
              Container(
                margin: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Text(
                      'Lifestyle Index:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 8),
                    Text(
                      '90',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),

              // Stress Index Numerical Value
              Container(
                margin: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Text(
                      'Stress Index:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 8),
                    Text(
                      '60',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),

              // Wellbeing Index Numerical Value
              Container(
                margin: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Text(
                      'Wellbeing Index:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 8),
                    Text(
                      '85',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),

              // Health Feedback Section
              Container(
                margin: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Health Feedback:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    BulletPoint(text: 'Maintain a balanced diet.'),
                    BulletPoint(text: 'Engage in regular physical activity.'),
                    BulletPoint(text: 'Manage stress effectively.'),
                  ],
                ),
              ),

              // Source Citation Button
              Container(
                margin: EdgeInsets.all(16),
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Implement button action
                  },
                  child: Text('Source Citation'),
                ),
              ),
              // Retake Icon
              Container(
                margin: EdgeInsets.all(16),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: Icon(Icons.replay),
                    onPressed: () {
                      Navigator.pushNamed(context, ques3);
                      // TODO: Implement retake functionality
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> _printToPdf() async {
  try {
    final RenderRepaintBoundary boundary =
        globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    final image = await boundary.toImage(pixelRatio: 3.0);
    final byteData = await image.toByteData(format: ImageByteFormat.png);
    final Uint8List bytes = byteData!.buffer.asUint8List();

    final pdf = pw.Document();
    final pdfImage = pw.MemoryImage(bytes);
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Image(pdfImage);
        },
      ),
    );
    final Directory directory = await getApplicationDocumentsDirectory();
    final String path = '${directory.path}/report.pdf';

    final file = File(path);
    await file.writeAsBytes(await pdf.save());

    // Show a share dialog to share the PDF file
    Share.shareFiles([path], text: 'Sharing PDF');

    // You can also open the PDF directly using a PDF viewer app
    // For example:
    // await OpenFile.open(path);
  } catch (e) {
    // Handle error
  }
}

class AnimatedGraph extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: Implement trend graph with 15 entries on x-axis
    // Use charts_flutter package to create the graph
    // You can refer to the package documentation for more details: https://pub.dev/packages/charts_flutter

    return Container(
      // Placeholder for the graph
      color: Colors.grey[300],
    );
  }
}

class AnimatedMeterIndicator extends StatefulWidget {
  final double value;

  const AnimatedMeterIndicator({required this.value});

  @override
  _AnimatedMeterIndicatorState createState() => _AnimatedMeterIndicatorState();
}

class _AnimatedMeterIndicatorState extends State<AnimatedMeterIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    _animation =
        Tween<double>(begin: 0, end: widget.value).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (BuildContext context, Widget? child) {
        return Container(
          width: 100,
          height: 20,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(10),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: _animation.value,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        );
      },
    );
  }
}

class BulletPoint extends StatelessWidget {
  final String text;

  const BulletPoint({required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 8,
          height: 8,
          child: DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ReportPage(),
  ));
}
