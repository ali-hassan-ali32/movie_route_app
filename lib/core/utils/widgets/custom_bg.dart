import 'package:flutter/material.dart';

class CustomBackground extends StatelessWidget {
  const CustomBackground({required this.child,super.key});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff121312),
      child: child,
    );
  }
}
