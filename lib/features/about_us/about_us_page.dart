import 'package:dariwall/core/widgets/app_shadow_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dariwall/core/constant/app_dimens.dart';
import 'package:dariwall/core/constant/app_images.dart';
import 'package:dariwall/core/constant/app_string.dart';
import 'package:dariwall/core/widgets/app_header.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: AppShadowBackground(
          child: Padding(
            padding: EdgeInsets.all(AppDimens.paddingVeryLarge),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  AppHeader(headerText: AppString.aboutUs),
                  AppDimens.vSpaceLarge,
                  SvgPicture.asset(
                    AppImages.aboutUs,
                    fit: BoxFit.contain,
                    height: size.height * 0.25,
                    width: size.height * 0.25,
                  ),
                  AppDimens.vSpaceMedium,
                  Text(
                    AppString.welcomeToDariWallFamily,
                    style: theme.textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  AppDimens.vSpaceMedium,
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppDimens.paddingLarge,
                    ),
                    child: Text(
                      AppString.aboutUsDescription,
                      style: theme.textTheme.bodyMedium!.copyWith(
                        color: theme.colorScheme.onSurface,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
