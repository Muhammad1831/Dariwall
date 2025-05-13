import 'package:dariwall/core/constant/app_color.dart';
import 'package:dariwall/core/widgets/app_shadow_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:dariwall/core/constant/app_dimens.dart';
import 'package:dariwall/core/constant/app_icons.dart';
import 'package:dariwall/core/constant/app_images.dart';
import 'package:dariwall/core/constant/app_message.dart';
import 'package:dariwall/core/constant/app_string.dart';
import 'package:dariwall/core/di/locator_service.dart';
import 'package:dariwall/core/utils/utils_clipboard.dart';
import 'package:dariwall/core/widgets/app_header.dart';
import 'package:dariwall/core/widgets/app_loading.dart';
import 'package:dariwall/features/invite_friends/data/model/invite_friends_model.dart';
import 'package:dariwall/features/invite_friends/presentaion/provider/invite_friends_provider.dart';
import 'package:dariwall/features/user_account/presentation/provider/get_user_account_info_provider.dart';
import 'package:provider/provider.dart';

class InviteFriendsPage extends StatelessWidget {
  const InviteFriendsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ChangeNotifierProvider.value(
      value: getIt<InviteFriendsProvider>(),
      child: SafeArea(
        child: Scaffold(
          body: AppShadowBackground(
            child: Padding(
              padding: EdgeInsets.all(AppDimens.paddingLarge),
              child: Selector<InviteFriendsProvider, InviteFriendsStatus>(
                selector: (context, provider) => provider.status,
                builder: (context, status, child) {
                  if (status == InviteFriendsStatus.loading) {
                    return const AppLoading();
                  }
                  return Selector<InviteFriendsProvider, InviteFriendsModel?>(
                    selector: (context, provider) => provider.inviteFriends,
                    shouldRebuild: (previous, next) => previous?.count != next?.count,
                    builder: (context, inviteFriends, child) {
                      return Column(
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
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  // successful invite
                                  Column(
                                    spacing: AppDimens.verySmall,
                                    children: [
                                      Text(AppString.inviteCount),
                                      Text(
                                        inviteFriends?.count.toString() ?? '0',
                                        style: theme.textTheme.bodyMedium!.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  // reward received
                                  Column(
                                    spacing: AppDimens.verySmall,
                                    children: [
                                      Text(AppString.successfulInvite),
                                      Text(
                                        inviteFriends?.successfulCount.toString() ?? '0',
                                        style: theme.textTheme.bodyMedium!.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  // next gift
                                  Column(
                                    spacing: AppDimens.verySmall,
                                    children: [
                                      Text(AppString.inviteGift),
                                      Text(
                                        '${inviteFriends?.totalReward.toString() ?? '0'} \$',
                                        style: theme.textTheme.bodyMedium!.copyWith(
                                          color: AppColor.warningColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          AppDimens.vSpaceLarge,
                          Text(AppString.yourReferralCode),
                          AppDimens.vSpaceVerySmall,
                          // referral code
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
                                  Text(
                                    Provider.of<GetUserAccountInfoProvider>(context)
                                            .userAccountInfo
                                            ?.referralCode ??
                                        '',
                                  ),
                                  InkWell(
                                    onTap: () {
                                      UtilsClipboard.copyToClipboard(
                                        text: Provider.of<GetUserAccountInfoProvider>(context,
                                                    listen: false)
                                                .userAccountInfo
                                                ?.referralCode ??
                                            '',
                                        successMessage: AppMessage.copiedReferralCode,
                                      );
                                    },
                                    child: SvgPicture.asset(AppIcons.copy),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          AppDimens.vSpaceLarge,
                          Text(
                            AppString.inviteNote,
                            style: theme.textTheme.bodyMedium!.copyWith(
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                          // AppDimens.vSpaceMedium,
                          // Text(AppString.referralLink),
                          // AppDimens.vSpaceVerySmall,
                          // DecoratedBox(
                          //   decoration: BoxDecoration(
                          //     color: theme.cardTheme.color,
                          //     borderRadius: BorderRadius.circular(AppDimens.borderRadiusSmall),
                          //   ),
                          //   child: Padding(
                          //     padding: EdgeInsets.all(AppDimens.paddingMedium),
                          //     child: Row(
                          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //       children: [
                          //         Text('ostad.com/5A2B8C9D'),
                          //         SvgPicture.asset(AppIcons.copy),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          // AppDimens.vSpaceVerySmall,
                          // Text(
                          //   'برای نصب برنامه این لینک را به دوستانتان ارسال کنید.',
                          //   style: theme.textTheme.bodySmall!.copyWith(
                          //     color: theme.colorScheme.onSurface,
                          //   ),
                          // ),
                          // AppDimens.vSpaceLarge,
                          // Center(
                          //   child: Text(AppString.inviteYourFriends),
                          // ),
                          // AppDimens.vSpaceSmall,
                          // BulletText(text: AppString.howToInviteFriends),
                          // AppDimens.vSpaceSmall,
                          // BulletText(text: AppString.sendToFriends),
                          // AppDimens.vSpaceSmall,
                          // BulletText(text: AppString.afterRegisterAndFirstTransaction),
                          // AppDimens.vSpaceSmall,
                          // BulletText(text: AppString.copyReferralCode),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
