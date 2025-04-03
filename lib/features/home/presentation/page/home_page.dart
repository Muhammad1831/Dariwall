import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ostad/core/constant/app_color.dart';
import 'package:ostad/core/constant/app_dimens.dart';
import 'package:ostad/core/constant/app_icons.dart';
import 'package:ostad/core/constant/app_string.dart';
import 'package:ostad/core/widgets/app_token_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.25,
              width: double.maxFinite,
              child: DecoratedBox(
                decoration: BoxDecoration(gradient: AppColor.priceDecreaseGradient),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: AppDimens.paddingLarge),
              child: Column(
                children: [
                  // total balance text
                  Text(
                    AppString.totalBalance,
                    style: theme.textTheme.titleMedium,
                  ),
                  AppDimens.vSpaceMedium,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppDimens.vSpaceMedium,
                      Text(
                        '\$0.00023066',
                        style: theme.textTheme.displayLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      AppDimens.vSpaceMedium,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            '4.36%+',
                            style: theme.textTheme.bodyLarge!.copyWith(
                              color: AppColor.priceIncreaseColor,
                            ),
                          ),
                          Text(
                            '\$0.44+',
                            style: theme.textTheme.bodyLarge!.copyWith(
                              color: AppColor.priceIncreaseColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  AppDimens.vSpaceLarge,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ActionItem(
                        icon: AppIcons.buy,
                        title: AppString.buy,
                      ),
                      ActionItem(
                        icon: AppIcons.swap,
                        title: AppString.swap,
                      ),
                      ActionItem(
                        icon: AppIcons.send,
                        title: AppString.send,
                      ),
                      ActionItem(
                        icon: AppIcons.scanQrCode,
                        title: AppString.receive,
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
        AppDimens.vSpaceMedium,
        // task list
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppDimens.paddingMedium,
            ),
            child: ListView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: 20,
              itemBuilder: (context, index) {
                return AppTokenCard(
                  tokenIcon: AppIcons.solana,
                  tokenName: 'Shajarian',
                  tokenProfit: '-\$30',
                  tokenTotalNumber: '69،920.23528 OSTAD',
                  tokenTotalPrice: '\$2264',
                );
              },
            ),
          ),
        )
      ],
    );
  }
}

class ActionItem extends StatelessWidget {
  const ActionItem({
    super.key,
    required this.icon,
    required this.title,
  });

  final String icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: AppDimens.cardLargeHeight,
      width: AppDimens.cardLargeHeight,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: theme.cardTheme.color,
          borderRadius: BorderRadius.circular(
            AppDimens.borderRadiusSmall,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppDimens.vSpaceVeryVerySmall,
            Expanded(
              child: SvgPicture.asset(
                icon,
                height: AppDimens.iconLarge,
                width: AppDimens.iconLarge,
                fit: BoxFit.contain,
                colorFilter: ColorFilter.mode(
                  theme.colorScheme.tertiary,
                  BlendMode.srcIn,
                ),
              ),
            ),
            Expanded(
              child: Text(
                title,
              ),
            )
          ],
        ),
      ),
    );
  }
}
