import 'package:flutter/material.dart';

class AppGlowDot extends StatelessWidget {
  final double? top;
  final double? bottom;
  final double? left;
  final double? right;
  final double size;
  final BoxShadow shadow;

  const AppGlowDot({
    super.key,
    this.top,
    this.bottom,
    this.left,
    this.right,
    this.size = 25,
    required this.shadow,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          boxShadow: [shadow],
        ),
      ),
    );
  }
}
