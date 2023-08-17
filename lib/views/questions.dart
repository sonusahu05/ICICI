import 'package:flutter/material.dart';
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Horizontal Scrollable Cards',
      home: HorizontalScrollableCardsScreen(),
    );
  }
}

class HorizontalScrollableCardsScreen extends StatefulWidget {
  @override
  _HorizontalScrollableCardsScreenState createState() =>
      _HorizontalScrollableCardsScreenState();
}

class _HorizontalScrollableCardsScreenState
    extends State<HorizontalScrollableCardsScreen> {
  List<Map<String, dynamic>> sectionsData = [];
  int currentSectionIndex = 0;
  PageController pageController = PageController();
  List<dynamic> selectedValues = [];

  @override
  void initState() {
    super.initState();
    String jsonData = '''{
      "sections": [
        {
          "title": "Section 1",
          "subtitle": "Subtitle 1",
          "questions": [
            {"question": "Question 1", "type": "radio", "options": ["Option 1", "Option 2", "Option 3"]}
          ]
        },
        {
          "title": "Section 2",
          "subtitle": "Subtitle 2",
          "questions": [
            {"question": "Question 2", "type": "slider", "min": 0, "max": 10},
            {"question": "Question 3", "type": "radio", "options": ["Option A", "Option B"]}
          ]
        }
      ]
    }''';
    Map<String, dynamic> data = json.decode(jsonData);
    sectionsData = List<Map<String, dynamic>>.from(data['sections']);

    // Initialize the selectedValues list with null for each question
    selectedValues = List.generate(sectionsData.length, (index) {
      return List.generate(
        sectionsData[index]['questions'].length,
        (innerIndex) => null,
      );
    });
  }

  void onPageChanged(int index) {
    setState(() {
      currentSectionIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Health Risk Assessment'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 30.0),
            child: Text(
              sectionsData[currentSectionIndex]['title'],
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Text(
              sectionsData[currentSectionIndex]['subtitle'],
              style: TextStyle(fontSize: 16.0, color: Colors.grey),
            ),
          ),
          Expanded(
            child: PageView.builder(
              controller: pageController,
              itemCount: sectionsData.length,
              itemBuilder: (context, index) {
                return HorizontalScrollableCards(
                  questionsData: sectionsData[index]['questions'],
                  selectedValue: selectedValues[currentSectionIndex],
                  onValueChanged: (value) {
                    setState(() {
                      selectedValues[currentSectionIndex] = value;
                    });
                  },
                );
              },
              onPageChanged: onPageChanged,
            ),
          ),
          NavigationBar(
            currentIndex: currentSectionIndex,
            totalPages: sectionsData.length,
            onNext: () {
              if (currentSectionIndex < sectionsData.length - 1) {
                if (areAllQuestionsAnswered()) {
                  pageController.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Attention'),
                        content: Text('Please answer all questions before proceeding.'),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              }
            },
            onPrev: () {
              if (currentSectionIndex > 0) {
                pageController.previousPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }
            },
          ),
        ],
      ),
    );
  }

bool areAllQuestionsAnswered() {
  for (var sectionData in sectionsData) {
    for (var question in sectionData['questions']) {
      if (selectedValues[sectionsData.indexOf(sectionData)] == null) {
        // If any question in the section is unanswered, return false
        return false;
      }
    }
  }
  return true; // If all questions in all sections are answered, return true
}
}




class HorizontalScrollableCards extends StatelessWidget {
  final List<dynamic> questionsData;
  final dynamic selectedValue;
  final void Function(dynamic) onValueChanged; // Added onValueChanged parameter

  HorizontalScrollableCards({
    required this.questionsData,
    required this.selectedValue,
    required this.onValueChanged, // Added onValueChanged as a required parameter
  });
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 450,
        padding: EdgeInsets.all(16.0),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: questionsData.length,
          itemBuilder: (context, index) {
            return CustomCard(
              questionData: questionsData[index],
              cardHeight: 150.0, // You can adjust the height here as needed
              selectedValue: selectedValue,
              onValueChanged: (value) {
                onValueChanged(value);
              },
            );
          },
        ),
      ),
    );
  }
}


class CustomCard extends StatefulWidget {
  final Map<String, dynamic> questionData;
  final double cardHeight;
  final dynamic selectedValue;
  final ValueChanged<dynamic> onValueChanged;

  CustomCard({
    required this.questionData,
    required this.cardHeight,
    required this.selectedValue,
    required this.onValueChanged,
  });

  @override
  _CustomCardState createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  @override
  Widget build(BuildContext context) {
    double blueAreaHeight = widget.cardHeight * 0.3;
    double paddingBetweenBlueAndText = 8.0;

    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: widget.cardHeight,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0),
                  ),
                  color: Colors.blue,
                ),
                height: blueAreaHeight,
                child: Center(
                  child: Text(
                    widget.questionData['question'],
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: blueAreaHeight + paddingBetweenBlueAndText, bottom: 8.0),
              child: widget.questionData['type'] == 'radio'
                  ? buildRadioOptions(widget.questionData['options'])
                  : buildSliderOption(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRadioOptions(List<dynamic> options) {
    return Column(
      children: options.map((option) {
        bool isSelected = widget.selectedValue == option;
        return Padding(
          padding: EdgeInsets.all(8.0), // Add padding around the border
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: isSelected ? Colors.orange : Colors.grey, // Change border color if selected
                width: 2.0,
              ),
            ),
            child: ListTile(
              leading: Radio(
                activeColor: Colors.orange, // Change radio color
                value: option,
                groupValue: widget.selectedValue,
                onChanged: (value) {
                  setState(() {
                    widget.onValueChanged(value);
                  });
                },
              ),
              title: GestureDetector(
                onTap: () {
                  setState(() {
                    widget.onValueChanged(option);
                  });
                },
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(option),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

Widget buildSliderOption() {
  double min = (widget.questionData['min'] ?? 0).toDouble();
  double max = (widget.questionData['max'] ?? 100).toDouble();

  // Convert the selectedValue to double if it is a string
  double currentValue = (widget.selectedValue is double)
      ? widget.selectedValue
      : (widget.selectedValue is String)
          ? double.tryParse(widget.selectedValue) ?? min // Use min if parsing fails
          : min;

  return Column(
    children: [
      Text("Min: $min"),
      Slider(
        thumbColor: Colors.orange,
        activeColor: Colors.orange,
        inactiveColor: Colors.amber,
        min: min,
        max: max,
        value: currentValue,
        onChanged: (value) {
          setState(() {
            //alue:currentValue.toInt();
            widget.onValueChanged(value);
          });
        },
      ),
      Text("Max: $max"),
      Text("Selected Value: ${widget.selectedValue ?? min}"),
    ],
  );
}

}

class NavigationBar extends StatelessWidget {
  final int currentIndex;
  final int totalPages;
  final VoidCallback? onNext;
  final VoidCallback? onPrev;

  NavigationBar({
    required this.currentIndex,
    required this.totalPages,
    this.onNext,
    this.onPrev,
  });

  @override
  Widget build(BuildContext context) {
    double progress = (currentIndex + 1) / totalPages;
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          LinearProgressIndicator(
            value: progress,
            color: Colors.green,
            backgroundColor: Colors.grey,
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Section ${currentIndex + 1} of $totalPages',
                style: TextStyle(fontSize: 16.0),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: onPrev,
                    icon: Icon(Icons.arrow_back),
                  ),
                  IconButton(
                    onPressed: onNext,
                    icon: Icon(Icons.arrow_forward),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
