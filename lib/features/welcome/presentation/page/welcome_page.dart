import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ostad/core/constant/app_color.dart';
import 'package:ostad/core/constant/app_dimens.dart';
import 'package:ostad/core/constant/app_images.dart';
import 'package:ostad/core/constant/app_string.dart';
import 'package:ostad/core/route/app_route_name.dart';
import 'package:ostad/core/widgets/app_button.dart';
import 'package:ostad/core/widgets/app_glow_dot.dart';
import 'package:ostad/core/widgets/app_gradiant_text.dart';
import 'package:ostad/features/welcome/presentation/widgets/language_selection_modal.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showLanguageSelectionModal();
    });
  }

  void _showLanguageSelectionModal() {
    showModalBottomSheet(
      context: context,
      builder: (context) => const LanguageSelectionModal(),
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      enableDrag: true,
      useSafeArea: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppDimens.paddingMedium),
          child: Stack(
            children: [
              AppGlowDot(
                shadow: AppColor.blueGlowShadow,
              ),
              AppGlowDot(
                bottom: 0,
                left: 0,
                shadow: AppColor.pinkGlowShadow,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: AppDimens.extraLarge * 1.5,
                  ),
                  // image
                  SvgPicture.asset(
                    AppImages.welcome,
                    fit: BoxFit.scaleDown,
                  ),
                  AppDimens.vSpaceMedium,
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
                    bgColor: theme.buttonTheme.colorScheme!.secondary,
                    borderColor: theme.buttonTheme.colorScheme!.outline,
                    onTap: () {
                      context.goNamed(AppRouteName.login);
                    },
                  ),
                  AppDimens.vSpaceMedium,
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
