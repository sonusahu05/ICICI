import 'dart:convert';

import 'package:dyhra/constants/routes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '/views/result.dart';



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PersonalDetailPage(),
    );
  }
}

class PersonalDetailPage extends StatefulWidget {
  @override
  _PersonalDetailPageState createState() => _PersonalDetailPageState();
}

class _PersonalDetailPageState extends State<PersonalDetailPage> {
  final _formKey = GlobalKey<FormState>();

  String selectedGender = '';
  // int selectedAge = 18;
  String selectedHeightFeet = '1'; // Default value for feet dropdown
  String selectedHeightInches = '0'; // Default value for inches dropdown
  String weight = '';
  String waistSize = '';
  String foodPreference = '';
  String selectedBloodGroup = 'A+';

  Future<void> sendDataToApi(String gender, String bloodGroup) async {
  final url =
      Uri.parse('https://dhra-api-test-service.onrender.com/basicDetails').replace(queryParameters: {"jsonString": "{\"gender\":\"$gender\",\"bloodGroup\":\"$bloodGroup\"}"});
  // final jsonString = jsonEncode({"jsonString": "{\"gender\":\"$gender\",\"bloodGroup\":\"$bloodGroup\"}"});
  // final jsonString = jsonEncode({
  //   "gender": gender,
  //   "bloodGroup": bloodGroup,
  // });
  // print(jsonString);

  try {
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      // body: jsonString,
    );

    if (response.statusCode == 200) {
      // Successfully sent data to the API
      print('Data sent successfully.');
    } else {
      // Error in the API response
      print('Failed to send data. Status code: ${response.statusCode}');
    }
  } catch (e) {
    // Error in making the API request
    print('Error: $e');
  }
}

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double buttonWidth =
        (screenWidth * 0.9 - (2 * screenWidth * 0.02)) / 3.5;

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Health Risk Assessment',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 0, 48, 91),
        ),
        body: Center(
            child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Container(
            padding: EdgeInsets.all(20.0),
            height: screenHeight * 0.8,
            width: screenWidth * 0.9,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 242, 206, 153).withOpacity(0.5),
                  blurRadius: 20.0,
                  spreadRadius: 10.0,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Title 1
                  Text(
                    'Tell us more about you',
                    style: GoogleFonts.lato(
                      fontSize: screenWidth * 0.06,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  // Title 2
                  Text(
                    'Let us know about yourself before starting!',
                    style: TextStyle(
                      fontSize: screenWidth * 0.035,
                      color: const Color.fromARGB(255, 113, 113, 113),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.04),
                  Expanded(
                    child: Form(
                      key: _formKey,
                      child: ListView(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: screenHeight * 0.03),
                          Text(
                            'What\'s your Gender?',
                            style: GoogleFonts.lato(
                              fontSize: screenWidth * 0.04,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(width: screenWidth * 0.02),
                                Expanded(
                                  child: SizedBox(
                                    width: screenWidth * 0.3,
                                    height: screenHeight * 0.05,
                                    child: outlinedButton('Male',
                                        isSelected: selectedGender == 'Male',
                                        onPressed: () {
                                      setState(() {
                                        selectedGender = 'Male';
                                      });
                                    }),
                                  ),
                                ),
                                SizedBox(width: screenWidth * 0.02),
                                Expanded(
                                  child: SizedBox(
                                    width: screenWidth * 0.3,
                                    height: screenHeight * 0.05,
                                    child: outlinedButton('Female',
                                        isSelected: selectedGender == 'Female',
                                        onPressed: () {
                                      setState(() {
                                        selectedGender = 'Female';
                                      });
                                    }),
                                  ),
                                ),
                                SizedBox(width: screenWidth * 0.02),
                                Expanded(
                                  child: SizedBox(
                                    width: screenWidth * 0.3,
                                    height: screenHeight * 0.05,
                                    child: outlinedButton('Other',
                                        isSelected: selectedGender == 'Other',
                                        onPressed: () {
                                      setState(() {
                                        selectedGender = 'Other';
                                      });
                                    }),
                                  ),
                                ),
                                SizedBox(width: screenWidth * 0.02),
                              ],
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.03),
                          // New Blood Group Selection
                          Text(
                            'What is your blood group?',
                            style: GoogleFonts.lato(
                              fontSize: screenWidth * 0.04,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          DropdownButtonFormField<String>(
                            value: selectedBloodGroup,
                            onChanged: (newValue) {
                              setState(() {
                                selectedBloodGroup = newValue!;
                              });
                            },
                            items: [
                              'A+',
                              'A-',
                              'B+',
                              'B-',
                              'AB+',
                              'AB-',
                              'O+',
                              'O-',
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            decoration: InputDecoration(
                              labelText: 'Choose Blood Group',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          // SizedBox(height: screenHeight * 0.03),
                          // Text(
                          //   'What is your age?',
                          //   style: GoogleFonts.lato(
                          //     fontSize: screenWidth * 0.04,
                          //     color: Colors.black,
                          //     fontWeight: FontWeight.bold,
                          //   ),
                          // ),
                          // SizedBox(height: screenHeight * 0.02),
                          // SingleChildScrollView(
                          //   scrollDirection: Axis.horizontal,
                          //   child: Row(
                          //     children: List.generate(83, (index) {
                          //       int age = index + 18;
                          //       return Padding(
                          //         padding:
                          //             const EdgeInsets.symmetric(horizontal: 4.0),
                          //         child: outlinedButton(age.toString(),
                          //             isSelected: selectedAge == age,
                          //             onPressed: () {
                          //           setState(() {
                          //             selectedAge = age;
                          //           });
                          //         }),
                          //       );
                          //     }),
                          //   ),
                          // ),
                          SizedBox(height: screenHeight * 0.03),
                          Text(
                            'Your height',
                            style: GoogleFonts.lato(
                              fontSize: screenWidth * 0.04,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.02),

                          Row(
                            children: [
                              Expanded(
                                child: DropdownButtonFormField<String>(
                                  value: selectedHeightFeet,
                                  onChanged: (newValue) {
                                    setState(() {
                                      selectedHeightFeet = newValue!;
                                    });
                                  },
                                  items: List.generate(15, (index) {
                                    int feetValue = index + 1;
                                    return DropdownMenuItem<String>(
                                      value: feetValue.toString(),
                                      child: Text(feetValue.toString() + ' ft'),
                                    );
                                  }),
                                  decoration:
                                      InputDecoration(labelText: 'Feet'),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please select feet';
                                    }
                                    double feetValue =
                                        double.tryParse(value) ?? 0.0;
                                    if (feetValue < 1.0 || feetValue > 15.0) {
                                      return 'Invalid feet';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(width: screenWidth * 0.02),
                              Expanded(
                                child: DropdownButtonFormField<String>(
                                  value: selectedHeightInches,
                                  onChanged: (newValue) {
                                    setState(() {
                                      selectedHeightInches = newValue!;
                                    });
                                  },
                                  items: List.generate(12, (index) {
                                    int inchesValue = index;
                                    return DropdownMenuItem<String>(
                                      value: inchesValue.toString(),
                                      child:
                                          Text(inchesValue.toString() + ' in'),
                                    );
                                  }),
                                  decoration:
                                      InputDecoration(labelText: 'Inches'),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please select inches';
                                    }
                                    double inchesValue =
                                        double.tryParse(value) ?? 0.0;
                                    if (inchesValue < 0.0 ||
                                        inchesValue > 11.0) {
                                      return 'Invalid inches';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: screenHeight * 0.03),
                          Text(
                            'Your weight',
                            style: GoogleFonts.lato(
                              fontSize: screenWidth * 0.04,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Weight in kg',
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 1, color: Colors.grey),
                              ),
                            ),
                            onChanged: (value) {
                              weight = value;
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter weight';
                              }
                              int weightValue = int.tryParse(value) ?? 0;
                              if (weightValue < 5 || weightValue > 120) {
                                return 'Invalid weight';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: screenHeight * 0.03),
                          Text(
                            'Your waist size',
                            style: GoogleFonts.lato(
                              fontSize: screenWidth * 0.04,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Waist Size in inches',
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 1, color: Colors.grey),
                              ),
                            ),
                            onChanged: (value) {
                              waistSize = value;
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter waist size';
                              }
                              double waistValue = double.tryParse(value) ?? 0.0;
                              if (waistValue < 10.0 || waistValue > 60.0) {
                                return 'Please enter waist size in the range (10 to 60 inches)';
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: screenHeight * 0.03),
                          Text(
                            'Tell us your food preference',
                            style: GoogleFonts.lato(
                              fontSize: 16.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.02),

                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Flexible(
                                  fit: FlexFit.tight,
                                  child: outlinedButton('Veg',
                                      isSelected: foodPreference == 'Veg',
                                      onPressed: () {
                                    setState(() {
                                      foodPreference = 'Veg';
                                    });
                                  }),
                                ),
                                SizedBox(width: screenWidth * 0.02),
                                Flexible(
                                  fit: FlexFit.tight,
                                  child: outlinedButton('Non-Veg',
                                      isSelected: foodPreference == 'Non-Veg',
                                      onPressed: () {
                                    setState(() {
                                      foodPreference = 'Non-Veg';
                                    });
                                  }),
                                ),
                                SizedBox(width: screenWidth * 0.02),
                                Flexible(
                                  fit: FlexFit.tight,
                                  child: outlinedButton('Vegan',
                                      isSelected: foodPreference == 'Vegan',
                                      onPressed: () {
                                    setState(() {
                                      foodPreference = 'Vegan';
                                    });
                                  }),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: screenHeight * 0.05),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  sendDataToApi(
                                      selectedGender, selectedBloodGroup);
                                  // Navigator.pushNamed(context, reportpage);
                                  Navigator.pushNamed(context, questionspage);
                                  
                                  // Form is valid, process the data
                                  // Add logic to save the data and continue.
                                } else {
                                  // Form is not valid, show error messages
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepOrange,
                                minimumSize:
                                    Size(double.infinity, screenHeight * 0.07),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              child: Text(
                                'Save & Continue',
                                style: GoogleFonts.lato(
                                  fontSize: screenWidth * 0.045,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
          ),
        )));
  }

  Widget outlinedButton(String text,
      {bool isSelected = false, VoidCallback? onPressed}) {
    return OutlinedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(
          isSelected ? Colors.deepOrange[50]! : Colors.transparent,
        ),
        side: MaterialStateProperty.all<BorderSide>(
          isSelected
              ? BorderSide(color: Colors.deepOrange)
              : BorderSide(color: Colors.grey),
        ),
        overlayColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.pressed)) {
            return Colors.deepOrange[100]!;
          }
          return Colors.transparent;
        }),
      ),
      child: Text(
        text,
        style: GoogleFonts.lato(
          fontSize: 16.0,
          color: Colors.black,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}


