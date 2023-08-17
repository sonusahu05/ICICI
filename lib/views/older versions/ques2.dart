import 'package:flutter/material.dart';

class QuestionnaireApp extends StatefulWidget {
  @override
  _QuestionnaireAppState createState() => _QuestionnaireAppState();
}

class _QuestionnaireAppState extends State<QuestionnaireApp> {
  final List<Question> _questions = [
    Question(
      text: 'Question 1',
      options: ['Option 1', 'Option 2', 'Option 3'],
    ),
    Question(
      text: 'Question 2',
      options: ['Option 1', 'Option 2', 'Option 3'],
    ),
    // Add more questions as needed
  ];

  final List<String> _selectedAnswers = [];

  @override
  void initState() {
    super.initState();
    _initializeSelectedAnswers();
  }

  void _initializeSelectedAnswers() {
    for (int i = 0; i < _questions.length; i++) {
      _selectedAnswers.add('');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Questionnaire App'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (int i = 0; i < _questions.length; i++)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Question ${i + 1}:',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    _questions[i].text,
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 8.0),
                  for (int j = 0; j < _questions[i].options.length; j++)
                    RadioListTile<String>(
                      title: Text(_questions[i].options[j]),
                      value: _questions[i].options[j],
                      groupValue: _selectedAnswers[i],
                      onChanged: (value) {
                        setState(() {
                          _selectedAnswers[i] = value!;
                        });
                      },
                    ),
                  SizedBox(height: 16.0),
                ],
              ),
            ElevatedButton(
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
                          Text('Answers:'),
                          for (int i = 0; i < _questions.length; i++)
                            Text(
                              '${_questions[i].text}: ${_selectedAnswers[i]}',
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
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

class Question {
  final String text;
  final List<String> options;

  Question({required this.text, required this.options});
}
