import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class Section {
  final String sectionTitle;
  final List<Question> questions;

  Section({required this.sectionTitle, required this.questions});

  factory Section.fromJson(Map<String, dynamic> json) {
    final List<dynamic> questionsData = json['questions'];
    final questions = questionsData.map((question) => Question.fromJson(question)).toList();
    return Section(
      sectionTitle: json['sectionTitle'],
      questions: questions,
    );
  }
}

class Question {
  final String text;
  final List<String>? options;
  final bool hasSlider;
  final double? minSliderValue;
  final double? maxSliderValue;
  String? selectedOption;
  double? selectedSliderValue;

  Question({
    required this.text,
    this.options,
    this.hasSlider = false,
    this.minSliderValue,
    this.maxSliderValue,
    this.selectedOption,
    this.selectedSliderValue,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      text: json['text'],
      options: json['options'] != null ? List<String>.from(json['options']) : null,
      hasSlider: json['hasSlider'] ?? false,
      minSliderValue: json['minSliderValue'] != null ? json['minSliderValue'].toDouble() : null,
      maxSliderValue: json['maxSliderValue'] != null ? json['maxSliderValue'].toDouble() : null,
    );
  }
}

class QuestionnaireApp extends StatefulWidget {
  @override
  _QuestionnaireAppState createState() => _QuestionnaireAppState();
}

class _QuestionnaireAppState extends State<QuestionnaireApp> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Section> _sections = [];

  @override
  void initState() {
    super.initState();
    _loadSections();
    _tabController = TabController(length: _sections.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadSections() async {
    try {
      final jsonString = await rootBundle.loadString('assets/dummy_data.json');
      final jsonData = json.decode(jsonString);
      final List<dynamic> sectionsData = jsonData['sections'];
      _sections = sectionsData.map((section) => Section.fromJson(section)).toList();
    } catch (e) {
      print('Error loading questionnaire data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Questionnaire'),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _sections.map((section) => _buildSectionWidget(section)).toList(),
      ),
      bottomNavigationBar: Material(
        color: Colors.blue,
        child: TabBar(
          controller: _tabController,
          tabs: _sections.map((section) => Tab(text: section.sectionTitle)).toList(),
        ),
      ),
    );
  }

  Widget _buildSectionWidget(Section section) {
    return ListView.builder(
      itemCount: section.questions.length,
      itemBuilder: (context, index) {
        final question = section.questions[index];
        return ListTile(
          title: Text(question.text),
          subtitle: question.options != null
              ? DropdownButton<String>(
                  value: question.selectedOption,
                  items: question.options!
                      .map((option) => DropdownMenuItem<String>(
                            value: option,
                            child: Text(option),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      question.selectedOption = value;
                    });
                  },
                )
              : question.hasSlider
                  ? Slider(
                      value: question.selectedSliderValue ?? question.minSliderValue!,
                      min: question.minSliderValue!,
                      max: question.maxSliderValue!,
                      divisions: ((question.maxSliderValue! - question.minSliderValue!) / 1).toInt(),
                      onChanged: (value) {
                        setState(() {
                          question.selectedSliderValue = value;
                        });
                      },
                    )
                  : null,
        );
      },
    );
  }
}
