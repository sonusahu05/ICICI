// import 'package:flutter/material.dart';

// class QuestionnaireApp extends StatefulWidget {
//   @override
//   _QuestionnaireAppState createState() => _QuestionnaireAppState();
// }

// class _QuestionnaireAppState extends State<QuestionnaireApp> {
//   // Define the questionnaire data model
//   List<Question> _questions = [
//     Question(
//       text: 'Question 1',
//       options: ['Option 1', 'Option 2', 'Option 3'],
//     ),
//     Question(
//       text: 'Question 2',
//       options: ['Option 1', 'Option 2', 'Option 3'],
//     ),
//     // Add more questions as needed
//   ];

//   int _currentQuestionIndex = 0;
//   List<String> _selectedAnswers = [];

//   // void _selectAnswer(String answer) {
//   //   setState(() {
//   //     _selectedAnswers.add(answer);
//   //     if (_currentQuestionIndex < _questions.length - 1) {
//   //       _currentQuestionIndex++;
//   //     }
//   //   });
//   // }

//   void _selectAnswer(String? answer) {
//   setState(() {
//     if (answer != null) {
//       _selectedAnswers.add(answer);
//     }
//     if (_currentQuestionIndex < _questions.length - 1) {
//       _currentQuestionIndex++;
//     }
//   });
// }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Questionnaire'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Text(
//               'Question ${_currentQuestionIndex + 1}:',
//               style: TextStyle(
//                 fontSize: 18.0,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 8.0),
//             Text(
//               _questions[_currentQuestionIndex].text,
//               style: TextStyle(fontSize: 16.0),
//             ),
//             SizedBox(height: 16.0),
//             ListView.builder(
//               shrinkWrap: true,
//               itemCount: _questions[_currentQuestionIndex].options.length,
//               itemBuilder: (context, index) {
//                 String option = _questions[_currentQuestionIndex].options[index];
//                 return ListTile(
//                   title: Text(option),
//                   leading: Radio(
//                     value: option,
//                     groupValue: _selectedAnswers.length > _currentQuestionIndex
//                         ? _selectedAnswers[_currentQuestionIndex]
//                         : null,
//                     onChanged: _selectAnswer,
//                   ),
//                 );
//               },
//             ),
//             SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: () {
//                 if (_currentQuestionIndex < _questions.length - 1) {
//                   _selectAnswer(null);
//                 } else {
//                   // Display results
//                   showDialog(
//                     context: context,
//                     builder: (context) {
//                       return AlertDialog(
//                         title: Text('Questionnaire Results'),
//                         content: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text('Answers:'),
//                             for (int i = 0; i < _questions.length; i++)
//                               Text(
//                                 '${_questions[i].text}: ${_selectedAnswers[i]}',
//                               ),
//                           ],
//                         ),
//                         actions: [
//                           ElevatedButton(
//                             onPressed: () {
//                               Navigator.of(context).pop();
//                             },
//                             child: Text('Close'),
//                           ),
//                         ],
//                       );
//                     },
//                   );
//                 }
//               },
//               child: Text(
//                 _currentQuestionIndex < _questions.length - 1
//                     ? 'Next Question'
//                     : 'Submit',
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class Question {
//   final String text;
//   final List<String> options;

//   Question({required this.text, required this.options});
// }
// import 'package:flutter/material.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_charts/flutter_charts.dart';

// // import 'package:charts_flutter/flutter.dart' as charts;

// class ReportPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('REPORT'),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             // Trend Graph
//             Container(
//               height: 200,
//               child: AnimatedGraph(),
//             ),

//             // Summary Section
//             Container(
//               margin: EdgeInsets.all(16),
//               child: Text(
//                 'Summary',
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//               ),
//             ),

//             // BMI Numerical Value with Meter Indicator
//             Container(
//               margin: EdgeInsets.all(16),
//               child: Row(
//                 children: [
//                   Text(
//                     'BMI:',
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(width: 8),
//                   AnimatedMeterIndicator(value: 25),
//                 ],
//               ),
//             ),

//             // Waist to Hip Ratio Numerical Value with Meter Indicator
//             Container(
//               margin: EdgeInsets.all(16),
//               child: Row(
//                 children: [
//                   Text(
//                     'Waist to Hip Ratio:',
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(width: 8),
//                   AnimatedMeterIndicator(value: 0.8),
//                 ],
//               ),
//             ),

//             // Wellness Score Numerical Value
//             Container(
//               margin: EdgeInsets.all(16),
//               child: Row(
//                 children: [
//                   Text(
//                     'Wellness Score:',
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(width: 8),
//                   Text(
//                     '80',
//                     style: TextStyle(fontSize: 18),
//                   ),
//                 ],
//               ),
//             ),

//             // Nutrition Index Numerical Value
//             Container(
//               margin: EdgeInsets.all(16),
//               child: Row(
//                 children: [
//                   Text(
//                     'Nutrition Index:',
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(width: 8),
//                   Text(
//                     '75',
//                     style: TextStyle(fontSize: 18),
//                   ),
//                 ],
//               ),
//             ),

//             // Lifestyle Index Numerical Value
//             Container(
//               margin: EdgeInsets.all(16),
//               child: Row(
//                 children: [
//                   Text(
//                     'Lifestyle Index:',
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(width: 8),
//                   Text(
//                     '90',
//                     style: TextStyle(fontSize: 18),
//                   ),
//                 ],
//               ),
//             ),

//             // Stress Index Numerical Value
//             Container(
//               margin: EdgeInsets.all(16),
//               child: Row(
//                 children: [
//                   Text(
//                     'Stress Index:',
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(width: 8),
//                   Text(
//                     '60',
//                     style: TextStyle(fontSize: 18),
//                   ),
//                 ],
//               ),
//             ),

//             // Wellbeing Index Numerical Value
//             Container(
//               margin: EdgeInsets.all(16),
//               child: Row(
//                 children: [
//                   Text(
//                     'Wellbeing Index:',
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(width: 8),
//                   Text(
//                     '85',
//                     style: TextStyle(fontSize: 18),
//                   ),
//                 ],
//               ),
//             ),

//             // Health Feedback Section
//             Container(
//               margin: EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Health Feedback:',
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 8),
//                   BulletPoint(text: 'Maintain a balanced diet.'),
//                   BulletPoint(text: 'Engage in regular physical activity.'),
//                   BulletPoint(text: 'Manage stress effectively.'),
//                 ],
//               ),
//             ),

//             // Source Citation Button
//             Container(
//               margin: EdgeInsets.all(16),
//               child: ElevatedButton(
//                 onPressed: () {
//                   // TODO: Implement button action
//                 },
//                 child: Text('Source Citation'),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class AnimatedGraph extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // TODO: Implement trend graph with 15 entries on x-axis
//     // Use charts_flutter package to create the graph
//     // You can refer to the package documentation for more details: https://pub.dev/packages/charts_flutter

//     return Container(
//       // Placeholder for the graph
//       color: Colors.grey[300],
//     );
//   }
// }

// class AnimatedMeterIndicator extends StatefulWidget {
//   final double value;

//   const AnimatedMeterIndicator({required this.value});

//   @override
//   _AnimatedMeterIndicatorState createState() => _AnimatedMeterIndicatorState();
// }

// class _AnimatedMeterIndicatorState extends State<AnimatedMeterIndicator> with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _animation;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(duration: const Duration(milliseconds: 500), vsync: this);
//     _animation = Tween<double>(begin: 0, end: widget.value).animate(_controller);
//     _controller.forward();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: _animation,
//       builder: (BuildContext context, Widget? child) {
//         return Container(
//           width: 100,
//           height: 20,
//           decoration: BoxDecoration(
//             color: Colors.blue,
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: FractionallySizedBox(
//             alignment: Alignment.centerLeft,
//             widthFactor: _animation.value,
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// class BulletPoint extends StatelessWidget {
//   final String text;

//   const BulletPoint({required this.text});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         SizedBox(
//           width: 8,
//           height: 8,
//           child: DecoratedBox(
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: Colors.black,
//             ),
//           ),
//         ),
//         SizedBox(width: 8),
//         Expanded(
//           child: Text(
//             text,
//             style: TextStyle(fontSize: 16),
//           ),
//         ),
//       ],
//     );
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: ReportPage(),
//   ));
// }