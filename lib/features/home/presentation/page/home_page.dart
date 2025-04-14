import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ostad/core/constant/app_color.dart';
import 'package:ostad/core/constant/app_dimens.dart';
import 'package:ostad/core/constant/app_icons.dart';
import 'package:ostad/core/constant/app_string.dart';
import 'package:ostad/core/route/app_route_name.dart';
import 'package:ostad/core/widgets/app_token_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
                width: double.maxFinite,
                child: DecoratedBox(
                  decoration: BoxDecoration(gradient: AppColor.priceIncreaseGradient),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: AppDimens.paddingVeryLarge),
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
                          '50,000,000 تومان',
                          style: theme.textTheme.displayLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        AppDimens.vSpaceMedium,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              '+4.36%',
                              style: theme.textTheme.bodyLarge!.copyWith(
                                color: AppColor.priceIncreaseColor,
                              ),
                            ),
                            Text(
                              '+200,000 تومان',
                              style: theme.textTheme.bodyLarge!.copyWith(
                                color: AppColor.priceIncreaseColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    AppDimens.vSpaceLarge,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: AppDimens.paddingMedium),
                      child: Row(
                        spacing: AppDimens.verySmall,
                        children: [
                          ActionItem(
                            onTap: () => context.pushNamed(AppRouteName.buy),
                            icon: AppIcons.buy,
                            title: AppString.buy,
                          ),
                          ActionItem(
                            onTap: () => context.pushNamed(AppRouteName.swap),
                            icon: AppIcons.swap,
                            title: AppString.swap,
                          ),
                          ActionItem(
                            onTap: () => context.pushNamed(AppRouteName.send),
                            icon: AppIcons.send,
                            title: AppString.send,
                          ),
                          ActionItem(
                            onTap: () => context.pushNamed(AppRouteName.receive),
                            icon: AppIcons.scanQrCode,
                            title: AppString.receive,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          AppDimens.vSpaceMedium,
          // task list
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppDimens.paddingMedium,
            ),
            child: ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: 20,
              itemBuilder: (context, index) {
                return AppTokenCard(
                  tokenIcon: AppIcons.solana,
                  tokenName: 'شجریان',
                  tokenProfit: '-\$30',
                  tokenTotalNumber: '69،920.23528 OSTAD',
                  tokenTotalPrice: '\$2264',
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class ActionItem extends StatelessWidget {
  const ActionItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final String icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: Material(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(
          AppDimens.borderRadiusLarge,
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppDimens.borderRadiusLarge),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: AppDimens.paddingMedium),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppDimens.vSpaceVeryVerySmall,
                SvgPicture.asset(
                  icon,
                  height: AppDimens.iconVeryLarge,
                  width: AppDimens.iconVeryLarge,
                  fit: BoxFit.contain,
                  colorFilter: ColorFilter.mode(
                    theme.colorScheme.primary,
                    BlendMode.srcIn,
                  ),
                ),
                Text(
                  title,
                  style: theme.textTheme.bodyLarge,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
