import 'package:flutter/material.dart';
import 'package:ostad/core/widgets/app_back_button.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({
    super.key,
    required this.headerText,
    this.justIcon = false,
    this.onTap,
  });

  final String headerText;
  final VoidCallback? onTap;
  final bool justIcon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                headerText,
                style: theme.textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        AppBackButton(
          onTap: onTap,
        )
      ],
    );
  }
}
