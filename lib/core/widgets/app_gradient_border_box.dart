import 'package:flutter/material.dart';

class AppGradientBorderBox extends StatelessWidget {
  const AppGradientBorderBox({
    super.key,
    required this.child,
    required this.gradient,
    this.borderRadius,
    this.borderWidth = 1.0,
    this.onTap,
  });

  final Widget child;
  final Gradient gradient;
  final BorderRadius? borderRadius;
  final double borderWidth;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: borderRadius,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: GradientBorder(
            gradient: gradient,
            width: borderWidth,
          ),
          borderRadius: borderRadius,
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: borderRadius,
          child: child,
        ),
      ),
    );
  }
}

class GradientBorder extends BoxBorder {
  const GradientBorder({
    required this.gradient,
    this.width = 1.0,
  });

  final Gradient gradient;
  final double width;

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(width);

  @override
  BorderSide get top => BorderSide(width: width);

  @override
  BorderSide get bottom => BorderSide(width: width);

  @override
  bool get isUniform => true;

  @override
  void paint(
    Canvas canvas,
    Rect rect, {
    TextDirection? textDirection,
    BoxShape shape = BoxShape.rectangle,
    BorderRadius? borderRadius,
  }) {
    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..strokeWidth = width
      ..style = PaintingStyle.stroke;

    if (shape == BoxShape.rectangle) {
      if (borderRadius != null) {
        final path = Path()
          ..addRRect(borderRadius.toRRect(rect));
        canvas.drawPath(path, paint);
      } else {
        canvas.drawRect(rect, paint);
      }
    } else {
      canvas.drawCircle(rect.center, rect.shortestSide / 2, paint);
    }
  }

  @override
  ShapeBorder scale(double t) {
    return GradientBorder(
      gradient: gradient,
      width: width * t,
    );
  }
}
