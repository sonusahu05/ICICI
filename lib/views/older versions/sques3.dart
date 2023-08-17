import 'dart:convert';
import 'package:dyhra/constants/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class QuestionnaireData {
  final List<Section> sections;

  QuestionnaireData({required this.sections});

  factory QuestionnaireData.fromJson(Map<String, dynamic> json) {
    final sections = json['sections'] as List<dynamic>;
    final parsedSections =
        sections.map((section) => Section.fromJson(section)).toList();
    return QuestionnaireData(sections: parsedSections);
  }
}

class Section {
  final String sectionTitle;
  final List<Question> questions;

  Section({required this.sectionTitle, required this.questions});

  factory Section.fromJson(Map<String, dynamic> json) {
    final questions = json['questions'] as List<dynamic>;
    final parsedQuestions =
        questions.map((question) => Question.fromJson(question)).toList();
    return Section(
        sectionTitle: json['sectionTitle'], questions: parsedQuestions);
  }
}

class Question {
  final String text;
  final List<String>? options;
  final bool hasSlider;
  final double? minSliderValue;
  final double? maxSliderValue;

  Question({
    required this.text,
    this.options,
    this.hasSlider = false,
    this.minSliderValue,
    this.maxSliderValue,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      text: json['text'],
      options:
          json['options'] != null ? List<String>.from(json['options']) : null,
      hasSlider: json['hasSlider'] ?? false,
      minSliderValue: json['minSliderValue'] != null
          ? json['minSliderValue'].toDouble()
          : null,
      maxSliderValue: json['maxSliderValue'] != null
          ? json['maxSliderValue'].toDouble()
          : null,
    );
  }
}

class QuestionnaireApp extends StatefulWidget {
  @override
  _QuestionnaireAppState createState() => _QuestionnaireAppState();
}

class _QuestionnaireAppState extends State<QuestionnaireApp> with TickerProviderStateMixin {
  late List<Section> sections;
  Map<String, dynamic>? _selectedAnswers;
  late TabController _tabController;
  int _currentTabIndex = 0;
  Color _indicatorColor = Color.fromARGB(255, 21, 49, 82);

  @override
  void initState() {
    super.initState();
    sections = []; // Initialize sections as an empty list
    _tabController = TabController(length: 0, vsync: this);
    _tabController.addListener(_handleTabSelection);
    loadQuestionnaireData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> loadQuestionnaireData() async {
    final String jsonString =
        await rootBundle.loadString('assets/dummy_data.json');
    final json = jsonDecode(jsonString);
    final questionnaireData = QuestionnaireData.fromJson(json);
    setState(() {
      sections = questionnaireData.sections;
      _selectedAnswers = {};
      _tabController = TabController(length: sections.length, vsync: this);
      _tabController.addListener(_handleTabSelection);
      // _tabController = TabController(length: sections.length, vsync: this);
      // _tabController.addListener(_handleTabSelection);
    });
  }

  void _handleTabSelection() {
    setState(() {
      _currentTabIndex = _tabController.index;
    });
  }

  bool areAllQuestionsAttempted() {
    for (final section in sections) {
      for (final question in section.questions) {
        if (!_selectedAnswers!.containsKey(question.text)) {
          return false;
        }
      }
    }
    return true;
  }

  void showAllQuestionsPrompt(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Attempt All Questions'),
        content: Text('Please attempt all questions before submitting.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  Widget buildQuestion(Question question) {
    return ListTile(
      title: Text(question.text),
      subtitle: question.options != null ? buildOptions(question) : null,
    );
  }

  Widget buildOptions(Question question) {
    return Column(
      children: question.options!.map((option) {
        return RadioListTile<String>(
          title: Text(option),
          value: option,
          groupValue: _selectedAnswers?[question.text],
          onChanged: (value) {
            setState(() {
              _selectedAnswers?[question.text] = value;
            });
          },
        );
      }).toList(),
    );
  }

Widget buildSliderQuestion(Question question) {
  double? selectedValue = _selectedAnswers?[question.text] ?? question.minSliderValue ?? 0.0;

  return Column(
    children: [
      ListTile(
        title: Text(question.text),
        subtitle: Slider(
          value: selectedValue!,
          min: question.minSliderValue ?? 0.0,
          max: question.maxSliderValue ?? 100.0,
          onChanged: (value) {
            setState(() {
              selectedValue = value.roundToDouble(); // Round the value to the nearest whole number
              _selectedAnswers?[question.text] = selectedValue;
            });
          },
        ),
      ),
      Text('Selected Value: $selectedValue'),
    ],
  );
}



  // Widget buildSliderQuestion(Question question) {
  //   return ListTile(
  //     title: Text(question.text),
  //     subtitle: Slider(
  //       value:
  //           _selectedAnswers?[question.text] ?? question.minSliderValue ?? 0.0,
  //       min: question.minSliderValue ?? 0.0,
  //       max: question.maxSliderValue ?? 100.0,
  //       onChanged: (value) {
  //         setState(() {
  //           _selectedAnswers?[question.text] = value;
  //         });
  //       },
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Questionnaire App'),
      ),
      body: sections == null
          ? Center(child: CircularProgressIndicator())
          : DefaultTabController(
              length: sections.length,
              child: Scaffold(
                appBar: TabBar(
                  controller: _tabController,
                  labelColor: Colors.black,
                  indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(
                      color: _indicatorColor,
                      width: 2.0,
                    ),
                  ),
                  // indicatorColor: Color.fromARGB(255, 21, 49, 82),
                  unselectedLabelColor: Color.fromARGB(255, 114, 124, 125),
                  tabs: sections
                      .map((section) => Tab(text: section.sectionTitle))
                      .toList(),
                ),
                body: TabBarView(
                  controller: _tabController,
                  children: sections.map((section) {
                    //fontColor:Colors.black;
                    indicatorColor:
                    Color.fromARGB(255, 21, 49, 82);
                    Color.fromARGB(255, 21, 49, 82);
                    final questions = section.questions;

                    return ListView.builder(
                      itemCount: questions.length,
                      itemBuilder: (context, index) {
                        final question = questions[index];

                        if (question.hasSlider) {
                          return buildSliderQuestion(question);
                        } else {
                          return buildQuestion(question);
                        }
                      },
                    );
                  }).toList(),
                ),
              ),
            ),
      floatingActionButton: _currentTabIndex == sections.length - 1
          ? FloatingActionButton(
              onPressed: () {
                if (areAllQuestionsAttempted()) {
                  Navigator.pushNamed(context, reportpage);
                  print(_selectedAnswers);
                } else {
                  showAllQuestionsPrompt(context);
                }
              },
              child: Icon(Icons.check),
              backgroundColor: Color.fromARGB(255, 21, 49, 82),
            )
          : null,
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: QuestionnaireApp(),
  ));
}
