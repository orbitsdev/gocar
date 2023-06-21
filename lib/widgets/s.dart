
import 'package:flutter/material.dart';

class S extends StatelessWidget {
  final Widget? child;
  const S({
    Key? key,
    this.child,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(child: child,);
  }
}