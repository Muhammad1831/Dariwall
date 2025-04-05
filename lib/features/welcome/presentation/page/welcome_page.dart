import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ostad/core/constant/app_dimens.dart';
import 'package:ostad/core/constant/app_images.dart';
import 'package:ostad/core/constant/app_string.dart';
import 'package:ostad/core/route/app_route_name.dart';
import 'package:ostad/core/widgets/app_button.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppDimens.paddingMedium),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: AppDimens.extraLarge * 1.5,
              ),
              SvgPicture.asset(
                AppImages.welcome,
                fit: BoxFit.scaleDown,
              ),
              AppDimens.vSpaceMedium,
              RichText(
                text: TextSpan(
                  text: '${AppString.toTheWallet} ',
                  style: theme.textTheme.displaySmall!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: '${AppString.dariWall} ',
                      style: theme.textTheme.displaySmall!.copyWith(
                        color: theme.colorScheme.tertiary,
                      ),
                    ),
                    TextSpan(
                      text: '${AppString.welcome}!',
                    ),
                  ],
                ),
              ),
              AppDimens.vSpaceMedium,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppDimens.paddingVeryLarge),
                child: Text(
                  AppString.welcomeDescription,
                  style: theme.textTheme.bodySmall,
                  textAlign: TextAlign.justify,
                ),
              ),
              Spacer(),
              AppButton(
                text: AppString.createNewWallet,
                onTap: () {
                  context.pushNamed(AppRouteName.createWallet);
                },
              ),
              AppDimens.vSpaceSmall,
              AppButton(
                text: AppString.haveWallet,
                bgColor: theme.buttonTheme.colorScheme!.secondary,
                borderColor: theme.buttonTheme.colorScheme!.outline,
                onTap: () {
                  context.goNamed(AppRouteName.login);
                },
              ),
              AppDimens.vSpaceMedium,
            ],
          ),
        ),
      ),
    );
  }
}
