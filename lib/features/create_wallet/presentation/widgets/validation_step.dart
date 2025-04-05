import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ostad/core/constant/app_color.dart';
import 'package:ostad/core/constant/app_dimens.dart';
import 'package:ostad/core/constant/app_icons.dart';
import 'package:ostad/core/constant/app_images.dart';
import 'package:ostad/core/constant/app_string.dart';
import 'package:ostad/core/utils/extensions.dart';
import 'package:ostad/core/widgets/app_button.dart';
import 'package:ostad/core/widgets/app_otp.dart';
import 'package:ostad/core/widgets/bullet_text.dart';
import 'package:ostad/core/widgets/app_snack_bar.dart';
import 'package:ostad/features/create_wallet/presentation/provider/create_wallet_provider.dart';
import 'package:provider/provider.dart';

class ValidationStep extends StatefulWidget {
  const ValidationStep({super.key});

  @override
  State<ValidationStep> createState() => _ValidationStepState();
}

class _ValidationStepState extends State<ValidationStep> {
  String _otp = '';
  static const int numberOfField = 6;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CreateWalletProvider>(context, listen: false).startCountdown();
    });
  }

  void setOtp(String otp) {
    setState(() {
      _otp = otp;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final createWalletProvider = Provider.of<CreateWalletProvider>(context, listen: false);
    return Expanded(
      child: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // image
                SvgPicture.asset(
                  AppImages.createWalletValidation,
                  height: 200,
                  width: 200,
                  fit: BoxFit.contain,
                ),
                AppDimens.vSpaceMedium,
                // description
                BulletText(
                  text: AppString.enterYourPhoneNumberForValidation,
                ),
                AppDimens.vSpaceVerySmall,
                // code sent to
                Text(
                  AppString.codeSentTo(
                    createWalletProvider.phoneNumberController.text,
                  ),
                ),
                AppDimens.vSpaceVerySmall,
                // edit phone number
                InkWell(
                  onTap: () {
                    createWalletProvider.stopCountdown();
                    Future.microtask(() {
                      createWalletProvider.previousStep();
                    });
                  },
                  child: Row(
                    spacing: AppDimens.veryVerySmall,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(AppIcons.editSquare),
                      Text(
                        AppString.editPhoneNumber,
                        style: theme.textTheme.bodyMedium!.copyWith(
                          color: AppColor.infoColor,
                        ),
                      )
                    ],
                  ),
                ),
                AppDimens.vSpaceLarge,
                AppOtp(
                  onChanged: (otp) {
                    setOtp(otp);
                  },
                ),
                AppDimens.vSpaceLarge,
                Consumer<CreateWalletProvider>(
                  builder: (context, createWalletProvider, child) {
                    return Text(
                      createWalletProvider.remainingSeconds.formattedTime,
                      style: theme.textTheme.displaySmall!.copyWith(
                        fontSize: 18,
                      ),
                    );
                  },
                ),
                AppDimens.vSpaceSmall,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: AppDimens.verySmall,
                  children: [
                    Text(
                      AppString.codeNotSent,
                    ),
                    Consumer<CreateWalletProvider>(
                      builder: (context, createWalletProvider, child) {
                        return GestureDetector(
                          onTap: () {
                            if (createWalletProvider.remainingSeconds == 0) {
                              createWalletProvider.sendPhoneNumberAndReferralCode();
                              createWalletProvider.startCountdown();
                            }
                          },
                          child: Text(
                            AppString.sentCodeAgain,
                            style: theme.textTheme.bodyMedium!.copyWith(
                              color: createWalletProvider.remainingSeconds > 0
                                  ? theme.disabledColor
                                  : AppColor.infoColor,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                Spacer(),
                // continu button
                Consumer<CreateWalletProvider>(
                  builder: (context, createWalletProvider, child) {
                    if (createWalletProvider.state == CreateWalletState.error) {
                      Future.microtask(
                        () {
                          AppSnackBar.showError(
                            context,
                            message: createWalletProvider.errorMessage ?? '',
                          );
                        },
                      );
                    }
                    return AppButton(
                      text: AppString.continueText,
                      bgColor: _otp.length == numberOfField ? null : theme.disabledColor,
                      isLoading: createWalletProvider.state == CreateWalletState.checkingOtp,
                      onTap: () {
                        if (_otp.length == numberOfField) {
                          createWalletProvider.checkOtpCode(_otp).then(
                            (value) {
                              if (createWalletProvider.state == CreateWalletState.success) {
                                Future.microtask(() {
                                  createWalletProvider.stopCountdown();
                                  createWalletProvider.nextStep();
                                });
                              }
                            },
                          );
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
