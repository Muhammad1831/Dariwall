import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:dariwall/core/constant/app_dimens.dart';
import 'package:dariwall/core/constant/app_images.dart';
import 'package:dariwall/core/constant/app_string.dart';
import 'package:dariwall/core/widgets/app_button.dart';

class ComingSoonPage extends StatelessWidget {
  const ComingSoonPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(AppDimens.paddingLarge),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  AppDimens.vSpaceExtraLarge,
                  SvgPicture.asset(
                    AppImages.comingSoon,
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.height * 0.3,
                    fit: BoxFit.scaleDown,
                  ),
                  AppDimens.vSpaceMedium,
                  Text(
                    AppString.comingSoon,
                    style: theme.textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  AppDimens.vSpaceMedium,
                  Text(
                    AppString.comingSoonDescription,
                    style: theme.textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              AppButton(
                text: AppString.backToPreviousPage,
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
