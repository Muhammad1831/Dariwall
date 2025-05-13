import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:dariwall/core/constant/app_color.dart';
import 'package:dariwall/core/constant/app_dimens.dart';
import 'package:dariwall/core/constant/app_icons.dart';
import 'package:dariwall/core/constant/app_images.dart';
import 'package:dariwall/core/constant/app_string.dart';
import 'package:dariwall/core/di/locator_service.dart';
import 'package:dariwall/core/extensions/time_formatter_extension.dart';
import 'package:dariwall/core/route/app_route_name.dart';
import 'package:dariwall/core/widgets/app_button.dart';
import 'package:dariwall/core/widgets/app_header.dart';
import 'package:dariwall/core/widgets/app_otp.dart';
import 'package:dariwall/features/connet_wallet_to_email/presentation/providers/connect_wallet_email_otp_provider.dart';
import 'package:dariwall/features/connet_wallet_to_email/presentation/providers/connect_wallet_email_provider.dart';
import 'package:provider/provider.dart';

class ConnectWalletEmailOtpPage extends StatefulWidget {
  const ConnectWalletEmailOtpPage({
    super.key,
    required this.email,
  });

  final String email;
  static const int numberOfField = 6;

  @override
  State<ConnectWalletEmailOtpPage> createState() => _ConnectWalletEmailOtpPageState();
}

class _ConnectWalletEmailOtpPageState extends State<ConnectWalletEmailOtpPage> {
  String _otp = '';

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getIt<ConnectWalletEmailOtpProvider>().startCountdown();
    });
    super.initState();
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

    return ChangeNotifierProvider.value(
      value: getIt<ConnectWalletEmailOtpProvider>(),
      child: SafeArea(
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
                      Consumer<ConnectWalletEmailOtpProvider>(
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
                          Consumer<ConnectWalletEmailOtpProvider>(
                            builder: (context, provider, child) {
                              return GestureDetector(
                                onTap: () {
                                  if (provider.remainingSeconds == 0) {
                                    provider.startCountdown();
                                    getIt<ConnectWalletEmailProvider>()
                                        .sendEmailOtp(email: widget.email);
                                  }
                                },
                                child: Text(
                                  AppString.sentCodeAgain,
                                  style: theme.textTheme.bodyMedium!.copyWith(
                                    color: provider.remainingSeconds == 0
                                        ? AppColor.infoColor
                                        : theme.disabledColor,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      Spacer(),
                      // continu button
                      Consumer<ConnectWalletEmailOtpProvider>(
                        builder: (context, provider, child) {
                          return AppButton(
                            text: AppString.enterToApp,
                            bgColor: _otp.length == ConnectWalletEmailOtpPage.numberOfField
                                ? null
                                : theme.disabledColor,
                            isLoading: provider.status == ConnectWalletEmailOtpStatus.loading,
                            onTap: () {
                              if (_otp.length == ConnectWalletEmailOtpPage.numberOfField) {
                                provider.verifyEmailCode(code: _otp, email: widget.email).then(
                                  (value) {
                                    if (provider.status == ConnectWalletEmailOtpStatus.success) {
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
      ),
    );
  }
}
