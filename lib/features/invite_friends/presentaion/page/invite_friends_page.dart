import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ostad/core/constant/app_dimens.dart';
import 'package:ostad/core/constant/app_icons.dart';
import 'package:ostad/core/constant/app_images.dart';
import 'package:ostad/core/constant/app_string.dart';
import 'package:ostad/core/widgets/app_header.dart';
import 'package:ostad/core/widgets/bullet_text.dart';

class InviteFriendsPage extends StatelessWidget {
  const InviteFriendsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(
            vertical: AppDimens.paddingLarge,
            horizontal: AppDimens.paddingMedium,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppHeader(headerText: AppString.inviteFriends),
                AppDimens.vSpaceSmall,
                Center(
                  child: SvgPicture.asset(
                    AppImages.inviteFriends,
                    fit: BoxFit.contain,
                  ),
                ),
                AppDimens.vSpaceVerySmall,
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(AppDimens.borderRadiusSmall),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: AppDimens.paddingSmall),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          spacing: AppDimens.veryVerySmall,
                          children: [
                            Text(AppString.successfulInvite),
                            Text('3 نفر'),
                          ],
                        ),
                        SizedBox(
                          height: AppDimens.extraLarge,
                          child: VerticalDivider(
                            color: theme.cardTheme.color,
                            width: 0,
                            thickness: 1,
                          ),
                        ),
                        Column(
                          spacing: AppDimens.veryVerySmall,
                          children: [
                            Text(AppString.rewardReceived),
                            Text('\$100'),
                          ],
                        ),
                        SizedBox(
                          height: AppDimens.extraLarge,
                          child: VerticalDivider(
                            color: theme.cardTheme.color,
                            width: 0,
                            thickness: 1,
                          ),
                        ),
                        Column(
                          spacing: AppDimens.veryVerySmall,
                          children: [
                            Text(AppString.nextGift),
                            Text('\$2'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                AppDimens.vSpaceLarge,
                Text(AppString.yourReferralCode),
                AppDimens.vSpaceVerySmall,
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: theme.cardTheme.color,
                    borderRadius: BorderRadius.circular(AppDimens.borderRadiusSmall),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(AppDimens.paddingMedium),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('OSTAD-5A2B-8C9D'),
                        SvgPicture.asset(AppIcons.copy),
                      ],
                    ),
                  ),
                ),
                AppDimens.vSpaceMedium,
                Text(AppString.referralLink),
                AppDimens.vSpaceVerySmall,
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: theme.cardTheme.color,
                    borderRadius: BorderRadius.circular(AppDimens.borderRadiusSmall),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(AppDimens.paddingMedium),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('ostad.com/5A2B8C9D'),
                        SvgPicture.asset(AppIcons.copy),
                      ],
                    ),
                  ),
                ),
                AppDimens.vSpaceVerySmall,
                Text(
                  'برای نصب برنامه این لینک را به دوستانتان ارسال کنید.',
                  style: theme.textTheme.bodySmall!.copyWith(
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                AppDimens.vSpaceLarge,
                Center(
                  child: Text(AppString.inviteYourFriends),
                ),
                AppDimens.vSpaceSmall,
                BulletText(text: AppString.howToInviteFriends),
                AppDimens.vSpaceSmall,
                BulletText(text: AppString.sendToFriends),
                AppDimens.vSpaceSmall,
                BulletText(text: AppString.afterRegisterAndFirstTransaction),
                AppDimens.vSpaceSmall,
                BulletText(text: AppString.copyReferralCode),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
