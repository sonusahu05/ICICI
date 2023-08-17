// import 'package:flutter/material.dart';

// class MyWhiteCard extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     double screenHeight = MediaQuery.of(context).size.height;
//     double circleHeight = screenHeight * 0.33; // 30% of the card's height

//     return Center(
//       child: Container(
//         width: MediaQuery.of(context).size.width * 0.95, // 80% of the screen width
//         height: screenHeight * 0.85, // 80% of the screen height
//         child: Card(
//           color: Colors.white,
//           elevation: 4.0,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(15.0),
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               ClipRRect(
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(15.0),
//                   topRight: Radius.circular(15.0),
//                 ),
//                 child: Container(
//                   width: double.infinity,
//                   height: circleHeight, // Height of the blue circle
//                   color: Colors.white,
//                   child: Stack(
//                     children: [
//                       Center(
//                         child: Container(
//                           width: circleHeight * 0.65, // Adjust the size of the blue circle
//                           height: circleHeight * 0.65, // Adjust the size of the blue circle
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: Color.fromARGB(255, 73, 176, 126),
//                           ),
//                         ),
//                       ),
//                       Align(
//                         alignment: Alignment.bottomCenter,
//                         child: Container(
//                           padding:EdgeInsets.all(3),
//                           width: 250,
//                           height: 40, // Adjust the height of the text box
//                           color: Color.fromARGB(50, 255, 102, 0), // Transparent orange background
//                           child: Center(
//                             child: Text(
//                               'No past assesment record found!',
//                               style: TextStyle(color: Colors.orange),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Divider(
//                 height: 20,
//                 thickness: 1,
//                 color: Color.fromARGB(255, 226, 225, 225), // Use default grey color for the Divider
//                 indent: 16,
//                 endIndent: 16,
//               ),
//               Padding(
//                 padding: EdgeInsets.only(right: 140.0, top: 3),
//                 child: Text(
//                   'Instructions',
//                   style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold),
//                 ),
//               ),
//               SizedBox(height: 16.0),
//               Expanded(
//                 child: ListView(
//                   padding: EdgeInsets.symmetric(horizontal: 16.0),
//                   shrinkWrap: true,
// children: [
//   ListTileTheme(
//     dense: true, // Remove space between bullets and text
//     contentPadding: EdgeInsets.only(left: 0.0, right: 8.0),
//     child: ListTile(
//       leading: Icon(Icons.send, color: Color.fromARGB(255, 241, 85, 1), size: 16),
//       horizontalTitleGap: -10.0,
//       title: Text(
//         'It consists of 4 sets of questions: Nutrition, Lifestyle, Stress, Emotional and Mental Health',
//         style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
//       ),
//     ),
//   ),
//   ListTileTheme(
//     dense: true, // Remove space between bullets and text
//     contentPadding: EdgeInsets.zero,
//     child: ListTile(
//       leading: Icon(Icons.send, color: Color.fromARGB(255, 241, 85, 1), size: 16),
//       horizontalTitleGap: -10.0,
//       title: Text(
//         'All questions are compulsory',
//         style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
//       ),
//     ),
//   ),
//   ListTileTheme(
//     dense: true, // Remove space between bullets and text
//     contentPadding: EdgeInsets.zero,
//     child: ListTile(
//       leading: Icon(Icons.send, color: Color.fromARGB(255, 241, 85, 1), size: 16),
//       horizontalTitleGap: -10.0,
//       title: Text(
//         'You need to answer all questions in a particular section before moving on to the next section',
//         style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
//       ),
//     ),
//   ),
//   ListTileTheme(
//     dense: true, // Remove space between bullets and text
//     contentPadding: EdgeInsets.zero,
//     child: ListTile(
//       leading: Icon(Icons.send, color: Color.fromARGB(255, 241, 85, 1), size: 16),
//       horizontalTitleGap: -10.0,
//       title: Text(
//         'After answering all the questions, you can toggle between the sections using the "Previous" and "Next" buttons provided at the bottom of the screen',
//         style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
//       ),
//     ),
//   ),
//   ListTileTheme(
//     dense: true, // Remove space between bullets and text
//     contentPadding: EdgeInsets.zero,
//     child: ListTile(
//       leading: Icon(Icons.send, color: Color.fromARGB(255, 241, 85, 1), size: 16),
//       horizontalTitleGap: -10.0,
//       title: Text(
//         'After answering all the questions, click on the "Submit" button to generate the HRA report',
//         style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
//       ),
//     ),
//   ),
//   // Add more ListTiles for additional bullet points
// ],
//                 ),
//               ),
//               FractionallySizedBox(
//                 widthFactor: 0.9,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     // Add button functionality here
//                   },
//                   style: ElevatedButton.styleFrom(
//                     minimumSize: Size(0.9, 50.0), // Increase the button's height to 50.0
//                     primary: Color.fromARGB(255, 241, 85, 1),
//                   ),
//                   child: Text(
//                     'Take Assessment',
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 16.0),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

///Original till here
///
///
///
///v2 from here

// import 'package:flutter/material.dart';

// class MyWhiteCard extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     double screenHeight = MediaQuery.of(context).size.height;
//     double circleHeight = screenHeight * 0.33; // 30% of the card's height
//     double circlePadding = 20.0; // Adjust the top padding of the circle

//     return Center(
//       child: Container(
//         width: MediaQuery.of(context).size.width * 0.95, // 80% of the screen width
//         height: screenHeight * 0.85, // 80% of the screen height
//         child: Card(
//           color: Colors.white,
//           elevation: 4.0,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(15.0),
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               ClipRRect(
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(15.0),
//                   topRight: Radius.circular(15.0),
//                 ),
//                 child: Container(
//                   width: double.infinity,
//                   height: circleHeight + circlePadding, // Height of the blue circle with padding
//                   color: Colors.white,
//                   child: Stack(
//                     children: [
//                       Positioned(
//                         top: circlePadding / 2, // Adjust the top padding of the circle
//                         left: (MediaQuery.of(context).size.width * 0.95) / 2 - circleHeight * 0.65 / 2, // Center the circle horizontally
//                         child: Container(
//                           width: circleHeight * 0.65, // Adjust the size of the blue circle
//                           height: circleHeight * 0.65, // Adjust the size of the blue circle
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: Color.fromARGB(255, 73, 176, 126),
//                           ),
//                         ),
//                       ),
//                       Align(
//                         alignment: Alignment.bottomCenter,
//                         child: Container(
//                           padding: EdgeInsets.all(3),
//                           width: 250,
//                           height: 40, // Adjust the height of the text box
//                           color: Color.fromARGB(50, 255, 102, 0), // Transparent orange background
//                           child: Center(
//                             child: Text(
//                               'No past assessment record found!',
//                               style: TextStyle(color: Colors.orange),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Divider(
//                 height: 20,
//                 thickness: 1,
//                 color: Color.fromARGB(255, 226, 225, 225), // Use default grey color for the Divider
//                 indent: 16,
//                 endIndent: 16,
//               ),
//               Padding(
//                 padding: EdgeInsets.only(right: 140.0, top: 3),
//                 child: Text(
//                   'Instructions',
//                   style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold),
//                 ),
//               ),
//               SizedBox(height: 16.0),
//               Expanded(
//                 child: ListView(
//                   padding: EdgeInsets.symmetric(horizontal: 16.0),
//                   shrinkWrap: true,
//               children: [
//                     ListTileTheme(
//                       dense: true, // Remove space between bullets and text
//                       contentPadding: EdgeInsets.only(left: 0.0, right: 8.0),
//                       child: ListTile(
//                         leading: Icon(Icons.send, color: Color.fromARGB(255, 241, 85, 1), size: 16),
//                         horizontalTitleGap: -10.0,
//                         title: Text(
//                           'It consists of 4 sets of questions: Nutrition, Lifestyle, Stress, Emotional and Mental Health',
//                           style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
//                         ),
//                       ),
//                     ),
//                     ListTileTheme(
//                       dense: true, // Remove space between bullets and text
//                       contentPadding: EdgeInsets.zero,
//                       child: ListTile(
//                         leading: Icon(Icons.send, color: Color.fromARGB(255, 241, 85, 1), size: 16),
//                         horizontalTitleGap: -10.0,
//                         title: Text(
//                           'All questions are compulsory',
//                           style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
//                         ),
//                       ),
//                     ),
//                     ListTileTheme(
//                       dense: true, // Remove space between bullets and text
//                       contentPadding: EdgeInsets.zero,
//                       child: ListTile(
//                         leading: Icon(Icons.send, color: Color.fromARGB(255, 241, 85, 1), size: 16),
//                         horizontalTitleGap: -10.0,
//                         title: Text(
//                           'You need to answer all questions in a particular section before moving on to the next section',
//                           style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
//                         ),
//                       ),
//                     ),
//                     ListTileTheme(
//                       dense: true, // Remove space between bullets and text
//                       contentPadding: EdgeInsets.zero,
//                       child: ListTile(
//                         leading: Icon(Icons.send, color: Color.fromARGB(255, 241, 85, 1), size: 16),
//                         horizontalTitleGap: -10.0,
//                         title: Text(
//                           'After answering all the questions, you can toggle between the sections using the "Previous" and "Next" buttons provided at the bottom of the screen',
//                           style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
//                         ),
//                       ),
//                     ),
//                     ListTileTheme(
//                       dense: true, // Remove space between bullets and text
//                       contentPadding: EdgeInsets.zero,
//                       child: ListTile(
//                         leading: Icon(Icons.send, color: Color.fromARGB(255, 241, 85, 1), size: 16),
//                         horizontalTitleGap: -10.0,
//                         title: Text(
//                           'After answering all the questions, click on the "Submit" button to generate the HRA report',
//                           style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
//                         ),
//                       ),
//                     ),
//                     // Add more ListTiles for additional bullet points
//                   ],
//                 ),
//               ),
//               FractionallySizedBox(
//                 widthFactor: 0.9,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     // Add button functionality here
//                   },
//                   style: ElevatedButton.styleFrom(
//                     minimumSize: Size(0.9, 50.0), // Increase the button's height to 50.0
//                     primary: Color.fromARGB(255, 241, 85, 1),
//                   ),
//                   child: Text(
//                     'Take Assessment',
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 16.0),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
/// v2 till here
///
///
///
///
/// v3 from here
//

import 'package:dyhra/constants/routes.dart';
import 'package:flutter/material.dart';
import 'questions.dart';
import 'basic_details.dart';


class MyWhiteCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double circleHeight = screenHeight * 0.33; // 30% of the card's height
    double circlePadding = 2.0; // Adjust the top padding of the circle
    void _openHorizontalScrollableCards(BuildContext context) {
      Navigator.pushNamed(
        context, personaldetail
        // MaterialPageRoute(
        //   builder: (context) => HorizontalScrollableCardsScreen(),
        // ),
      );
    }

    void _showBottomSheet() {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: screenHeight * 0.41,
            width: screenWidth * 0.95, // 95% of the screen width
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Disclaimer',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'The health risk assesment provided is generated through algorithmic analysis based on medical studies. It does not involve direct medical consultation with healthcare professionals. The information provided should not be considered a substitute for personalized medical advice, diagnosis or treatment. It is recommended to consult qualified healthcare providers for accurate guidance regarding  your health.',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 16),
                OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, personaldetail); // Close the BottomSheet
                    _openHorizontalScrollableCards(context);
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Color.fromARGB(255, 241, 85, 1)),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    primary: Colors.white,
                    //backgroundColor:Color.white,
                  ),
                  child: Text(
                    'Ok',
                    style: TextStyle(color: Color.fromARGB(255, 241, 85, 1)),
                  ),
                ),
                SizedBox(height: 16),
              ],
            ),
          );
        },
      );
    }

    return Center(
      child: Container(
        width:
            MediaQuery.of(context).size.width * 0.95, // 95% of the screen width
        height: screenHeight * 0.85, // 85% of the screen height
        child: Card(
          color: Colors.white,
          elevation: 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                ),
                child: Container(
                  width: double.infinity,
                  height: circleHeight +
                      circlePadding, // Height of the blue circle with padding
                  color: Colors.white,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 25, // Adjust the top padding of the circle
                        left: (MediaQuery.of(context).size.width * 0.95) / 2 -
                            circleHeight *
                                0.65 /
                                2, // Center the circle horizontally
                        child: Container(
                          width: circleHeight *
                              0.65, // Adjust the size of the blue circle
                          height: circleHeight *
                              0.65, // Adjust the size of the blue circle
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(255, 73, 176, 126),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          padding: EdgeInsets.all(3),
                          width: 250,
                          height: 38, // Adjust the height of the text box
                          color: Color.fromARGB(
                              50, 255, 102, 0), // Transparent orange background
                          child: Center(
                            child: Text(
                              'No past assessment record found!',
                              style: TextStyle(color: Colors.orange),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                height: 20,
                thickness: 1,
                color: Color.fromARGB(255, 226, 225,
                    225), // Use default grey color for the Divider
                indent: 16,
                endIndent: 16,
              ),
              Padding(
                padding: EdgeInsets.only(right: 140.0, top: 3),
                child: Text(
                  'Instructions',
                  style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 16.0),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  shrinkWrap: true,
                  children: [
                    ListTileTheme(
                      dense: true, // Remove space between bullets and text
                      contentPadding: EdgeInsets.only(left: 0.0, right: 8.0),
                      child: ListTile(
                        leading: Icon(Icons.send,
                            color: Color.fromARGB(255, 241, 85, 1), size: 16),
                        horizontalTitleGap: -10.0,
                        title: Text(
                          'It consists of 4 sets of questions: Nutrition, Lifestyle, Stress, Emotional and Mental Health',
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                    ListTileTheme(
                      dense: true, // Remove space between bullets and text
                      contentPadding: EdgeInsets.zero,
                      child: ListTile(
                        leading: Icon(Icons.send,
                            color: Color.fromARGB(255, 241, 85, 1), size: 16),
                        horizontalTitleGap: -10.0,
                        title: Text(
                          'All questions are compulsory',
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                    ListTileTheme(
                      dense: true, // Remove space between bullets and text
                      contentPadding: EdgeInsets.zero,
                      child: ListTile(
                        leading: Icon(Icons.send,
                            color: Color.fromARGB(255, 241, 85, 1), size: 16),
                        horizontalTitleGap: -10.0,
                        title: Text(
                          'You need to answer all questions in a particular section before moving on to the next section',
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                    ListTileTheme(
                      dense: true, // Remove space between bullets and text
                      contentPadding: EdgeInsets.zero,
                      child: ListTile(
                        leading: Icon(Icons.send,
                            color: Color.fromARGB(255, 241, 85, 1), size: 16),
                        horizontalTitleGap: -10.0,
                        title: Text(
                          'After answering all the questions, you can toggle between the sections using the "Previous" and "Next" buttons provided at the bottom of the screen',
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                    ListTileTheme(
                      dense: true, // Remove space between bullets and text
                      contentPadding: EdgeInsets.zero,
                      child: ListTile(
                        leading: Icon(Icons.send,
                            color: Color.fromARGB(255, 241, 85, 1), size: 16),
                        horizontalTitleGap: -10.0,
                        title: Text(
                          'After answering all the questions, click on the "Submit" button to generate the HRA report',
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                    // Add more ListTiles for additional bullet points
                  ],
                ),
              ),
              FractionallySizedBox(
                widthFactor: 0.9,
                child: ElevatedButton(
                  onPressed: () {
                    _showBottomSheet();
                    // Add button functionality here
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize:
                        Size(0.9, 50.0), // Increase the button's height to 50.0
                    primary: Color.fromARGB(255, 241, 85, 1),
                  ),
                  child: Text(
                    'Take Assessment',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }
}
