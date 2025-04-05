import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ostad/core/constant/app_dimens.dart';
import 'package:ostad/core/constant/app_images.dart';
import 'package:ostad/core/constant/app_string.dart';
import 'package:ostad/features/forget_password/presentation/widgets/new_password.dart';
import 'package:ostad/core/widgets/app_header.dart';
import 'package:ostad/features/forget_password/presentation/widgets/otp.dart';

enum ForgetPassSteps {
  otp,
  newPassword,
}

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  ForgetPassSteps currentStep = ForgetPassSteps.otp;

  void nextStep() {
    setState(() {
      if (currentStep.index < ForgetPassSteps.values.length - 1) {
        currentStep = ForgetPassSteps.values[currentStep.index + 1];
      }
    });
  }

  void previousStep() {
    setState(() {
      if (currentStep.index > 0) {
        currentStep = ForgetPassSteps.values[currentStep.index - 1];
      }
    });
  }

  @override     
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);   

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
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
                        if (ForgetPassSteps.otp == currentStep) {
                          GoRouter.of(context).pop();
                        } else {
                          previousStep();
                        }
                      },
                    ),
                    AppDimens.vSpaceMedium,
                    // image
                    SvgPicture.asset(
                      AppImages.forgetPass,
                      height: 200,
                      width: 200,
                      fit: BoxFit.contain,
                    ),
                    AppDimens.vSpaceMedium,
                    if (currentStep == ForgetPassSteps.otp)
                      OtpStep(
                        onTapContinue: (otp) {
                          nextStep();
                        },
                      ),
                    if (currentStep == ForgetPassSteps.newPassword)
                      NewPasswordStep(
                        onTapContinue: nextStep,
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
