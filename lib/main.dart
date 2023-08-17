import 'package:dyhra/constants/routes.dart';
import 'package:dyhra/views/basic_details.dart';
import 'package:dyhra/views/ques3.dart';
import 'package:dyhra/views/white_card.dart';
import 'package:flutter/material.dart';
import 'views/older versions/take_assessment.dart';
import 'views/older versions/body_profile.dart';
import 'views/report.dart';
import 'views/result.dart';
import 'views/questions.dart';

void main() {
  bool hasTakenAssessment =
      false; // Set to true if the user has submitted an assessment

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    showSemanticsDebugger: false,
    home: LandingPage(hasTakenAssessment: hasTakenAssessment),
    routes: {
      takeassessment: (context) => TakeAssessmentPage(),
      // pastreport: (context) => PastReportPage(),
      ques3: (context) => QuestionnaireApp(),
      // ques4:(context)=>MyApp(),
      bodyprofile: (context) => HealthRiskAssessmentForm(),
      // reportpage: (context) => HealthReportPage(),
      homescreen: (context) => MyWhiteCard(),
      personaldetail: (context) => PersonalDetailPage(),
      questionspage: (context) => HorizontalScrollableCardsScreen(),
    },
  ));
}

class LandingPage extends StatelessWidget {
  final bool
      hasTakenAssessment; // Flag to indicate if user has taken the assessment

  LandingPage({required this.hasTakenAssessment});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: hasTakenAssessment ? ReportPage() : const HealthReportPage(),
    );
  }
}
