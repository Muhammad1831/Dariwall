import 'package:flutter/material.dart';
import 'package:ostad/core/constant/app_dimens.dart';

class AppProgressBar extends StatelessWidget {
  final List<String> stepsTitle;
  final Color activeColor;
  final Color inactiveColor;
  final int currentStepIndex;

  const AppProgressBar({
    super.key,
    required this.stepsTitle,
    required this.activeColor,
    required this.inactiveColor,
    required this.currentStepIndex,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Row(
          children: List.generate(stepsTitle.length * 2 - 1, (index) {
            if (index.isEven) {
              final stepIndex = index ~/ 2;
              return SizedBox(
                width: AppDimens.small,
                height: AppDimens.small,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: stepIndex < currentStepIndex ? activeColor : inactiveColor,
                    border: Border.all(
                        color: stepIndex == currentStepIndex
                            ? theme.colorScheme.tertiary
                            : Colors.transparent,
                        width: 2),
                    shape: BoxShape.circle,
                  ),
                ),
              );
            } else {
              final nextStepIndex = (index + 1) ~/ 2;
              return Expanded(
                child: SizedBox(
                  height: AppDimens.veryVerySmall,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: nextStepIndex <= currentStepIndex ? activeColor : inactiveColor,
                    ),
                  ),
                ),
              );
            }
          }),
        ),
        AppDimens.vSpaceSmall,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: stepsTitle
              .map(
                (step) => Text(
                  step,
                  style: theme.textTheme.bodySmall!.copyWith(
                    fontWeight: stepsTitle.indexOf(step) == currentStepIndex
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
