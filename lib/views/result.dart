import 'package:dyhra/views/form_pdf.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:url_launcher/url_launcher_string.dart';

class PdfView extends StatelessWidget {
  const PdfView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class HealthScoreBarGraph extends StatelessWidget {
  final List<double> hraValues;
  final List<String> hratime;

  const HealthScoreBarGraph(
      {super.key, required this.hraValues, required this.hratime});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: AspectRatio(
        aspectRatio: 1.6, // Adjust the aspect ratio as needed
        child: BarChart(
          BarChartData(
            borderData: FlBorderData(
              show: false,
            ),
            maxY: 100,
            gridData: FlGridData(
              show: true,
              drawHorizontalLine: true,
              drawVerticalLine: false,
              getDrawingHorizontalLine: (value) {
                return const FlLine(
                    color: Colors.black12, strokeWidth: 1, dashArray: [5, 5]);
              },
            ),
            barGroups: hraValues.asMap().entries.map((entry) {
              final int index = entry.key;
              final double hraValue = entry.value;

              return BarChartGroupData(
                x: index, // Use the index as x value
                barRods: [
                  BarChartRodData(
                    toY: hraValue,
                    color: Colors.blue, // Customize the color of the bars
                    width: 16, // Customize the width of the bars
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(6),
                      topRight: Radius.circular(6),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class MyPercentIndicator extends StatelessWidget {
  final double dataValue; // A value from 0 to 100 representing the progress
  final double scale;
  final String indicatorcolor;
  const MyPercentIndicator(this.dataValue, this.scale, this.indicatorcolor,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: CircularPercentIndicator(
      radius: 80.0 / scale, // Adjust the size as needed
      lineWidth: 20.0 / scale,
      percent: dataValue / 100,
      center: Text(
        "${dataValue.toStringAsFixed(0)}%",
        style: TextStyle(
          fontSize: 40 / scale,
          fontWeight: FontWeight.bold,
        ),
      ),
      circularStrokeCap: CircularStrokeCap.round,
      progressColor: indicatorcolor == "red"
          ? Colors.red
          : indicatorcolor == "green"
              ? Colors.green
              : indicatorcolor == "yellow"
                  ? Colors.yellow
                  : Colors.blue,
    ));
  }
}

class HealthReportPage extends StatefulWidget {
  const HealthReportPage({super.key});

  @override
  State<HealthReportPage> createState() => _HealthReportPageState();
}

class _HealthReportPageState extends State<HealthReportPage> {
  Map<String, dynamic>? data;
  Map<String, dynamic>? stats;
  DateTime now = DateTime.now();
  Map<dynamic, dynamic>? nutrition;
  Map<dynamic, dynamic>? lifestyle;
  Map<dynamic, dynamic>? wellbeing;
  Map<dynamic, dynamic>? emotion;
  List<dynamic>? section;
  bool isDropdownOpen = false;

  void toggleDropdown() {
    setState(() {
      isDropdownOpen = !isDropdownOpen;
    });
  }

  @override
  void initState() {
    super.initState();
    String userScoreId = '1'; // Replace with the desired userScoreId
    String rid = '1'; // Replace with the desired rid
    fetchData(userScoreId, rid).then((responseData) {
      setState(() {
        data = responseData;
        section = data?['sections'];
      });
    }).catchError((error) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text('$error'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    });
    fetchGraph(userScoreId).then((responseData) {
      setState(() {
        stats = responseData;
      });
    }).catchError((error) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text('$error'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    });
  }

  Future<Map<String, dynamic>> fetchData(String userScoreId, String rid) async {
    const String baseUrl = 'dhra-api-test-service.onrender.com';
    final queryParameters = {'userScoreId': userScoreId, 'rid': rid};
    final uri = Uri.https(baseUrl, '/fetchReport', queryParameters);
    final Map<String, String> headers = {'accept': '*/*'};
    try {
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (error, stackTrace) {
      print('Error occurred: $error');
      print('Stack trace: $stackTrace');
      throw Exception(
          'Failed to load data. Please check your internet connection and try again.');
    }
  }

  Future<Map<String, dynamic>> fetchGraph(String userScoreId) async {
    const String baseUrl = 'dhra-api-test-service.onrender.com';
    final queryParameters = {'userScoreId': userScoreId};

    final uri = Uri.https(baseUrl, '/fetchTrendGraph', queryParameters);
    final Map<String, String> headers = {'accept': '*/*'};
    try {
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (error, stackTrace) {
      print('Error occurred: $error');
      print('Stack trace: $stackTrace');
      throw Exception(
          'Failed to load data. Please check your internet connection and try again.');
    }
  }

  Color getColorWithTransparency(String colorChange, double opacity) {
    Color baseColor;

    switch (colorChange) {
      case "red":
        baseColor = Colors.red;
        break;
      case "green":
        baseColor = Colors.green;
        break;
      case "yellow":
        baseColor = Colors.yellow;
        break;
      case "blue":
        baseColor = Colors.blue;
        break;
      default:
        baseColor = Colors.red;
        break;
    }

    return baseColor.withOpacity(opacity);
  }

  @override
  Widget build(BuildContext context) {
    List<double> hraValues = [];

    if (stats != null && stats?['latestNodes'] != null) {
      // Use only the HRA values from the latestNodes
      hraValues = (stats?['latestNodes'] as List<dynamic>)
          .map<double>((node) => node['HRA'] as double)
          .toList();

      // Consider taking only the last 15 values
      if (hraValues.length > 15) {
        hraValues = hraValues.sublist(hraValues.length - 15);
      }
    }

    if (data == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Health Risk Assessment"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 0, 48, 91),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    height: 200,
                    padding:
                        const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (data != null) {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return PdfPreviewPage(reportData: data);
                              }));
                            } else {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Error'),
                                    content: const Text('No data available'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          },
                          child: const Text('Generate PDF'),
                        ),
                        const Divider(),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 50, left: 8, right: 8, top: 8),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  width: double.infinity,
                  height: 375,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Health Report ${now.day}/${now.month}/${now.year}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: MyPercentIndicator(data?['HRA'], 1, "red"),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Container(
                                  width: 150,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        211, 111, 189, 253),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Text(
                                          'BMI',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          '${data?['bmi']?.toStringAsFixed(2)}',
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        if (data?['bmi'] < 18.5)
                                          const Text(
                                            'Underweight',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        if (data?['bmi'] >= 18.5 &&
                                            data?['bmi'] < 24.9)
                                          const Text(
                                            'Normal',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        if (data?['bmi'] >= 24.9 &&
                                            data?['bmi'] < 29.9)
                                          const Text(
                                            'Overweight',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        if (data?['bmi'] >= 29.9)
                                          const Text(
                                            'Obese',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  width: 150,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        211, 111, 189, 253),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Text(
                                          'WHR',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          '${data?['whr']?.toStringAsFixed(2)}',
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        if (data?['whr'] < 0.5)
                                          const Text(
                                            'Normal',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        if (data?['whr'] >= 0.5 &&
                                            data?['whr'] < 0.6)
                                          const Text(
                                            'Overweight',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        if (data?['whr'] >= 0.6)
                                          const Text(
                                            'Obese',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )),
                  ]),
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              ListView.builder(
                itemCount: section?.length ?? 0, // Ensure section is not null
                shrinkWrap:
                    true, // Allow ListView to take only the required space
                physics:
                    const NeverScrollableScrollPhysics(), // Disable ListView scrolling
                itemBuilder: (context, index) {
                  final current = section?[index];
                  // Get JSON data for the current item
                  var colorChange = "red";
                  if (current?['sectionName'] == "Nutrition") {
                    colorChange = "green";
                  } else if (current?['sectionName'] == "Stress") {
                    colorChange = "yellow";
                  } else if (current?['sectionName'] == "Emotion") {
                    colorChange = "blue";
                  } else {
                    colorChange = "red";
                  }

                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      width: double.infinity,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Container(
                                  color: getColorWithTransparency(
                                      colorChange, 0.4),
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: MyPercentIndicator(
                                          current?['score'].toDouble(),
                                          2,
                                          colorChange,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        current?['sectionName'],
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 7,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Container(
                                  color: Colors.white,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        current?['remarkType'],
                                        style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          color: getColorWithTransparency(
                                              colorChange, 1),
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(current?['remark']),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                    width: double.infinity,
                    height: 425,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Past assesments",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        HealthScoreBarGraph(hraValues: hraValues, hratime: []),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: double.infinity, // Take full width
                            padding: const EdgeInsets.all(
                                16.0), // Adjust the padding as needed
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(185, 76, 175, 79),
                              borderRadius:
                                  BorderRadius.circular(10.0), // Rounded edges
                            ),
                            child: Text(
                              stats?['growthMessage'] ??
                                  '', // Replace with your actual text
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    )),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Add your onPressed logic here
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: Colors.orange, width: 2),
                      fixedSize:
                          const Size(150, 50), // Specific width and height
                    ),
                    child: const Text(
                      'Take Later',
                      style: TextStyle(color: Colors.orange, fontSize: 20),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Add your onPressed logic here
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      fixedSize:
                          const Size(150, 50), // Specific width and height
                    ),
                    child: const Text(
                      'Retake',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: toggleDropdown,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Source Citations for the HRA',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      if (isDropdownOpen)
                        Column(
                          children: [
                            const SizedBox(height: 10),
                            ListTile(
                              leading: const Icon(Icons.web),
                              title: const Text(
                                "HRA Questionnaire",
                                style: TextStyle(color: Colors.black),
                              ),
                              trailing: const Icon(Icons.arrow_forward_ios),
                              onTap: () {
                                launchUrlString(
                                    'https://www.carepatron.com/templates/health-risk-assessment-questionnaire');
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.web),
                              title: const Text(
                                "HRA Template",
                                style: TextStyle(color: Colors.black),
                              ),
                              trailing: const Icon(Icons.arrow_forward_ios),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const PDF().cachedFromUrl(
                                              'https://www.uthscsa.edu/sites/default/files/HRA%20Template.pdf',
                                              maxAgeCacheObject: const Duration(
                                                  days: 30), //duration of cache
                                              placeholder: (progress) =>
                                                  Scaffold(
                                                body: Center(
                                                    child: Text('$progress %')),
                                              ),
                                              errorWidget: (error) => Center(
                                                  child:
                                                      Text(error.toString())),
                                            )));
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.web),
                              title: const Text(
                                "HRA Assessment",
                                style: TextStyle(color: Colors.black),
                              ),
                              trailing: const Icon(Icons.arrow_forward_ios),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const PDF().cachedFromUrl(
                                              'https://stanfordhealthcare.org/content/dam/SHC/clinics/stanford-medicine-partners-castro-valley/docs/smp-medicare-annual-wellness-visit-health-assessment.pdf',
                                              maxAgeCacheObject: const Duration(
                                                  days: 30), //duration of cache
                                              placeholder: (progress) =>
                                                  Scaffold(
                                                body: Center(
                                                    child: Text(
                                                  '$progress %',
                                                )),
                                              ),
                                              errorWidget: (error) => Center(
                                                  child:
                                                      Text(error.toString())),
                                            )));
                              },
                            ),
                          ],
                        ),
                    ],
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
