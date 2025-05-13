import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:dariwall/core/constant/app_color.dart';
import 'package:dariwall/core/constant/app_dimens.dart';
import 'package:dariwall/core/constant/app_icons.dart';
import 'package:dariwall/core/constant/app_images.dart';
import 'package:dariwall/core/constant/app_string.dart';
import 'package:dariwall/core/extensions/time_formatter_extension.dart';
import 'package:dariwall/core/route/app_route_name.dart';
import 'package:dariwall/core/widgets/app_button.dart';
import 'package:dariwall/core/widgets/app_header.dart';
import 'package:dariwall/core/widgets/app_otp.dart';
import 'package:dariwall/features/login/presentation/provider/login_provider.dart';
import 'package:provider/provider.dart';

class ValidationPage extends StatefulWidget {
  const ValidationPage({
    super.key,
    required this.email,
  });

  final String email;
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
      Provider.of<LoginProvider>(context, listen: false).startCountdown();
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

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: EdgeInsets.all(AppDimens.paddingLarge),
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppHeader(
                      onTap: () {
                        Provider.of<LoginProvider>(context, listen: false).stopCountdown();
                        context.pop();
                      },
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
                      AppString.enterYourEmailForVerification,
                      style: theme.textTheme.bodyMedium!.copyWith(
                        color: theme.colorScheme.onSurface,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    AppDimens.vSpaceLarge,
                    // code sent to
                    Text(
                      AppString.codeSentTo(widget.email),
                      style: theme.textTheme.bodyMedium,
                    ),
                    AppDimens.vSpaceSmall,
                    // edit email
                    InkWell(
                      onTap: () {
                        Provider.of<LoginProvider>(context, listen: false).stopCountdown();
                        context.pop();
                      },
                      child: Row(
                        spacing: AppDimens.veryVerySmall,
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(AppIcons.editSquare),
                          Text(
                            AppString.editEmail,
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
                    Consumer<LoginProvider>(
                      builder: (context, provider, child) {
                        return Text(
                          provider.remainingSeconds.formattedTime,
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
                        Consumer<LoginProvider>(
                          builder: (context, provider, child) {
                            return GestureDetector(
                              onTap: () {
                                if (provider.remainingSeconds == 0) {
                                  provider.loginWithEmail(email: widget.email);
                                  provider.startCountdown();
                                }
                              },
                              child: Text(
                                AppString.sentCodeAgain,
                                style: theme.textTheme.bodyMedium!.copyWith(
                                  color: provider.remainingSeconds > 0
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

                    Consumer<LoginProvider>(
                      builder: (context, provider, child) {
                        return AppButton(
                          text: AppString.enterToApp,
                          bgColor: _otp.length == ValidationPage.numberOfField
                              ? null
                              : theme.disabledColor,
                          isLoading: provider.status == LoginStatus.loading,
                          onTap: () {
                            if (_otp.length == ValidationPage.numberOfField) {
                              provider.verifyEmailCode(code: _otp).then(
                                (value) {
                                  if (provider.status == LoginStatus.loggedIn) {
                                    provider.stopCountdown();
                                    context.goNamed(AppRouteName.home);
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
        ),
      ),
    );
  }
}
