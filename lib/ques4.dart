import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class Section {
  final String sectionTitle;
  final List<Question> questions;

  Section({required this.sectionTitle, required this.questions});
}

class Question {
  final String text;
  final List<String> options;
  final bool hasSlider;
  final double minSliderValue;
  final double maxSliderValue;
  double? selectedSliderValue;

  Question({
    required this.text,
    required this.options,
    this.hasSlider = false,
    this.minSliderValue = 0,
    this.maxSliderValue = 1,
    this.selectedSliderValue,
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late List<Section> _sections;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadQuestionnaireData();
  }

  Future<void> _loadQuestionnaireData() async {
    try {
      String jsonString = await rootBundle.loadString('../assets/dummy_data.json');
      Map<String, dynamic> jsonData = json.decode(jsonString);

      List<dynamic> sections = jsonData['sections'];

      List<Section> loadedSections = sections.map((sectionData) {
        String sectionTitle = sectionData['sectionTitle'];
        List<dynamic> questions = sectionData['questions'];

        List<Question> loadedQuestions = questions.map((questionData) {
          String questionText = questionData['text'];
          List<String> options = (questionData['options'] ?? []).cast<String>();

          bool hasSlider = questionData['hasSlider'] ?? false;
          double minSliderValue = questionData['minSliderValue'] ?? 0.0;
          double maxSliderValue = questionData['maxSliderValue'] ?? 1.0;

          return Question(
            text: questionText,
            options: options,
            hasSlider: hasSlider,
            minSliderValue: minSliderValue,
            maxSliderValue: maxSliderValue,
          );
        }).toList();

        return Section(
          sectionTitle: sectionTitle,
          questions: loadedQuestions,
        );
      }).toList();

      setState(() {
        _sections = loadedSections;
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading questionnaire data: $e');
    }
  }

  Widget _buildQuestion(Question question) {
    if (question.hasSlider) {
      return _buildSlider(question);
    } else {
      return _buildOptions(question);
    }
  }

  Widget _buildSlider(Question question) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(question.text),
        Slider(
          min: question.minSliderValue,
          max: question.maxSliderValue,
          value: question.selectedSliderValue ?? question.minSliderValue,
          onChanged: (value) {
            setState(() {
              question.selectedSliderValue = value;
            });
          },
        ),
      ],
    );
  }

Widget _buildOptions(Question question) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(question.text),
      Column(
        children: question.options.map((option) {
          return RadioListTile(
            title: Text(option),
            value: option,
            groupValue: question.selectedSliderValue,
            onChanged: (value) {
              setState(() {
                question.selectedSliderValue = double.tryParse(value.toString() ?? '');
              });
            },
          );
        }).toList(),
      ),
    ],
  );
}



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Questionnaire'),
        ),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: _sections.length,
                itemBuilder: (ctx, index) {
                  Section section = _sections[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          section.sectionTitle,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ...section.questions.map((question) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: _buildQuestion(question),
                        );
                      }).toList(),
                    ],
                  );
                },
              ),
      ),
    );
  }
}
