import 'package:dyhra/constants/routes.dart';
import 'package:flutter/material.dart';

// class HealthRiskAssessmentApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Dynamic Health Risk Assessment',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: HealthRiskAssessmentForm(),
//     );
//   }
// }

class HealthRiskAssessmentForm extends StatefulWidget {
  @override
  _HealthRiskAssessmentFormState createState() =>
      _HealthRiskAssessmentFormState();
}

class _HealthRiskAssessmentFormState extends State<HealthRiskAssessmentForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  double bmi = 0.0;

  void calculateBMI() {
    double height = double.tryParse(heightController.text) ?? 0.0;
    double weight = double.tryParse(weightController.text) ?? 0.0;
    if (height > 0 && weight > 0) {
      double bmiValue = weight / (height * height);
      setState(() {
        bmi = bmiValue;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Health Risk Assessment'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Age (in years)'),
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return 'Please enter your age.';
                  }
                  return null;
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration:
                    InputDecoration(labelText: 'Waist Size (in inches)'),
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return 'Please enter your waist size.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: heightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Height (in meters)'),
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return 'Please enter your height.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: weightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Weight (in kg)'),
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return 'Please enter your weight.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    calculateBMI();
                  }
                },
                child: Text('Submit'),
              ),
              SizedBox(height: 16.0),
              Text(
                'BMI: ${bmi.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Directionality(
        textDirection: TextDirection.rtl,
        child: Row(
          
          children: [
      
            IconButton(
              icon: Icon(Icons.arrow_circle_right_outlined),
              onPressed: () {
                Navigator.pushNamed(context, ques3);
              },
            )
          ],
        ),
      ),
    );
  }
}
