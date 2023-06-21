import 'package:flutter/material.dart';
import 'package:gocar/utils/themes/app_color.dart';

class CarDetailsCard extends StatelessWidget {
  const CarDetailsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              blurRadius: 16,
              offset: Offset(0, 1),
              spreadRadius: 4,
              color: Colors.black.withOpacity(0.1))
        ],
        // Customize the background color
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
              color: AppColor.primary
                  .withOpacity(0.1), // Customize the icon background color
            ),
            padding: EdgeInsets.all(12), // Adjust padding for icon size
            child: Icon(
              Icons.star,
              color: AppColor.primary, // Customize the icon color
              size: 24, // Adjust the icon size
            ),
          ),
          SizedBox(height: 8), // Add spacing between the icon and text
          Text(
            '4.3ms',
            style: TextStyle(
              fontSize: 16, // Customize the text size
            ),
          ),
          Text(
            '0-100mph',
            style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade400 // Customize the text size
                ),
          ),
        ],
      ),
    );
  }
}
