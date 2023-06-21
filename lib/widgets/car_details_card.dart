import 'package:flutter/material.dart';

class CarDetailsCard extends StatelessWidget {
  const CarDetailsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.lightBlueAccent, // Customize the background color
        borderRadius:
            BorderRadius.circular(10), // Apply border radius for rounded shape
      ),
      padding: EdgeInsets.all(16), // Add padding for spacing
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white, // Customize the icon background color
            ),
            padding: EdgeInsets.all(12), // Adjust padding for icon size
            child: Icon(
              Icons.star,
              color: Colors.yellow, // Customize the icon color
              size: 24, // Adjust the icon size
            ),
          ),
          SizedBox(height: 8), // Add spacing between the icon and text
          Text(
            'Your Text Here',
            style: TextStyle(
              fontSize: 16, // Customize the text size
              fontWeight: FontWeight.bold, // Customize the text style
              color: Colors.white, // Customize the text color
            ),
          ),
        ],
      ),
    );
  }
}
