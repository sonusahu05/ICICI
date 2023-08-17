import 'package:flutter/material.dart';

class QuestionnaireApp extends StatefulWidget {
  @override
  _QuestionnaireAppState createState() => _QuestionnaireAppState();
}

class _QuestionnaireAppState extends State<QuestionnaireApp> with SingleTickerProviderStateMixin {
  TabController? _tabController;

  // Define the questionnaire data model
  List<QuestionSection> _questionSections = [
    QuestionSection(
      sectionTitle: 'Section 1',
      questions: [
        Question(
          text: 'Question 1.1',
          options: ['Option 1', 'Option 2', 'Option 3'],
        ),
        Question(
          text: 'Question 1.2',
          options: ['Option 1', 'Option 2', 'Option 3'],
        ),
      ],
    ),
    QuestionSection(
      sectionTitle: 'Section 2',
      questions: [
        Question(
          text: 'Question 2.1',
          options: ['Option 1', 'Option 2', 'Option 3'],
        ),
        Question(
          text: 'Question 2.2',
          options: ['Option 1', 'Option 2', 'Option 3'],
        ),
      ],
    ),
    // Add more sections as needed
  ];

  List<List<String>> _selectedAnswers = [];

  @override
  void initState() {
    super.initState();
    _initializeSelectedAnswers();

    _tabController = TabController(length: _questionSections.length, vsync: this);
    _tabController!.addListener(_handleTabSelection);
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  void _initializeSelectedAnswers() {
    _selectedAnswers = List<List<String>>.filled(
      _questionSections.length,
      [],
      growable: true,
    );
    for (int i = 0; i < _questionSections.length; i++) {
      for (int j = 0; j < _questionSections[i].questions.length; j++) {
        _selectedAnswers[i].add('');
      }
    }
  }

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Questionnaire App'),
      ),
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            tabs: _questionSections.map((section) => Tab(text: section.sectionTitle)).toList(),
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return TabBarView(
                  controller: _tabController,
                  children: _questionSections.map((section) {
                    final sectionIndex = _questionSections.indexOf(section);
                    return ListView.builder(
                      itemCount: section.questions.length,
                      itemBuilder: (context, questionIndex) {
                        final question = section.questions[questionIndex];
                        final selectedAnswer = _selectedAnswers[sectionIndex][questionIndex];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Question ${sectionIndex + 1}.${questionIndex + 1}:',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              question.text,
                              style: TextStyle(fontSize: 14.0),
                            ),
                            SizedBox(height: 8.0),
                            for (int optionIndex = 0; optionIndex < question.options.length; optionIndex++)
                              RadioListTile<String>(
                                title: Text(question.options[optionIndex]),
                                value: question.options[optionIndex],
                                groupValue: selectedAnswer,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedAnswers[sectionIndex][questionIndex] = value!;
                                  });
                                },
                              ),
                            SizedBox(height: 16.0),
                          ],
                        );
                      },
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Questionnaire Results'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (int sectionIndex = 0; sectionIndex < _questionSections.length; sectionIndex++)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Section ${sectionIndex + 1}: ${_questionSections[sectionIndex].sectionTitle}',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          for (int questionIndex = 0;
                              questionIndex < _questionSections[sectionIndex].questions.length;
                              questionIndex++)
                            Text(
                              'Question ${sectionIndex + 1}.${questionIndex + 1}: ${_selectedAnswers[sectionIndex][questionIndex]}',
                            ),
                        ],
                      ),
                  ],
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Close'),
                  ),
                ],
              );
            },
          );
        },
        label: Text('Submit'),
        icon: Icon(Icons.check),
      ),
    );
  }
}

class QuestionSection {
  final String sectionTitle;
  final List<Question> questions;

  QuestionSection({required this.sectionTitle, required this.questions});
}

class Question {
  final String text;
  final List<String> options;

  Question({required this.text, required this.options});
}

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Questionnaire App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: QuestionnaireApp(),
//     );
//   }
// }
