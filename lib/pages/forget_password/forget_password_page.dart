import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ostad/constant/app_dimens.dart';
import 'package:ostad/constant/app_string.dart';
import 'package:ostad/pages/forget_password/widgets/enter_email.dart';
import 'package:ostad/pages/forget_password/widgets/new_password.dart';
import 'package:ostad/pages/sign_up/sign_up_page.dart';
import 'package:ostad/widgets/app_header.dart';

enum Step {
  information,
  otp,
  newPassword,
}

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  Step currentStep = Step.information;
  String _email = '';

  void nextStep() {
    setState(() {
      if (currentStep.index < Step.values.length - 1) {
        currentStep = Step.values[currentStep.index + 1];
      }
    });
  }

  void previousStep() {
    setState(() {
      if (currentStep.index > 0) {
        currentStep = Step.values[currentStep.index - 1];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppDimens.paddingLarge,
            vertical: AppDimens.paddingVeryLarge,
          ),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppHeader(
                headerText: AppString.forgotPassword,
                onTap: () {
                  if (Step.information == currentStep) {
                    GoRouter.of(context).pop();
                  } else {
                    previousStep();
                  }
                },
              ),
              AppDimens.vSpaceVeryLarge,

              // progress bar
              Row(
                children: [
                  SizedBox(
                    width: 12,
                    height: 12,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: currentStep.index >= Step.values[Step.information.index].index
                            ? theme.colorScheme.tertiary
                            : theme.colorScheme.surface,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 2,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: currentStep.index >= Step.values[Step.otp.index].index
                              ? theme.colorScheme.tertiary
                              : theme.colorScheme.surface,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 12,
                    height: 12,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: currentStep.index >= Step.values[Step.otp.index].index
                            ? theme.colorScheme.tertiary
                            : theme.colorScheme.surface,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 2,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: currentStep.index >= Step.values[Step.newPassword.index].index
                              ? theme.colorScheme.tertiary
                              : theme.colorScheme.surface,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 12,
                    height: 12,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: currentStep.index >= Step.values[Step.newPassword.index].index
                            ? theme.colorScheme.tertiary
                            : theme.colorScheme.surface,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
              AppDimens.vSpaceSmall,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppString.info,
                    style: theme.textTheme.bodySmall,
                  ),
                  Text(
                    AppString.validation,
                    style: theme.textTheme.bodySmall,
                  ),
                  Text(
                    AppString.newPassword,
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),

              AppDimens.vSpaceMedium,

              if (currentStep == Step.information)
                EnterEmailStep(
                  onTapContinue: (email) {
                    _email = email;
                    nextStep();
                  },
                ),

              if (currentStep == Step.otp)
                OtpStep(
                  email: _email,
                  onTapContinue: nextStep,
                  onTapResend: () {
                    // handle resend logic
                  },
                ),

              if (currentStep == Step.newPassword)
                NewPasswordStep(
                  onTapContinue: nextStep,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
