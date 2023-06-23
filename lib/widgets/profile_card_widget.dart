import 'package:flutter/material.dart';

class ProfileCardWidget extends StatelessWidget {

final IconData icon;
final String text;
  const ProfileCardWidget({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);
  @override
  Widget build(BuildContext context){
    return Row(
  children: [
    Container(
      
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: Colors.black, size: 34,),
    ),
    SizedBox(width: 16),
    Expanded(
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    ),
  ],
);
  }
}