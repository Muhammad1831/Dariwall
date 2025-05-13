import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:dariwall/core/constant/app_dimens.dart';
import 'package:dariwall/core/constant/app_images.dart';
import 'package:dariwall/core/constant/app_string.dart';
import 'package:dariwall/core/route/app_route_name.dart';
import 'package:dariwall/core/widgets/app_button.dart';
import 'package:dariwall/core/widgets/app_header.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(AppDimens.paddingLarge),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppHeader(headerText: AppString.enterToWallet),
              SizedBox(
                height: AppDimens.extraLarge * 1.5,
              ),
              // image
              SvgPicture.asset(
                AppImages.loginToWallet,
                height: size.height * 0.25,
                width: size.height * 0.25,
                fit: BoxFit.scaleDown,
              ),
              AppDimens.vSpaceLarge,
              // description text
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppDimens.paddingExtraLarge),
                child: Text(
                  AppString.loginDescription,
                  style: theme.textTheme.bodyMedium,
                  textAlign: TextAlign.justify,
                ),
              ),
              Spacer(),
              // login with keys
              AppButton(
                text: AppString.loginWithKeys,
                onTap: () {
                  context.pushNamed(AppRouteName.loginWithKeys);
                },
              ),
              AppDimens.vSpaceSmall,
              // login with email
              AppButton(
                text: AppString.loginWithEmail,
                bgColor: Colors.transparent,
                onTap: () {
                  context.pushNamed(AppRouteName.loginWithEmail);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
