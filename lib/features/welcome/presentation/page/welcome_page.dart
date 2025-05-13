import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dariwall/core/constant/app_color.dart';
import 'package:dariwall/core/constant/app_dimens.dart';
import 'package:dariwall/core/constant/app_images.dart';
import 'package:dariwall/core/constant/app_string.dart';
import 'package:dariwall/core/route/app_route_name.dart';
import 'package:dariwall/core/widgets/app_button.dart';
import 'package:dariwall/core/widgets/app_gradiant_text.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   _showLanguageSelectionModal();
    // });
  }

  // void _showLanguageSelectionModal() {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (context) => const LanguageSelectionModal(),
  //     backgroundColor: Colors.transparent,
  //     isScrollControlled: true,
  //     enableDrag: true,
  //     useSafeArea: true,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
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
              // image
              Image.asset(
                AppImages.welcome,
                fit: BoxFit.scaleDown,
                height: size.height * 0.35,
                width: size.height * 0.2,
              ),
              AppDimens.vSpaceLarge,
              // welcome to wallet text
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${AppString.toTheWallet} ',
                    style: theme.textTheme.displaySmall,
                  ),
                  AppGradiantText(
                    AppString.dariWall,
                    gradient: AppColor.logoGradient,
                    style: theme.textTheme.displaySmall,
                  ),
                  Text(
                    ' ${AppString.welcome}!',
                    style: theme.textTheme.displaySmall,
                  ),
                ],
              ),
              AppDimens.vSpaceMedium,
              // description text
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppDimens.paddingExtraLarge),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: AppString.welcomeDescriptionPart1,
                    style: theme.textTheme.bodyMedium!.copyWith(
                      color: theme.colorScheme.onSurface,
                    ),
                    children: [
                      TextSpan(
                        text: AppString.newWallet,
                        style: theme.textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      WidgetSpan(child: AppDimens.hSpaceVeryVerySmall),
                      TextSpan(
                        text: AppString.welcomeDescriptionPart2,
                      ),
                      WidgetSpan(child: AppDimens.hSpaceVeryVerySmall),
                      TextSpan(
                        text: AppString.haveWallet,
                        style: theme.textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      WidgetSpan(child: AppDimens.hSpaceVeryVerySmall),
                      TextSpan(
                        text: AppString.enter,
                      )
                    ],
                  ),
                ),
              ),
              Spacer(),
              // create wallet button
              AppButton(
                text: AppString.createNewWallet,
                onTap: () {
                  context.pushNamed(AppRouteName.createNewWallet);
                },
              ),
              AppDimens.vSpaceSmall,
              // have wallet button
              AppButton(
                text: AppString.haveWallet,
                bgColor: Colors.transparent,
                onTap: () {
                  context.pushNamed(AppRouteName.login);
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
