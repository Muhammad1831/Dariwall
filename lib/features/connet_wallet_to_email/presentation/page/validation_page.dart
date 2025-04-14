import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ostad/core/constant/app_color.dart';
import 'package:ostad/core/constant/app_dimens.dart';
import 'package:ostad/core/constant/app_icons.dart';
import 'package:ostad/core/constant/app_images.dart';
import 'package:ostad/core/constant/app_string.dart';
import 'package:ostad/core/route/app_route_name.dart';
import 'package:ostad/core/widgets/app_button.dart';
import 'package:ostad/core/widgets/app_glow_dot.dart';
import 'package:ostad/core/widgets/app_header.dart';
import 'package:ostad/core/widgets/app_otp.dart';

class ValidationPage extends StatefulWidget {
  const ValidationPage({super.key});

  static const int numberOfField = 6;

  @override
  State<ValidationPage> createState() => _ValidationPageState();
}

class _ValidationPageState extends State<ValidationPage> {
  String _otp = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Provider.of<CreateWalletProvider>(context, listen: false).startCountdown();
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
    final size = MediaQuery.of(context).size;
    // final createWalletProvider = Provider.of<CreateWalletProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: EdgeInsets.all(AppDimens.paddingLarge),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              AppGlowDot(shadow: AppColor.blueGlowShadow),
              AppGlowDot(
                shadow: AppColor.pinkGlowShadow,
                bottom: 0,
                left: 0,
              ),
              CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppHeader(
                          headerText: AppString.validation,
                        ),
                        AppDimens.vSpaceVeryLarge,
                        // image
                        SvgPicture.asset(
                          AppImages.connectWalletToEmail,
                          height: size.height * 0.25,
                          width: size.height * 0.25,
                          fit: BoxFit.scaleDown,
                        ),
                        AppDimens.vSpaceMedium,
                        // description
                        Text(
                          AppString.enterYourPhoneNumberForValidation,
                          style: theme.textTheme.bodyMedium!.copyWith(
                            color: theme.colorScheme.onSurface,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        AppDimens.vSpaceLarge,
                        // code sent to
                        Text(
                          AppString.codeSentTo('text@gmail.com'),
                          style: theme.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                        ),
                        AppDimens.vSpaceSmall,
                        // edit phone number
                        InkWell(
                          onTap: () {
                            // createWalletProvider.stopCountdown();
                            // Future.microtask(() {
                            //   createWalletProvider.previousStep();
                            // });
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
                        // AppDimens.vSpaceLarge,
                        // Consumer<CreateWalletProvider>(
                        //   builder: (context, createWalletProvider, child) {
                        //     return Text(
                        //       createWalletProvider.remainingSeconds.formattedTime,
                        //       style: theme.textTheme.displaySmall!.copyWith(
                        //         fontSize: 18,
                        //       ),
                        //     );
                        //   },
                        // ),
                        AppDimens.vSpaceSmall,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: AppDimens.verySmall,
                          children: [
                            Text(
                              AppString.codeNotSent,
                            ),
                            // Consumer<CreateWalletProvider>(
                            //   builder: (context, createWalletProvider, child) {
                            //     return
                            GestureDetector(
                              onTap: () {
                                // if (createWalletProvider.remainingSeconds == 0) {
                                //   createWalletProvider.sendPhoneNumberAndReferralCode();
                                //   createWalletProvider.startCountdown();
                                // }
                              },
                              child: Text(
                                AppString.sentCodeAgain,
                                style: theme.textTheme.bodyMedium!.copyWith(
                                    // color: createWalletProvider.remainingSeconds > 0
                                    //     ? theme.disabledColor
                                    //     : AppColor.infoColor,
                                    ),
                              ),
                              // );
                              // },
                            ),
                          ],
                        ),
                        Spacer(),
                        // continu button
                        // Consumer<CreateWalletProvider>(
                        //   builder: (context, createWalletProvider, child) {
                        //     if (createWalletProvider.state == CreateWalletState.error) {
                        //       Future.microtask(
                        //         () {
                        //           AppSnackBar.showError(
                        //             context,
                        //             message: createWalletProvider.errorMessage ?? '',
                        //           );
                        //         },
                        //       );
                        //     }
                        // return
                        AppButton(
                          text: AppString.enterToApp,
                          bgColor: _otp.length == ValidationPage.numberOfField
                              ? null
                              : theme.disabledColor,
                          // isLoading: createWalletProvider.state == CreateWalletState.checkingOtp,
                          onTap: () {
                            context.goNamed(AppRouteName.home);
                            // if (_otp.length == ValidationPage.numberOfField) {
                            //   createWalletProvider.checkOtpCode(_otp).then(
                            //     (value) {
                            //       if (createWalletProvider.state == CreateWalletState.success) {
                            //         Future.microtask(() {
                            //           createWalletProvider.stopCountdown();
                            //           createWalletProvider.nextStep();
                            //         });
                            //       }
                            //     },
                            //   );
                            // }
                          },
                        )
                        //   },
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
