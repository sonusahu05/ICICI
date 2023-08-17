import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String cardText;

  CustomCard({required this.cardText});

  @override
  Widget build(BuildContext context) {
    double cardHeight = 200.0; // Adjust the height of the entire card as needed
    double blueAreaHeight = cardHeight * 0.4; // 30% of the card's height for the blue area

    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8, // 80% of the screen width
        height: cardHeight +100,
        padding: EdgeInsets.all(0.1),
        child:
         
         Column(
          children: [
            Container(
              height: blueAreaHeight,
              color: Colors.blue,
            ),
            Expanded(
              child: Center(
                child: Text(
                  cardText,
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
