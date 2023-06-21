import 'package:flutter/material.dart';

class H extends StatelessWidget {
  final double width;

  const H(this.width);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
    );
  }
}
