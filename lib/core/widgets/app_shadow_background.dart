import 'package:dariwall/core/constant/app_dimens.dart';
import 'package:flutter/material.dart';

class AppShadowBackground extends StatelessWidget {
  const AppShadowBackground({
    super.key,
    required this.child,
    this.bottomGlowDot,
  });

  final Widget child;
  final double? bottomGlowDot;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        const AppGlowDot(
          top: AppDimens.veryLarge,
        ),
        AppGlowDot(
          bottom: bottomGlowDot ?? size.height * 0.5,
          left: 0,
          color: theme.colorScheme.secondary.withValues(alpha: 0.4),
        ),
        child,
      ],
    );
  }
}

class AppGlowDot extends StatelessWidget {
  final double? top;
  final double? bottom;
  final double? left;
  final double? right;
  final double? size;
  final Color? color;

  const AppGlowDot({
    super.key,
    this.top,
    this.bottom,
    this.left,
    this.right,
    this.size = AppDimens.extraLarge,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color:
                  color?.withValues(alpha: 0.4) ?? theme.colorScheme.primary.withValues(alpha: 0.4),
              blurRadius: 80,
              spreadRadius: 30,
            ),
          ],
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
