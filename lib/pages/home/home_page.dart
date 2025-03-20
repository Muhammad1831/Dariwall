import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ostad/constant/app_color.dart';
import 'package:ostad/constant/app_dimens.dart';
import 'package:ostad/constant/app_icons.dart';
import 'package:ostad/constant/app_images.dart';
import 'package:ostad/constant/app_string.dart';
import 'package:ostad/style/app_text_style.dart';
import 'package:ostad/utils/extensions.dart';
import 'package:ostad/widgets/app_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppDimens.paddingMedium),
        child: Column(
          children: [
            // total balance text
            Text(
              AppString.totalBalance,
              style: theme.textTheme.titleMedium,
            ),
            AppDimens.vSpaceSmall,
            // add balance button and total balance
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  //TODO: Add onTap
                  onTap: () {},
                  borderRadius: BorderRadius.circular(50),
                  child: Padding(
                    padding: EdgeInsets.all(AppDimens.veryVerySmall),
                    child: Icon(
                      Icons.add_circle_outline_outlined,
                      size: AppDimens.iconMedium,
                      color: theme.colorScheme.tertiary,
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: AppDimens.veryVerySmall,
                  children: [
                    Text(
                      12500000.toPersianNumber(),
                      style: theme.textTheme.displayMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontFamily: AppTextStyle.iranSansWeb,
                      ),
                    ),
                    Text(
                      AppString.toman,
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                )
              ],
            ),
            AppDimens.vSpaceMedium,
            // price card
            Stack(
              children: [
                SizedBox(
                  width: double.maxFinite,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: AppColor.priceCardGradient,
                      borderRadius: BorderRadius.circular(
                        AppDimens.borderRadiusSmall,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: AppDimens.medium),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            AppImages.logo,
                            height: 64.r,
                            width: 64.r,
                            fit: BoxFit.scaleDown,
                          ),
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
                                '+4.36%',
                                style: theme.textTheme.bodyLarge!.copyWith(
                                  color: AppColor.priceIncreaseColor,
                                ),
                              ),
                              Text(
                                '+\$0.44',
                                style: theme.textTheme.bodyLarge!.copyWith(
                                  color: AppColor.priceIncreaseColor,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: -50.w,
                  bottom: 0,
                  top: 0,
                  child: SvgPicture.asset(
                    AppImages.priceCardPattern,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  left: -50.w,
                  bottom: 0,
                  top: 0,
                  child: SvgPicture.asset(
                    AppImages.priceCardPattern,
                    fit: BoxFit.cover,
                  ),
                )
              ],
            ),
            AppDimens.vSpaceSmall,
            // buy and sell button
            Row(
              spacing: AppDimens.verySmall,
              children: [
                Expanded(
                  child: AppButton(
                    text: AppString.buy,
                    textColor: theme.colorScheme.onPrimary,
                    icon: AppIcons.buy,
                    onTap: () {},
                  ),
                ),
                Expanded(
                  child: AppButton(
                    text: AppString.sell,
                    icon: AppIcons.sell,
                    bgColor: Colors.transparent,
                    borderColor: theme.colorScheme.onPrimary,
                    textColor: theme.colorScheme.onPrimary,
                    onTap: () {},
                  ),
                ),
              ],
            ),
            AppDimens.vSpaceMedium,
            // share purchase ostad
            DecoratedBox(
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(AppDimens.borderRadiusSmall),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: AppDimens.small,
                  horizontal: AppDimens.verySmall,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppString.sharePurchase,
                      style: theme.textTheme.bodyMedium,
                    ),
                    Row(
                      spacing: AppDimens.veryVerySmall,
                      children: [
                        Text(
                          AppString.ostad,
                          style: theme.textTheme.bodySmall,
                        ),
                        Text(
                          28123.toPersianNumber(),
                          style: theme.textTheme.bodyMedium,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            AppDimens.vSpaceLarge,
            // gift and reward text
            Row(
              children: [
                SvgPicture.asset(
                  AppIcons.gift,
                  height: AppDimens.iconMedium,
                  width: AppDimens.iconMedium,
                  fit: BoxFit.scaleDown,
                ),
                AppDimens.hSpaceVerySmall,
                Text(
                  AppString.giftAndReward,
                  style: theme.textTheme.titleMedium,
                ),
              ],
            ),
            AppDimens.vSpaceMedium,
            // task list
            ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: 10,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: AppDimens.verySmall),
                  child: Container(
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(AppDimens.borderRadiusSmall),
                      border: Border.all(
                        color: theme.colorScheme.secondary,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                        AppDimens.medium,
                        AppDimens.small,
                        AppDimens.small,
                        AppDimens.small,
                      ),
                      child: Row(
                        spacing: AppDimens.verySmall,
                        children: [
                          SvgPicture.asset(
                            AppIcons.taskIcon,
                            height: AppDimens.iconMedium,
                            width: AppDimens.iconMedium,
                            fit: BoxFit.scaleDown,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'دنبال کردن OSTAD در توئیتر',
                                style: theme.textTheme.bodyMedium,
                              ),
                              Text(
                                '${AppString.reward} : ',
                                style: theme.textTheme.bodySmall,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
